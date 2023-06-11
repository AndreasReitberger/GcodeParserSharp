using AndreasReitberger.API.OctoPrint.Models;
using AndreasReitberger.Core.Utilities;
using AndreasReitberger.Parser.Gcode.Enums;
using AndreasReitberger.Parser.Gcode.Slicer;
using CommunityToolkit.Mvvm.ComponentModel;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;

namespace AndreasReitberger.Parser.Gcode
{
    public partial class GcodeParser : BaseModel
    {
        #region Instance
        static GcodeParser _instance = null;
        static readonly object Lock = new();
        public static GcodeParser Instance
        {
            get
            {
                lock (Lock)
                {
                    if (_instance == null)
                        _instance = new GcodeParser();
                }
                return _instance;
            }

            set
            {
                if (_instance == value) return;
                lock (Lock)
                {
                    _instance = value;
                }
            }

        }
        #endregion

        #region Properties

        [ObservableProperty]
        CultureInfo cultureInfo;

        [ObservableProperty]
        SlicerPrinterConfiguration config;

        [ObservableProperty]
        List<SlicerInfo> supportedSlicers = new();

        [ObservableProperty]
        TimeSpan lastParsingDuration;

        #endregion     

        #region Constructor
        public GcodeParser()
        {
            Config = SlicerPrinterConfiguration.Default;
            SupportedSlicers = GcodeParserGlobalStaticConfig.SupportedSlicersForCommentRead;
        }
        public GcodeParser(SlicerPrinterConfiguration config)
        {
            SupportedSlicers = GcodeParserGlobalStaticConfig.SupportedSlicersForCommentRead;
            Config = config;
        }
        #endregion

        #region Methods

        #region Public
        public async Task<Gcode> FromFileAsync(string filePath, IProgress<int> prog, CancellationToken cancellationToken, bool useCommentRead = false, SlicerPrinterConfiguration config = null)
        {
            if (config != null)
            {
                Config = config;
            }
            return await ParseGcodeAsync(new Gcode(filePath), prog, cancellationToken, useCommentRead).ConfigureAwait(false);
        }
        public async Task<Gcode> FromGcodeAsync(Gcode gcode, IProgress<int> prog, CancellationToken cancellationToken, bool useCommentRead = false, SlicerPrinterConfiguration config = null)
        {
            if (config != null)
            {
                Config = config;
            }
            return await ParseGcodeAsync(gcode, prog, cancellationToken, useCommentRead).ConfigureAwait(false);
        }

        public Gcode FromOctoPrintFile(OctoPrintFile file)
        {
            var temp = new Gcode(file);
            if (file.GcodeAnalysis == null)
            {
                temp.IsValid = false;
                return temp;
            }

            double volume = Math.Round(file.GcodeAnalysis.Filament.Select(tool => tool.Value).Sum(filament => filament.Volume), 2);
            double length = Math.Round(file.GcodeAnalysis.Filament.Select(tool => tool.Value).Sum(filament => filament.Length), 2);

            temp.Width = (float)Math.Round(file.GcodeAnalysis.Dimensions.Width, 2);
            temp.Height = (float)Math.Round(file.GcodeAnalysis.Dimensions.Height, 2);
            temp.Depth = (float)Math.Round(file.GcodeAnalysis.Dimensions.Depth, 2);

            if (file.Statistics != null)
            {
                if (file.Statistics.AveragePrintTime != null && file.Statistics.AveragePrintTime.Default > 0)
                    temp.PrintTime = Math.Round(file.Statistics.AveragePrintTime.Default / 3600, 2);
                else
                    temp.PrintTime = Math.Round(file.GcodeAnalysis.EstimatedPrintTime / 3600, 2);
            }
            else
                temp.PrintTime = Math.Round(file.GcodeAnalysis.EstimatedPrintTime / 3600, 2);

            temp.ExtrudedFilamentVolume = volume;
            temp.FilamentUsed = length;

            temp.IsValid = true;
            return temp;
        }

        public string CommandsToText(Gcode gcode)
        {
            List<List<GcodeCommandLine>> cmds = gcode.Commands;
            StringBuilder sb = new();
            for (int i = 0; i < cmds.Count; i++)
            {
                List<GcodeCommandLine> list = cmds[i];
                sb.AppendLine($"Layer: {i}");
                for (int j = 0; j < list.Count; j++)
                {
                    GcodeCommandLine cmd = list[j];
                    sb.AppendLine($"{j}: x = {cmd.X} / y = {cmd.Y} / x = {cmd.X} | px = {cmd.PrevX} / py = {cmd.PrevY} / pz = {cmd.PrevZ} |" +
                        $"{(cmd.IsExtruding ? $"{cmd.Extruder} = {cmd.Extrusion} / " : "")} retract = {cmd.Retract} / speed = {cmd.Speed} ");
                }
            }
            return sb.ToString();
        }
        #endregion

        #region Private
        async Task<Gcode> ParseGcodeAsync(Gcode gcode, IProgress<int> prog, CancellationToken cancellationToken, bool useCommentRead)
        {
            try
            {
                gcode.IsWorking = true;
                TimeSpan start = DateTime.Now.TimeOfDay;
                IProgress<int> progress = prog;

                Dictionary<int, int> overallProgress = new()
                {
                    { 0, 0 },  // File reading & Parsing
                    { 2, 0 },  // Analyzing
                };

                gcode.IsValid = false;

                List<List<GcodeCommandLine>> commands = new();
                List<string> comments = new();
                Dictionary<double, int> zHeights = new();

                GcodeLineProcessResult result = new();
                using (FileStream fs = File.Open(gcode.FilePath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
                using (BufferedStream bs = new(fs))
                using (StreamReader sr = new(bs))
                {
                    long totalBytes = bs.Length;
                    long doneBytes = 0;

                    Dictionary<string, double> PreviousExtrusion = new()
                    {
                        { "a", 0 },
                        { "b", 0 },
                        { "c", 0 },
                        { "e", 0 },
                        { "abs", 0 },
                    };
                    Dictionary<string, double> PreviousRetraction = new()
                    {
                        { "a", 0 },
                        { "b", 0 },
                        { "c", 0 },
                        { "e", 0 },
                        { "abs", 0 },
                    };

                    double previousX = double.NegativeInfinity;
                    double previousY = double.NegativeInfinity;
                    double previousZ = double.NegativeInfinity;
                    double extrusion = 0;
                    double lastSpeed = 4000;
                    string extruder = string.Empty;
                    bool dcExtrude = false;
                    bool assumeNonDC = false;
                    int retract = 0;
                    bool extruding = false;
                    bool extrudeRelative = false;
                    int layer = 0;

                    string line;
                    GcodeCommandLine cmd = new();
                    while ((line = await sr.ReadLineAsync()) != null)
                    {
                        try
                        {
                            if (line == "G28 X Y")
                            {

                            }
                            if (!string.IsNullOrEmpty(line) && !line.Trim().StartsWith(";"))
                            {
                                if (line.StartsWith("G1"))
                                {

                                }

                                AppendGcodeCommand(line,
                                    ref cmd,
                                    ref PreviousExtrusion,
                                    ref PreviousRetraction,
                                    ref zHeights,
                                    ref previousX,
                                    ref previousY,
                                    ref previousZ,
                                    ref lastSpeed,
                                    ref retract,
                                    ref extrusion,
                                    ref extruder,
                                    ref extruding,
                                    ref extrudeRelative,
                                    ref dcExtrude,
                                    ref assumeNonDC,
                                    ref layer,
                                    commands.Count);
                                if (cmd.IsComplete)
                                {
                                    // Ensure that the list is not null
                                    if (commands.Count == 0 || commands.Count - 1 < layer || commands[layer] == null)
                                    {
                                        commands.Add(new List<GcodeCommandLine>());
                                    }
                                    commands[layer].Add(cmd);
                                    cmd = new GcodeCommandLine() { };
                                }

                            }
                            else
                                comments.Add(line);

                            // Report current progress
                            doneBytes += (sr.CurrentEncoding.GetBytes(line).Length);
                            double currentProgress = (doneBytes / (double)totalBytes) * 100f;
                            int roundedProgress = Convert.ToInt32(currentProgress);

                            bool report = false;
                            if (doneBytes < totalBytes)
                            {
                                // Only update if needed
                                if (overallProgress.ContainsKey(0) && overallProgress[0] < roundedProgress)
                                {
                                    Console.WriteLine($"Update progress: {roundedProgress}");
                                    overallProgress[0] = roundedProgress;
                                    report = true;
                                }
                            }
                            else
                            {
                                report = true;
                                overallProgress[0] = 100;
                            }
                            if (report && prog != null)
                            {
                                int completeProgress = overallProgress.Sum(pair => pair.Value) / overallProgress.Count;
                                prog.Report(completeProgress);
                            }
                        }
                        catch (Exception exc)
                        {
                            OnError(new UnhandledExceptionEventArgs(exc, false));
                            continue;
                        }
                    }
                }

                overallProgress[0] = 100;

                // Analyze
                for (int i = 0; i < commands.Count; i++)
                {
                    List<GcodeCommandLine> cmds = commands[i];
                    for (int j = 0; j < cmds.Count; j++)
                    {
                        GcodeCommandLine singleCmd = cmds[j];
                        ProcessSingleGcodeCommandLine(singleCmd, ref result, cancellationToken);
                        //result = ProcessSingleGcodeCommandLine(cmd, result, cancellationToken);
                    }

                    // Report current progress
                    //int currentProgress = (int)((i / commands.Count) * 100);
                    double currentProgress = (double)i / (double)commands.Count * 100f;
                    int roundedProgress = Convert.ToInt32(currentProgress);
                    bool report = false;
                    if (i < commands.Count)
                    {
                        // Only update if needed
                        if (overallProgress.ContainsKey(2) && overallProgress[2] < roundedProgress)
                        {
                            //Console.WriteLine($"Update progress: {roundedProgress}");
                            overallProgress[2] = roundedProgress;
                            report = true;
                        }
                    }
                    else
                    {
                        report = true;
                        overallProgress[2] = 100;
                    }
                    if (report && prog != null)
                    {
                        int completeProgress = overallProgress.Sum(pair => pair.Value) / overallProgress.Count;
                        prog.Report(completeProgress);
                    }
                }

                gcode.SlicerName = GetSlicerNameFromLines(comments.Take(30).ToList());
                SlicerInfo slicers = SupportedSlicers?.FirstOrDefault(slicer => slicer.SlicerName == gcode.SlicerName);

                // 29708.853619192618
                gcode.Comments = new List<string>(comments);
                gcode.Commands = new List<List<GcodeCommandLine>>(commands);
                gcode.ZHeights = zHeights;
                gcode.PrintTime = Math.Round(result.TotalPrintTime / 3600, 2);

                gcode.Width = (float)Math.Abs(result.MaxX - result.MinX);
                gcode.Depth = (float)Math.Abs(result.MaxY - result.MinY);
                gcode.Height = (float)Math.Abs(result.MaxZ - result.MinZ);

                gcode.Layers = commands.Count;

                gcode.FilamentUsed = Math.Round(result.TotalFilament, 2);
                gcode.ExtrudedFilamentVolume = Math.Round((((Math.PI * gcode.FilamentDiameter * gcode.FilamentDiameter) / 4f) * gcode.FilamentUsed / 1000f), 2);

                if (useCommentRead && slicers != null)
                {
                    // PrintTime
                    try
                    {
                        string parameter = GetParameterFromSlicer(gcode.SlicerName, SlicerParameter.PrintTime, comments);
                        if (parameter != "unkown_parameter")
                        {
                            double value = Convert.ToDouble(ConvertPrintTimeToDec(
                                parameter),
                                parameter.Contains(",") ? CultureInfo.GetCultureInfo("de-DE") : CultureInfo.GetCultureInfo("en-US"));
                            if (value != -1)
                                gcode.PrintTime = Math.Round(value, 2);
                        }
                    }
                    catch (Exception)
                    {
                        gcode.PrintTime = 0;
                    }
                    // Filament Diameter
                    try
                    {
                        string parameter = GetParameterFromSlicer(gcode.SlicerName, SlicerParameter.FilamentDiameter, comments);
                        if (parameter != "unkown_parameter")
                        {
                            if (parameter.Contains("|"))
                            {
                                string[] parts = parameter.Split(new string[] { "|" }, StringSplitOptions.RemoveEmptyEntries);
                                gcode.FilamentDiameters.AddRange(
                                    parts.Select(part => Convert.ToDouble(part,
                                    part.Contains(",") ? CultureInfo.GetCultureInfo("de-DE") : CultureInfo.GetCultureInfo("en-US"))));
                            }
                            else
                            {
                                double value = Convert.ToDouble(parameter,
                                    parameter.Contains(",") ? CultureInfo.GetCultureInfo("de-DE") : CultureInfo.GetCultureInfo("en-US"));
                                if (value != -1)
                                {
                                    gcode.FilamentDiameter = Convert.ToDouble(GetParameterFromSlicer(gcode.SlicerName, SlicerParameter.FilamentDiameter, comments), CultureInfo.GetCultureInfo("en-US"));

                                    gcode.FilamentDiameters = new();
                                    gcode.FilamentDiameters.Add(gcode.FilamentDiameter);
                                }
                            }
                        }
                    }
                    catch (Exception)
                    {
                        gcode.FilamentDiameter = 0;
                    }
                    // Nozzle Diameter
                    try
                    {
                        string parameter = GetParameterFromSlicer(gcode.SlicerName, SlicerParameter.NozzleDiameter, comments);
                        if (parameter != "unkown_parameter")
                        {
                            if (parameter.Contains("|"))
                            {
                                string[] parts = parameter.Split(new string[] { "|" }, StringSplitOptions.RemoveEmptyEntries);
                                gcode.NozzleDiameters.AddRange(
                                    parts.Select(part => Convert.ToDouble(part,
                                    part.Contains(",") ? CultureInfo.GetCultureInfo("de-DE") : CultureInfo.GetCultureInfo("en-US"))));
                            }
                            else
                            {
                                double value = Convert.ToDouble(parameter,
                                    parameter.Contains(",") ? CultureInfo.GetCultureInfo("de-DE") : CultureInfo.GetCultureInfo("en-US"));
                                if (value != -1)
                                {
                                    gcode.NozzleDiameter = value;
                                    gcode.NozzleDiameters = new List<double>
                                    {
                                        gcode.NozzleDiameter
                                    };
                                }
                            }
                        }
                    }
                    catch (Exception)
                    {
                        gcode.NozzleDiameter = 0;
                    }
                    // FilamentType
                    try
                    {
                        string parameter = GetParameterFromSlicer(gcode.SlicerName, SlicerParameter.FilamentType, comments);
                        if (parameter != "unkown_parameter")
                        {
                            if (parameter.Contains("|"))
                            {
                                string[] parts = parameter.Split(new string[] { "|" }, StringSplitOptions.RemoveEmptyEntries);
                                gcode.FilamentTypes.AddRange(parts);
                            }
                            else
                            {
                                gcode.FilamentType = parameter;
                                gcode.FilamentTypes = new List<string>
                                {
                                    gcode.FilamentType
                                };
                            }
                        }
                        else
                            gcode.FilamentType = string.Empty;
                    }
                    catch (Exception)
                    {
                        gcode.FilamentType = string.Empty;
                    }
                    // FilamentDensity
                    try
                    {
                        string parameter = GetParameterFromSlicer(gcode.SlicerName, SlicerParameter.FilamentDensity, comments);
                        if (parameter != "unkown_parameter")
                        {
                            if (parameter.Contains("|"))
                            {
                                string[] parts = parameter.Split(new string[] { "|" }, StringSplitOptions.RemoveEmptyEntries);
                                gcode.FilamentDensities.AddRange(
                                    parts.Select(part => Convert.ToDouble(part,
                                    part.Contains(",") ? CultureInfo.GetCultureInfo("de-DE") : CultureInfo.GetCultureInfo("en-US"))));
                            }
                            else
                            {
                                double value = Convert.ToDouble(parameter,
                                    parameter.Contains(",") ? CultureInfo.GetCultureInfo("de-DE") : CultureInfo.GetCultureInfo("en-US"));
                                if (value != -1)
                                {
                                    gcode.FilamentDensity = value;
                                    gcode.FilamentDensities = new List<double>
                                    {
                                        gcode.FilamentDensity
                                    };
                                }
                            }
                        }
                    }
                    catch (Exception)
                    {
                        gcode.FilamentDensity = 0;
                    }
                    // Filament used [mm]
                    try
                    {
                        var parameter = GetParameterFromSlicer(gcode.SlicerName, SlicerParameter.FilamentUsed, comments);
                        if (parameter != "unkown_parameter")
                        {
                            if (parameter.Contains("|"))
                            {
                                string[] parts = parameter.Split(new string[] { "|" }, StringSplitOptions.RemoveEmptyEntries);
                                gcode.FilamentUsage.AddRange(
                                    parts.Select(part => Convert.ToDouble(part,
                                    part.Contains(",") ? CultureInfo.GetCultureInfo("de-DE") : CultureInfo.GetCultureInfo("en-US"))));
                            }
                            else
                            {
                                double value = Convert.ToDouble(parameter,
                                    parameter.Contains(",") ? CultureInfo.GetCultureInfo("de-DE") : CultureInfo.GetCultureInfo("en-US"));
                                if (value != -1)
                                {
                                    gcode.FilamentUsed = Math.Round(value, 2);
                                    gcode.FilamentUsage = new List<double>
                                    {
                                        gcode.FilamentUsed
                                    };
                                }
                            }
                        }
                    }
                    catch (Exception)
                    {
                        gcode.FilamentUsed = 0;
                    }
                    // Volume
                    try
                    {
                        string parameter = GetParameterFromSlicer(gcode.SlicerName, SlicerParameter.Volume, comments);
                        if (parameter != "unkown_parameter")
                        {
                            double value = Convert.ToDouble(parameter,
                                parameter.Contains(",") ? CultureInfo.GetCultureInfo("de-DE") : CultureInfo.GetCultureInfo("en-US"));
                            if (value != -1)
                                gcode.ExtrudedFilamentVolume = Math.Round(value, 2);
                        }
                        else
                        {
                            if (gcode.FilamentUsage.Count > 0)
                            {
                                gcode.ExtrudedFilamentVolume = 0;
                                double volume = 0;
                                double diameter = 1.75;
                                for (int i = 0; i < gcode.FilamentUsage.Count; i++)
                                {
                                    double usage = gcode.FilamentUsage[i];
                                    if (i < gcode.FilamentDiameters.Count)
                                        diameter = gcode.FilamentDiameters[i];

                                    volume = Math.Round((((Math.PI * diameter * diameter) / 4f) * usage / 1000f), 2);
                                    gcode.ExtrudedFilamentVolume += volume;
                                }
                                //gcode.ExtrudedFilamentVolume = Math.Round((((Math.PI * gcode.Diameter * gcode.Diameter) / 4f) * gcode.FilamentUsed / 1000f), 2);

                            }
                        }

                    }
                    catch (Exception)
                    {
                        gcode.ExtrudedFilamentVolume = 0;
                    }
                    gcode.IsValid = true;
                }
                else
                {

                }
                TimeSpan end = DateTime.Now.TimeOfDay;
                gcode.ParsingDuration = LastParsingDuration = end - start;

                gcode.IsWorking = false;

                commands.Clear();
                comments.Clear();
                commands = null;
                comments = null;

                return gcode;
            }
            catch (Exception exc)
            {
                OnError(new UnhandledExceptionEventArgs(exc, false));
                gcode.IsWorking = false;
                return null;
            }
        }

        void AppendGcodeCommand(
            string nextLine,
            ref GcodeCommandLine cmd,
            ref Dictionary<string, double> previousExtrusion,
            ref Dictionary<string, double> previousRetraction,
            ref Dictionary<double, int> zHeights,
            ref double previousX,
            ref double previousY,
            ref double previousZ,
            ref double lastSpeed,
            ref int retract,
            ref double extrusion,
            ref string extruder,
            ref bool extruding,
            ref bool extrudeRelative,
            ref bool dcExtruder,
            ref bool assumeNonDC,
            ref int layer,
            int currentLayer
            )
        {
            //GCodeCommandLine cmd = previousCommand ?? new GCodeCommandLine();

            var gcode = cmd.Gcode = Regex.Split(nextLine, @"\;")[0].TrimEnd();
            //string[] args = gcode.ToLower().TrimEnd().Split(' ');
            string[] args = gcode.ToLower().TrimEnd().Split(' ');

            // Reset values for next calculation
            double X = double.NegativeInfinity;
            double Y = double.NegativeInfinity;
            double Z = double.NegativeInfinity;

            double volumePerMM = 0;
            retract = 0;
            extruding = false;
            extruder = string.Empty;
            previousExtrusion["abs"] = 0;

            if (args[0] == "g0" || args[0] == "g1")
            {
                for (int j = 1; j < args.Length; j++)
                {
                    string arg = args[j];
                    if (string.IsNullOrEmpty(arg))
                        continue;
                    switch (arg[0])
                    {
                        case 'x':
                            X = double.Parse(arg.TrimStart(arg[0]), CultureInfo.InvariantCulture);
                            break;
                        case 'y':
                            Y = double.Parse(arg.TrimStart(arg[0]), CultureInfo.InvariantCulture);
                            break;
                        case 'z':
                            Z = double.Parse(arg.TrimStart(arg[0]), CultureInfo.InvariantCulture);
                            if (Z == previousZ)
                            {
                                continue;
                            }
                            if (zHeights.ContainsKey(Z))
                            {
                                layer = zHeights[Z];
                            }
                            else
                            {
                                layer = currentLayer;
                                zHeights[Z] = layer;
                            }

                            //previousZ = Z;
                            break;
                        case 'e':
                        case 'a':
                        case 'b':
                        case 'c':
                            assumeNonDC = true;
                            // These 4 cases appear to map to different extruders
                            //extruder = arg[0];
                            extruder = arg[0].ToString();
                            //var t = arg.TrimStart(arg[0]);
                            extrusion = double.Parse(arg.TrimStart(arg[0]), CultureInfo.InvariantCulture);
                            if (!extrudeRelative)
                                // Absolute positioning
                                previousExtrusion["abs"] = extrusion - previousExtrusion[extruder];
                            else
                                previousExtrusion["abs"] = extrusion;


                            extruding = previousExtrusion["abs"] > 0;

                            if (previousExtrusion["abs"] < 0)
                            {
                                //We're retracting...
                                previousRetraction[extruder] = -1;
                                retract = -1;
                            }
                            else if (previousExtrusion["abs"] == 0)
                            {
                                retract = 0;
                            }
                            else if (previousExtrusion["abs"] > 0 && previousRetraction[extruder] < 0)
                            {
                                previousRetraction[extruder] = 0;
                                retract = 1;
                            }
                            else
                            {
                                retract = 0;
                            }

                            //previousExtrusion[sExtruder] = extrusion;
                            previousExtrusion[extruder] = extrusion;
                            break;
                        case 'f':
                            extrusion = double.Parse(arg.TrimStart(arg[0]), CultureInfo.InvariantCulture);
                            lastSpeed = extrusion;
                            break;
                        default:
                            break;
                    }
                }

                if (dcExtruder && !assumeNonDC)
                {
                    extruding = true;
                    //extruding = true;
                    previousExtrusion["abs"] = (double)Math.Sqrt((previousX - X) * (previousX - X) + (previousY - Y) * (previousY - Y));
                }

                if (extruding && retract == 0)
                {

                    // 
                    volumePerMM = previousExtrusion["abs"] / (double)Math.Sqrt(
                        ((double)(previousX - X)) * ((double)(previousX - X)) +
                        ((double)(previousY - Y)) * ((double)(previousY - Y))

                        );
                }

                if (double.IsNegativeInfinity(previousZ)) previousZ = 0;

                cmd.Command = args[0];
                cmd.X = X;
                cmd.Y = Y;
                cmd.Z = Z;
                cmd.Speed = lastSpeed;
                cmd.IsExtruding = extruding;
                cmd.Retract = retract;
                cmd.NoMove = false;
                cmd.Extrusion = (extruding || retract != 0) ? previousExtrusion["abs"] : 0;
                cmd.Extruder = extruder;
                cmd.PrevX = previousX;
                cmd.PrevY = previousY;
                cmd.PrevZ = previousZ;
                cmd.VolumePerMM = double.IsNaN(volumePerMM) || double.IsInfinity(volumePerMM) ? -1 : volumePerMM;
                cmd.IsComplete = true;

                if (!double.IsNegativeInfinity(X)) previousX = X;
                if (!double.IsNegativeInfinity(Y)) previousY = Y;
                previousZ = Z;
            }
            else if (args[0] == "m82")
            {
                extrudeRelative = false;
            }
            else if (args[0] == "g91")
            {
                extrudeRelative = true;
            }
            else if (args[0] == "g90")
            {
                extrudeRelative = false;
            }
            else if (args[0] == "m83")
            {
                extrudeRelative = true;
                /*
                if (!previousG90Found)
                    extrudeRelative = true;
                else
                {
                    extrudeRelative = false;
                    previousG90Found = false;
                }
                */
            }
            else if (args[0] == "m101")
            {
                dcExtruder = true;
                //throw new NotImplementedException();
            }
            else if (args[0] == "M103")
            {
                dcExtruder = false;
                //throw new NotImplementedException();
            }

            else if (args[0] == "g92")
            {
                for (int j = 1; j < args.Length; j++)
                {
                    string arg = args[j];
                    if (string.IsNullOrEmpty(arg))
                        continue;
                    switch (arg[0])
                    {
                        case 'x':
                            X = double.Parse(arg.TrimStart(arg[0]), CultureInfo.InvariantCulture);
                            break;
                        case 'y':
                            Y = double.Parse(arg.TrimStart(arg[0]), CultureInfo.InvariantCulture);
                            break;
                        case 'z':
                            Z = double.Parse(arg.TrimStart(arg[0]), CultureInfo.InvariantCulture);
                            previousZ = Z;
                            break;
                        case 'e':
                        case 'a':
                        case 'b':
                        case 'c':
                            // These 4 cases appear to map to different extruders
                            //extruder = arg[0];
                            extruder = arg[0].ToString();
                            //var t = arg.TrimStart(arg[0]);
                            extrusion = double.Parse(arg.TrimStart(arg[0]), CultureInfo.InvariantCulture);
                            if (!extrudeRelative)
                            {
                                // Absolute positioning
                                //cmd.Extrusion = 0;
                                previousExtrusion[extruder] = 0;
                            }
                            else
                            {
                                previousExtrusion[extruder] = extrusion;
                            }
                            break;
                        default:
                            break;
                    }
                    // if(typeof(x) !== 'undefined' || typeof(y) !== 'undefined' ||typeof(z) !== 'undefined')
                    if (!double.IsNegativeInfinity(X) || !double.IsNegativeInfinity(Y) || !double.IsNegativeInfinity(Z))
                    {
                        cmd.Command = args[0];
                        cmd.X = X;
                        cmd.Y = Y;
                        cmd.Z = Z;
                        cmd.Speed = lastSpeed;
                        cmd.IsExtruding = extruding;
                        cmd.Retract = retract;
                        cmd.NoMove = true;
                        cmd.Extrusion = 0;
                        cmd.Extruder = extruder;
                        cmd.PrevX = previousX;
                        cmd.PrevY = previousY;
                        cmd.PrevZ = previousZ;
                        cmd.IsComplete = true;
                    }
                }
            }
            else if (args[0] == "g28")
            {
                for (int j = 1; j < args.Length; j++)
                {
                    string arg = args[j];
                    if (string.IsNullOrEmpty(arg))
                        continue;
                    switch (arg[0])
                    {
                        case 'x':
                            if (arg.Length > 1)
                            {
                                X = double.Parse(arg.TrimStart(arg[0]), CultureInfo.InvariantCulture);
                            }
                            break;
                        case 'y':
                            if (arg.Length > 1)
                            {
                                Y = double.Parse(arg.TrimStart(arg[0]), CultureInfo.InvariantCulture);
                            }
                            break;
                        case 'z':
                            if (arg.Length > 1)
                            {
                                Z = double.Parse(arg.TrimStart(arg[0]), CultureInfo.InvariantCulture);
                            }
                            if (Z == previousZ)
                            {
                                continue;
                            }
                            else
                            {
                                layer = currentLayer;
                                //cmd.LayerChanges++;
                            }
                            previousZ = Z;
                            break;
                        case 'e':
                        case 'a':
                        case 'b':
                        case 'c':

                            break;
                        default:
                            break;
                    }
                }
                // G28 with no arguments
                if (args.Length == 1)
                {
                    //need to init values to default here
                }
                // if it's the first layer and G28 was without
                if (layer == 0 && double.IsNegativeInfinity(Z))
                {
                    Z = 0;
                    if (zHeights.ContainsKey(Z))
                        layer = zHeights[Z];
                    else
                    {
                        layer = currentLayer;
                        //zHeights.Add(Z, cmd.Layer);
                        zHeights[Z] = layer;
                    }
                    previousZ = Z;
                }

                cmd.Command = args[0];
                cmd.X = X;
                cmd.Y = Y;
                cmd.Z = Z;
                cmd.Speed = lastSpeed;
                cmd.IsExtruding = extruding;
                cmd.Retract = retract;
                cmd.Extrusion = (extruding || retract != 0) ? previousExtrusion["abs"] : 0;
                cmd.Extruder = extruder;
                cmd.PrevX = previousX;
                cmd.PrevY = previousY;
                cmd.PrevZ = previousZ;
                cmd.IsComplete = true;
            }
            //return cmd;
        }

        void ProcessSingleGcodeCommandLine(GcodeCommandLine command, ref GcodeLineProcessResult result, CancellationToken cancellationToken)
        {

            if (cancellationToken.IsCancellationRequested)
                return; // null;

            double tmp1 = 0;
            double tmp2 = 0;
            double speedDivider = 60 * (Config != null ? Config.PrintDurationCorrection : 1);
            result.PrintTimeAddition = 0;

            result.ValidX = false;
            result.ValidY = false;

            result.LastSpeed = command.Speed;

            if (!double.IsInfinity(command.X) && !double.IsInfinity(command.PrevX) && !double.IsNaN(command.X))
            {
                if (command.IsExtruding)
                {
                    result.MaxX = (result.MaxX > command.X) ? result.MaxX : command.X;
                    result.MaxX = (result.MaxX > command.PrevX) ? result.MaxX : command.PrevX;
                    result.MinX = (result.MinX < command.X) ? result.MinX : command.X;
                    result.MinX = (result.MinX < command.PrevX) ? result.MinX : command.PrevX;
                    result.ValidX = true;
                }
                // Calculate travel speed
            }

            if (!double.IsInfinity(command.Y) && !double.IsInfinity(command.PrevY) && !double.IsNaN(command.Y))
            {
                if (command.IsExtruding)
                {
                    result.MaxY = (result.MaxY > command.Y) ? result.MaxY : command.Y;
                    result.MaxY = (result.MaxY > command.PrevY) ? result.MaxY : command.PrevY;
                    result.MinY = (result.MinY < command.Y) ? result.MinY : command.Y;
                    result.MinY = (result.MinY < command.PrevY) ? result.MinY : command.PrevY;
                    result.ValidY = true;
                }

            }

            if (!double.IsInfinity(command.Z) && !double.IsInfinity(command.PrevZ) && !command.IsExtruding && !double.IsNaN(command.Z))
            {
                // Calculate time for z movements
                result.ValidZ = true;
                double s = (double)(command.Z - command.PrevZ);
                double temp = CalculateTime(s, command.Speed / speedDivider, Config.AMax_z);
                //var temp = s / command.Speed / speedDivider;
                if (double.IsNaN(temp) || double.IsInfinity(temp))
                {

                }
                else
                {
                    //result.TotalPrintTime += temp;
                    result.PrintTimeAddition += temp;
                }
            }

            if ((result.ValidX && !result.ValidY) || (result.ValidY && !result.ValidX))
            {

            }

            if (!double.IsInfinity(command.PrevZ) && command.IsExtruding && !double.IsNaN(command.PrevZ))
            {
                result.MaxZ = (result.MaxZ > command.PrevZ) ? result.MaxZ : command.PrevZ;
                result.MinZ = (result.MinZ < command.PrevZ) ? result.MinZ : command.PrevZ;

            }

            if (command.IsExtruding || command.Retract != 0)
            {
                //Model.TotalFilament += command.Extrusion;
                result.TotalFilament += command.Extrusion;
            }
            // Calculate time for X, Y movements (with and without extrusion)
            if (result.ValidX && result.ValidY)
            {
                // distance to travel in mm
                double s = (double)Math.Sqrt(Math.Pow((command.X) - (command.PrevX), 2) + Math.Pow((command.Y) - (command.PrevY), 2));

                double temp = CalculateTime(s, command.Speed / speedDivider, Config.AMax_xy);
                if (double.IsNaN(temp) || double.IsInfinity(temp))
                {

                }
                else
                {
                    result.PrintTimeAddition += temp; // (float)Math.Sqrt(Math.Pow((command.X) - (command.PreviousX), 2) + Math.Pow((command.Y) - (command.PreviousY), 2)) / (command.Speed / 60);
                }
            }
            // Calculate time for extrusion
            else if (command.Retract == 0 && command.Extrusion != 0)
            {

                double s = (double)Math.Sqrt(Math.Pow((command.X) - (command.PrevX), 2) + Math.Pow((command.Y) - (command.PrevY), 2));
                tmp1 = CalculateTime(s, command.Speed / speedDivider, Config.AMax_e);

                tmp2 = CalculateTime(Math.Abs(command.Extrusion), command.Speed / speedDivider, Config.AMax_eExtrude);
                // If both value are invalid
                if ((double.IsNaN(tmp1) || double.IsInfinity(tmp1)) && (double.IsNaN(tmp2) || double.IsInfinity(tmp2)))
                {

                }
                else
                {
                    // If movement is invalid
                    if (double.IsNaN(tmp1) || double.IsInfinity(tmp1))
                    {
                        result.PrintTimeAddition += tmp2;
                    }
                    // If extrusion is invalid
                    else if (double.IsNaN(tmp2) || double.IsInfinity(tmp2))
                    {
                        result.PrintTimeAddition += tmp1;
                    }
                    // If both valid, take the one who takes longer.
                    else
                    {
                        //result.TotalPrintTime += tmp1 > tmp2 ? tmp1 : tmp2;
                        result.PrintTimeAddition += tmp1 > tmp2 ? tmp1 : tmp2;
                    }
                }

            }
            // Calculate time for retract
            else if (command.Retract != 0)
            {
                double s = (double)Math.Sqrt(Math.Pow((command.X) - (command.PrevX), 2) + Math.Pow((command.Y) - (command.PrevY), 2));
                tmp1 = CalculateTime(s, command.Speed / speedDivider, Config.AMax_e);
                //tmp2 = Math.Abs(command.Extrusion / (command.Speed / speedDivider));
                tmp2 = CalculateTime(Math.Abs(command.Extrusion), command.Speed / speedDivider, Config.AMax_eRetract);
                // If both value are invalid
                if ((double.IsNaN(tmp1) || double.IsInfinity(tmp1)) && (double.IsNaN(tmp2) || double.IsInfinity(tmp2)))
                {

                }
                else
                {
                    // If movement is invalid
                    if (double.IsNaN(tmp1) || double.IsInfinity(tmp1))
                    {
                        result.PrintTimeAddition += tmp2;
                    }
                    // If extrusion is invalid
                    else if (double.IsNaN(tmp2) || double.IsInfinity(tmp2))
                    {
                        result.PrintTimeAddition += tmp1;
                    }
                    // If both valid, take the one who takes longer.
                    else
                    {
                        result.PrintTimeAddition += tmp1 > tmp2 ? tmp1 : tmp2;
                    }
                }
            }

            result.TotalPrintTime += result.PrintTimeAddition;

            if (command.IsExtruding && command.Retraction == 0 && result.ValidX && result.ValidY)
            {

            }

        }

        double CalculateTime(double distance, double speed, double maxAcceleration)
        {
            double temp = 0;
            if (distance == 0) return temp;

            double tAcceleration = speed / maxAcceleration;
            double sAcceleration = (double)((maxAcceleration / 2) * Math.Pow(tAcceleration, 2));

            double tConstant = (double)((distance - sAcceleration) / speed);
            temp = tConstant > 0 ? tAcceleration + tConstant : (double)Math.Sqrt(2 * distance / maxAcceleration);
            return temp;
        }
        decimal ConvertPrintTimeToDec(string printTime)
        {
            // If already passed as double string
            //if (Regex.IsMatch(printTime, @"(\d+(\.\d+)?)|(\.\d+)"))
            if (Regex.IsMatch(printTime, @"^((\d+((\.|\,)\d+)?)|((\.|\,)\d+))$"))
            {
                return Convert.ToDecimal(printTime);
            }
            else if (Regex.IsMatch(printTime, @"(\d+:\d+:\d+:\d+)"))
            {
                string[] time = printTime.Split(':');
                TimeSpan ts = new(
                    Convert.ToInt32(time[0]),   // days
                    Convert.ToInt32(time[1]),   // hours
                    Convert.ToInt32(time[2]),   // minutes
                    Convert.ToInt32(time[3]));  // seconds
                return Convert.ToDecimal(ts.TotalHours); // ts.TotalHours.ToString();
            }
            else
            {
                string[] time = printTime.Split(' ');
                string timestring;
                if (time.Contains("hour") || time.Contains("hours")
                    || time.Contains("minutes") || time.Contains("minute")
                    || time.Contains("seconds") || time.Contains("second")
                    )
                {
                    string h = "0", m = "0", s = "0";
                    for (int i = 1; i < time.Length; i += 2)
                    {
                        if (time[i] == "hour" || time[i] == "hours")
                        {
                            h = time[i - 1];
                        }
                        else if (time[i] == "minutes" || time[i] == "minute")
                        {
                            m = time[i - 1];
                        }
                        else if (time[i] == "seconds" || time[i] == "second")
                        {
                            s = time[i - 1];
                        }
                    }
                    timestring = string.Format("{0}:{1}:{2}", h, m, s);
                }
                else
                {
                    timestring = time.Count() switch
                    {
                        4 => string.Format("{0}:{1}:{2}:{3}",
                                time[0].Replace("d", string.Empty),
                                time[1].Replace("h", string.Empty),
                                time[2].Replace("m", string.Empty),
                                time[3].Replace("s", string.Empty)
                                ),
                        3 => string.Format("{0}:{1}:{2}",
                                time[0].Replace("h", string.Empty),
                                time[1].Replace("m", string.Empty),
                                time[2].Replace("s", string.Empty)
                                ),
                        2 => string.Format("{0}:{1}:{2}",
                                "0",
                                time[0].Replace("m", string.Empty),
                                time[1].Replace("s", string.Empty)
                                ),
                        1 => string.Format("{0}:{1}:{2}",
                              "0",
                              "0",
                      time[0].Replace("s", string.Empty)
                      ),
                        _ => throw new Exception(string.Format("Unknown time string format: {0}", printTime)),
                    };
                }
                TimeSpan dt = TimeSpan.Parse(timestring);
                return Convert.ToDecimal(dt.TotalHours);
            }

        }
        SlicerName GetSlicerNameFromLines(List<string> lines)
        {
            for (int i = 0; i < lines.Count; i++)
            {
                string slicerLine = lines[i];
                if (slicerLine.Contains("Slic3r"))
                    return SlicerName.Slic3r;
                else if (slicerLine.Contains("PrusaSlicer"))
                    return SlicerName.PrusaSlicer;
                else if (slicerLine.Contains("KISSlicer"))
                    return SlicerName.KISSlicer;
                else if (slicerLine.Contains("skeinforge"))
                    return SlicerName.Skeinforge;
                else if (slicerLine.Contains("CURA_PROFILE_STRING") || slicerLine.Contains("Cura") || slicerLine.Contains("Cura_SteamEngine"))
                    return SlicerName.Cura;
                else if (slicerLine.Contains("Miracle"))
                    return SlicerName.Makerbot;
                else if (slicerLine.Contains("ffslicer"))
                    return SlicerName.FlashForge;
                else if (slicerLine.Contains("Simplify3D"))
                    return SlicerName.Simplify3D;
                else if (slicerLine.Contains("Snapmaker"))
                    return SlicerName.Snapmakerjs;
                else if (slicerLine.Contains("ideaMaker"))
                    return SlicerName.IdeaMaker;
                else if (slicerLine.Contains("Voxelizer 2"))
                    return SlicerName.Voxelizer2;
                else if (slicerLine.Contains("CraftWare"))
                    return SlicerName.CraftWare;
                else if (slicerLine.Contains("OrcaSlicer"))
                    return SlicerName.OrcaSlicer;
                else if (slicerLine.Contains("BambuStudio"))
                    return SlicerName.BambuStudio;
                else
                {
                    continue;
                }
            }
            return SlicerName.Unkown;
        }
        string GetParameterFromSlicer(SlicerName Slicer, SlicerParameter Parameter, List<string> Lines)
        {
            try
            {
                Regex myregex;
                List<string> lines = new();
                string unknown = "unkown_parameter";
                switch (Slicer)
                {
                    case SlicerName.Slic3r:
                        switch (Parameter)
                        {
                            case SlicerParameter.Volume:
                                myregex = new Regex(@"[;]\s*filament used\s*=\s*(\d*\.\d+)mm\s*[(](\d*\.\d+)cm3[)]");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"\(([^)]*)cm3\)").Groups[1].Value;
                            case SlicerParameter.PrintTime:
                                myregex = new Regex(@"[;]\s*estimated printing time \(normal mode\)\s*=*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"((\d*h\s*\d*m\s\d*s)|(\d*m\s\d*s)|(\d{1,}s))").Groups[1].Value;
                            case SlicerParameter.PrintTimeSilent:
                                myregex = new Regex(@"[;]\s*estimated printing time \(silent mode\)\s*=*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"((\d*h\s*\d*m\s\d*s)|(\d*m\s\d*s)|(\d{1,}s))").Groups[1].Value;
                            case SlicerParameter.FilamentDiameter:
                                myregex = new Regex(@"[;]\s*filament_diameter\s*=\s*\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"([^ =\s](\d*.\d\d))").Groups[1].Value;
                            case SlicerParameter.NozzleDiameter:
                                myregex = new Regex(@"[;]\s*nozzle_diameter\s*=\s*\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"([^ =\s](\d*.\d{1,2}))").Groups[1].Value;
                            case SlicerParameter.FilamentType:
                                myregex = new Regex(@"[;]\s*filament_type\s*=\s*([A-Z])*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"([^ =\s]([A-Z]\w))").Groups[1].Value;
                            case SlicerParameter.FilamentDensity:
                                myregex = new Regex(@"[;]\s*filament_density\s*=\s*\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"([^ =\s](\d*.\d{1,2}))|([^ =\s]([0-9]*$))").Groups[1].Value;
                            default:
                                return unknown;
                        }
                    case SlicerName.PrusaSlicer:
                        switch (Parameter)
                        {
                            case SlicerParameter.Volume:
                                myregex = new Regex(@"[;]\s*filament used\s*\[cm3\]\s*=\s*\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"(\s\d*.\d{1,2})").Groups[1].Value;
                            case SlicerParameter.FilamentUsed:
                                myregex = new Regex(@"[;]\s*filament used\s*\[mm\]\s*=\s*\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"(\s\d*.\d{1,2})").Groups[1].Value;
                            case SlicerParameter.PrintTime:
                                //myregex = new Regex(@"[;]\s*estimated printing time \(normal mode\)\s*=\s*\d*h\s*\d*m\s*\d*s");
                                myregex = new Regex(@"[;]\s*estimated printing time \(normal mode\)\s*=*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"((\d*d\s\d*h\s*\d*m\s\d*s)|(\d*h\s*\d*m\s\d*s)|(\d*m\s\d*s)|(\d{1,}s))").Groups[1].Value;
                            case SlicerParameter.PrintTimeSilent:
                                myregex = new Regex(@"[;]\s*estimated printing time \(silent mode\)\s*=*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"((\d*d\s\d*h\s*\d*m\s\d*s)|(\d*h\s*\d*m\s\d*s)|(\d*m\s\d*s)|(\d{1,}s))").Groups[1].Value;
                            case SlicerParameter.FilamentDiameter:
                                myregex = new Regex(@"[;]\s*filament_diameter\s*=\s*\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"([^ =\s](\d*.\d\d))").Groups[1].Value;
                            case SlicerParameter.NozzleDiameter:
                                myregex = new Regex(@"[;]\s*nozzle_diameter\s*=\s*\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"([^ =\s](\d*.\d{1,2}))").Groups[1].Value;
                            case SlicerParameter.FilamentType:
                                myregex = new Regex(@"[;]\s*filament_type\s*=\s*([A-Z])*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"([^ =\s]([A-Z]\w))").Groups[1].Value;
                            case SlicerParameter.FilamentDensity:
                                myregex = new Regex(@"[;]\s*filament_density\s*=\s*\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"([^ =\s](\d*.\d{1,2}))").Groups[1].Value;
                            default:
                                return unknown;
                        }
                    case SlicerName.OrcaSlicer:
                        switch (Parameter)
                        {
                            case SlicerParameter.Volume:
                                myregex = new Regex(@"[;]\s*filament used\s*\[cm3\]\s*=\s*\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"(\s\d*.\d{1,2})").Groups[1].Value;
                            case SlicerParameter.FilamentUsed:
                                myregex = new Regex(@"[;]\s*filament used\s*\[mm\]\s*=\s*\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"(\s\d*.\d{1,2})").Groups[1].Value;
                            case SlicerParameter.PrintTime:
                                //myregex = new Regex(@"[;]\s*estimated printing time \(normal mode\)\s*=\s*\d*h\s*\d*m\s*\d*s");
                                myregex = new Regex(@"[;]\s*total estimated time\s*=*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                // Result looks like, we need the second paramater "; model printing time: 8m 6s; total estimated time: 15m 26s"
                                string targetTotalPrintTime = lines.FirstOrDefault()?.Split(new string[] { ";" }, StringSplitOptions.RemoveEmptyEntries).LastOrDefault()?.Trim();
                                return Regex.Match(targetTotalPrintTime, @"((\d*d\s\d*h\s*\d*m\s\d*s)|(\d*h\s*\d*m\s\d*s)|(\d*m\s\d*s)|(\d{1,}s))").Groups[1].Value;
                            case SlicerParameter.PrintTimeModel:
                                myregex = new Regex(@"[;]\s*model printing time\s*=*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                // Result looks like, we need the second paramater "; model printing time: 8m 6s; total estimated time: 15m 26s"
                                string targetModelPrintTime = lines.FirstOrDefault()?.Split(new string[] { ";" }, StringSplitOptions.RemoveEmptyEntries).FirstOrDefault()?.Trim();
                                return Regex.Match(targetModelPrintTime, @"((\d*d\s\d*h\s*\d*m\s\d*s)|(\d*h\s*\d*m\s\d*s)|(\d*m\s\d*s)|(\d{1,}s))").Groups[1].Value;
                            case SlicerParameter.FilamentDiameter:
                                // ; filament_diameter = 1.75,1.75,1.75
                                myregex = new Regex(@"[;]\s*filament_diameter\s*=\s*\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                Regex pattern = new(@"(?<=)(\d+(\.\d+)?)|(\.\d+)");
                                string filamentDiameters = ConcatNumericDataString(lines.FirstOrDefault(), ",", CultureInfo.GetCultureInfo("en-US"), pattern);
                                return filamentDiameters;
                            case SlicerParameter.NozzleDiameter:
                                // ; nozzle_diameter = 0.4
                                myregex = new Regex(@"[;]\s*nozzle_diameter\s*=\s*\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"([^ =\s](\d*.\d{1,2}))").Groups[1].Value;
                            case SlicerParameter.FilamentType:
                                myregex = new Regex(@"[;]\s*filament_type\s*=\s*([A-Z])*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                string filamentTypes = ConcatDataString(lines.FirstOrDefault(), ";", CultureInfo.GetCultureInfo("en-US"));
                                return filamentTypes;
                            case SlicerParameter.FilamentDensity:
                                // ; filament_density = 1.08,1.08,1.08
                                myregex = new Regex(@"[;]\s*filament_density\s*=\s*\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                Regex patternDensity = new(@"(?<=)(\d+(\.\d+)?)|(\.\d+)");
                                string filamenDensities = ConcatNumericDataString(lines.FirstOrDefault(), ",", CultureInfo.GetCultureInfo("en-US"), patternDensity);
                                return filamenDensities;
                            default:
                                return unknown;
                        }
                    case SlicerName.BambuStudio:
                        switch (Parameter)
                        {
                            /* Do not exist in comments
                            case SlicerParameter.Volume:
                                myregex = new Regex(@"[;]\s*filament used\s*\[cm3\]\s*=\s*\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"(\s\d*.\d{1,2})").Groups[1].Value;
                            case SlicerParameter.FilamentUsed:
                                myregex = new Regex(@"[;]\s*filament used\s*\[mm\]\s*=\s*\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"(\s\d*.\d{1,2})").Groups[1].Value;
                            */
                            case SlicerParameter.PrintTime:
                                //myregex = new Regex(@"[;]\s*estimated printing time \(normal mode\)\s*=\s*\d*h\s*\d*m\s*\d*s");
                                myregex = new Regex(@"[;]\s*total estimated time\s*=*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                // Result looks like, we need the second paramater "; model printing time: 8m 6s; total estimated time: 15m 26s"
                                string targetTotalPrintTime = lines.FirstOrDefault()?.Split(new string[] { ";" }, StringSplitOptions.RemoveEmptyEntries).LastOrDefault()?.Trim();
                                return Regex.Match(targetTotalPrintTime, @"((\d*d\s\d*h\s*\d*m\s\d*s)|(\d*h\s*\d*m\s\d*s)|(\d*m\s\d*s)|(\d{1,}s))").Groups[1].Value;
                            case SlicerParameter.PrintTimeModel:
                                myregex = new Regex(@"[;]\s*model printing time\s*=*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                // Result looks like, we need the second paramater "; model printing time: 8m 6s; total estimated time: 15m 26s"
                                string targetModelPrintTime = lines.FirstOrDefault()?.Split(new string[] { ";" }, StringSplitOptions.RemoveEmptyEntries).FirstOrDefault()?.Trim();
                                return Regex.Match(targetModelPrintTime, @"((\d*d\s\d*h\s*\d*m\s\d*s)|(\d*h\s*\d*m\s\d*s)|(\d*m\s\d*s)|(\d{1,}s))").Groups[1].Value;
                            case SlicerParameter.FilamentDiameter:
                                // ; filament_diameter = 1.75,1.75,1.75
                                myregex = new Regex(@"[;]\s*filament_diameter\s*=\s*\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                Regex pattern = new(@"(?<=)(\d+(\.\d+)?)|(\.\d+)");
                                string filamentDiameters = ConcatNumericDataString(lines.FirstOrDefault(), ",", CultureInfo.GetCultureInfo("en-US"), pattern);
                                return filamentDiameters;
                            case SlicerParameter.NozzleDiameter:
                                // ; nozzle_diameter = 0.4
                                myregex = new Regex(@"[;]\s*nozzle_diameter\s*=\s*\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"([^ =\s](\d*.\d{1,2}))").Groups[1].Value;
                            case SlicerParameter.FilamentType:
                                myregex = new Regex(@"[;]\s*filament_type\s*=\s*([A-Z])*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                string filamentTypes = ConcatDataString(lines.FirstOrDefault(), ";", CultureInfo.GetCultureInfo("en-US"));
                                return filamentTypes;
                            case SlicerParameter.FilamentDensity:
                                // ; filament_density = 1.08,1.08,1.08
                                myregex = new Regex(@"[;]\s*filament_density\s*=\s*\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                Regex patternDensity = new(@"(?<=)(\d+(\.\d+)?)|(\.\d+)");
                                string filamenDensities = ConcatNumericDataString(lines.FirstOrDefault(), ",", CultureInfo.GetCultureInfo("en-US"), patternDensity);
                                return filamenDensities;
                            default:
                                return unknown;
                        }
                    case SlicerName.Simplify3D:
                        switch (Parameter)
                        {
                            case SlicerParameter.Volume:
                                myregex = new Regex(@"([;]\s*Plastic volume:\s*)");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"(\d*.\d{1,2})\s*(cc)").Groups[1].Value;
                            case SlicerParameter.PrintTime:
                                myregex = new Regex(@"([;]\s*Build time:*)");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"((\d*\s(hour|hours)\s\d*\s(minutes|minute)\s\d*\s(seconds|second))|(\d*\s(hour|hours)\s\d*\s(minutes|minute))|(\d*\s(hour|hours))|((minutes|minute)\s\d*\s(seconds|second)))").Groups[1].Value;
                            case SlicerParameter.PrintTimeSilent:
                                myregex = new Regex(@"([;]\s*Build time:*)");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"((\d*\s(hour|hours)\s\d*\s(minutes|minute)\s\d*\s(seconds|second))|(\d*\s(hour|hours)\s\d*\s(minutes|minute))|(\d*\s(hour|hours))|((minutes|minute)\s\d*\s(seconds|second)))").Groups[1].Value;
                            case SlicerParameter.FilamentDiameter:
                                myregex = new Regex(@"[;]\s*filamentDiameters,\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"([^ ,](\d*.\d\d))").Groups[1].Value;
                            case SlicerParameter.NozzleDiameter:
                                myregex = new Regex(@"[;]\s*extruderDiameter,\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"([^ ,](\d*.\d\d))").Groups[1].Value;
                            case SlicerParameter.FilamentType:
                                myregex = new Regex(@"[;]\s*printMaterial,\w*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                var s = Regex.Match(lines[0], @"(,)([^,]*)").Groups[2].Value;
                                return Regex.Match(lines[0], @"(,)([^,]*)").Groups[2].Value;
                            case SlicerParameter.FilamentDensity:
                                myregex = new Regex(@"[;]\s*filamentDensities,\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"([^ ,](\d*.\d\d))").Groups[1].Value;
                            default:
                                return unknown;
                        }
                    case SlicerName.Voxelizer2:
                        VoxelizerSingleGcodeInfo gInfo = new();
                        try
                        {
                            StringBuilder sb = new();
                            for (int i = 1; i < Lines.Count; i++)
                            {
                                string curLine = Lines[i];
                                if (curLine.StartsWith(";;"))
                                    sb.Append(curLine.Replace(";;", "").Replace("{", "").Replace("}", ""));
                                else
                                    break;

                            }
                            string json = sb.ToString();
                            string infoBlock = string.Format("{{ \"info\": [{{{0}}}]}}", Regex.Match(json, "(?<=\"info\": [[])(.*)(?=],)").Groups[0].Value);
                            gInfo = JsonConvert.DeserializeObject<VoxelizerSingleGcodeInfo>(infoBlock);
                        }
                        catch (Exception)
                        {
                            return string.Empty;

                        }

                        switch (Parameter)
                        {
                            case SlicerParameter.FilamentUsed:
                                var filamentUsed = gInfo.Info[0].FilamentUsage.Sum();
                                return (filamentUsed * 1000f).ToString().Replace(",", ".");

                            case SlicerParameter.FilamentDiameter:
                                string[] toolhead = gInfo.Info[0].Toolhead.Split(' ');
                                return toolhead[1];

                            case SlicerParameter.PrintTime:
                                string printTime = gInfo.Info[0].PrintingTime;
                                string[] parts = printTime.Split(new string[] { " " }, StringSplitOptions.RemoveEmptyEntries);
                                string days = "0";
                                string hours = "0";
                                string mins = "0";
                                string seconds = "0";
                                foreach (string part in parts)
                                {
                                    if (Regex.IsMatch(part, @"(.*)(?=d)"))
                                    {
                                        days = Regex.Match(part, @"(.*)(?=d)").Groups[0].Value;
                                    }
                                    else if (Regex.IsMatch(part, @"(.*)(?=h)"))
                                    {
                                        hours = Regex.Match(part, @"(.*)(?=h)").Groups[0].Value;
                                    }
                                    else if (Regex.IsMatch(part, @"(.*)(?=min)"))
                                    {
                                        mins = Regex.Match(part, @"(.*)(?=min)").Groups[0].Value;
                                    }
                                    else if (Regex.IsMatch(part, @"(.*)(?=s)"))
                                    {
                                        seconds = Regex.Match(part, @"(.*)(?=s)").Groups[0].Value;
                                    }
                                }
                                string timeString = string.Format("{0}:{1}:{2}:{3}",
                                    days,
                                    hours,
                                    mins,
                                    seconds
                                    );
                                return timeString;
                            default:
                                return unknown;
                        }
                    case SlicerName.CraftWare:
                        switch (Parameter)
                        {
                            case SlicerParameter.PrintTime:
                                myregex = new Regex(@"([;]\sTime:*)");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                var s2 = Regex.Match(lines[0], @"(\d+(\.\d+)?)|(\.\d+)").Groups[1].Value;
                                double printT = 0;
                                // Check if it's a valid double format
                                if (Double.TryParse(s2, out printT))
                                {
                                    printT = Convert.ToDouble(s2, CultureInfo.GetCultureInfo("en-US"));
                                    // Time is in minutes
                                    return (printT / 60).ToString();
                                }
                                else
                                    return printT.ToString();
                            case SlicerParameter.NozzleDiameter:
                                myregex = new Regex(@"[;]\s*E0diam:\d*.\d*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                return Regex.Match(lines[0], @"(?<=:)(\d+(\.\d+)?)|(\.\d+)").Groups[1].Value;
                            case SlicerParameter.FilamentUsed:
                                myregex = new Regex(@"[;]\s*E0len:\w*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                var s = Regex.Match(lines[0], @"(?<=:)(\d+(\.\d+)?)|(\.\d+)").Groups[1].Value;

                                double filamentL = 0;
                                // Check if it's a valid double format
                                if (Double.TryParse(s, out filamentL))
                                {
                                    filamentL = Convert.ToDouble(s, CultureInfo.GetCultureInfo("en-US"));
                                    return (filamentL * 1000).ToString();
                                }
                                else
                                    return filamentL.ToString();
                            default:
                                return unknown;
                        }
                    case SlicerName.IdeaMaker:
                        switch (Parameter)
                        {
                            case SlicerParameter.PrintTime:
                                myregex = new Regex(@"([;]Print Time:*)");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                var s2 = Regex.Match(lines[0], @"(\d+(\.\d+)?)|(\.\d+)").Groups[1].Value;
                                double printT = 0;
                                // Check if it's a valid double format
                                if (Double.TryParse(s2, out printT))
                                {
                                    printT = Convert.ToDouble(s2, CultureInfo.GetCultureInfo("en-US"));
                                    // Time is in seconds
                                    return (printT / (60 * 60)).ToString();
                                }
                                else
                                    return printT.ToString();
                            case SlicerParameter.FilamentDensity:
                                myregex = new Regex(@"[;]Filament Density #\d:\w*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();

                                List<double> filamentDensity = new();
                                foreach (string line in lines)
                                {
                                    var s = Regex.Match(line, @"(?<=:\s)(\d+(\.\d+)?)|(\.\d+)").Groups[1].Value;
                                    // Check if it's a valid double format
                                    if (Double.TryParse(s, out double density))
                                    {
                                        density = Convert.ToDouble(s, CultureInfo.GetCultureInfo("en-US"));
                                        // Densitiy is in kg
                                        filamentDensity.Add(density / 1000);
                                    }
                                }
                                if (filamentDensity.Count == 0)
                                    return "";
                                return filamentDensity.Count > 1 ? string.Join("|", filamentDensity) : filamentDensity[0].ToString();
                            case SlicerParameter.FilamentDiameter:
                                myregex = new Regex(@"[;]Filament Diameter #\d:\w*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();

                                List<double> filamentDiameter = new();
                                foreach (string line in lines)
                                {
                                    string s = Regex.Match(line, @"(?<=:\s)(\d+(\.\d+)?)|(\.\d+)").Groups[1].Value;
                                    // Check if it's a valid double format
                                    if (Double.TryParse(s, out double diameter))
                                    {
                                        diameter = Convert.ToDouble(s, CultureInfo.GetCultureInfo("en-US"));
                                        filamentDiameter.Add(diameter);
                                    }
                                }
                                if (filamentDiameter.Count == 0)
                                    return "1.75";
                                return filamentDiameter.Count > 1 ? string.Join("|", filamentDiameter) : filamentDiameter[0].ToString();
                            default:
                                return unknown;
                        }
                    case SlicerName.Cura:
                        switch (Parameter)
                        {
                            case SlicerParameter.PrintTime:
                                myregex = new Regex(@"([;]TIME:\d*)");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();
                                string s2 = Regex.Match(lines[0], @"(\d+(\.\d+)?)|(\.\d+)").Groups[1].Value;
                                double printT = 0;
                                // Check if it's a valid double format
                                if (Double.TryParse(s2, out printT))
                                {
                                    printT = Convert.ToDouble(s2, CultureInfo.GetCultureInfo("en-US"));
                                    // Time is in seconds
                                    return (printT / (60 * 60)).ToString();
                                }
                                else
                                    return printT.ToString();
                            case SlicerParameter.FilamentUsed:
                                myregex = new Regex(@"[;]Filament used:\w*");
                                lines = Lines.Where(line => !string.IsNullOrEmpty(line) && myregex.IsMatch(line)).ToList();

                                List<double> filamentLength = new();
                                foreach (string line in lines)
                                {
                                    // For multiple extruders
                                    List<string> filamentUsages = new();
                                    if (line.Contains(","))
                                    {
                                        filamentUsages.AddRange(line.Split(','));
                                    }
                                    else
                                    {
                                        filamentUsages.Add(line);
                                    }
                                    for (int i = 0; i < filamentUsages.Count; i++)
                                    {
                                        //string s = Regex.Match(filamentUsages[i], @"(?<=:\s)(\d+(\.\d+)?)|(\.\d+)").Groups[1].Value;
                                        string s = Regex.Match(filamentUsages[i], @"(\d+(\.\d+)?)|(\.\d+)").Groups[1].Value;
                                        GroupCollection unit = Regex.Match(line, @"(\b(\d+(?:\.\d+)?)\s*([cmk]?m)\b)").Groups;
                                        string stringUnit = unit[groupnum: unit.Count - 1].Value;
                                        //string stringUnit = unit[unit.Count - 1].Value;
                                        // Check if it's a valid double format
                                        if (Double.TryParse(s, out double filament))
                                        {
                                            // Filament is al
                                            filament = Convert.ToDouble(s, CultureInfo.GetCultureInfo("en-US"));
                                            switch (stringUnit)
                                            {
                                                case "cm":
                                                    filament *= 10;
                                                    break;
                                                case "km":
                                                    filament = filament * 1000 * 100 * 10;
                                                    break;
                                                case "m":
                                                    filament = filament * 100 * 10;
                                                    break;
                                                // Nothing to do here, already in meters
                                                case "mm":
                                                default:
                                                    break;
                                            }
                                            filamentLength.Add(filament);
                                        }
                                    }
                                }
                                if (filamentLength.Count == 0)
                                    return "";
                                return filamentLength.Count > 1 ? string.Join("|", filamentLength) : filamentLength[0].ToString();
                            default:
                                return unknown;
                        }
                    case SlicerName.FlashForge:
                        // No print infos in comments available
                        return unknown;
                    default:
                        return "Slicer not tested yet";
                }

            }
            catch (Exception exc)
            {
                OnError(new UnhandledExceptionEventArgs(exc, false));
                return "Error";
            }

        }
        #endregion

        #endregion
    }
}
