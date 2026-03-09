using AndreasReitberger.API.OctoPrint.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace AndreasReitberger.Parser.Gcode
{
    public partial class GcodeParser
    {
        #region Static

        public static string? ConcatNumericDataString(List<string> data, CultureInfo culture, Regex? pattern = null, string joinChar = "|")
        {
            List<double> elements = [];
            foreach (string line in data)
            {
                string? s = pattern != null
                    ? pattern.Match(line).Groups[1].Value
                    : line.Split(["="], StringSplitOptions.RemoveEmptyEntries).LastOrDefault()?.Trim();
                // Check if it's a valid double format
                if (double.TryParse(s, out double diameter))
                {
                    diameter = Convert.ToDouble(s, culture);
                    elements.Add(diameter);
                }
            }
            if (elements.Count == 0) return default;
            return elements.Count > 1 ? string.Join(joinChar, elements) : elements.FirstOrDefault().ToString();
        }

        public static string? ConcatNumericDataString(string data, string separator, CultureInfo culture, Regex? pattern = null, string joinChar = "|")
        {
            List<double> elements = [];
            List<string> strings = [.. data.Split([separator], StringSplitOptions.RemoveEmptyEntries)];
            foreach (string line in strings)
            {
                string? s = pattern != null
                    ? pattern.Match(line).Groups[1].Value
                    : line.Split(["="], StringSplitOptions.RemoveEmptyEntries).LastOrDefault()?.Trim();
                // Check if it's a valid double format
                if (double.TryParse(s, out double numericValue))
                {
                    numericValue = Convert.ToDouble(s, culture);
                    elements.Add(numericValue);
                }
            }
            if (elements.Count == 0) return default;
            return elements.Count > 1 ? string.Join(joinChar, elements) : elements.FirstOrDefault().ToString();
        }

        public static string? ConcatDataString(string data, string separator, CultureInfo culture, Regex? pattern = null, string joinChar = "|")
        {
            List<string> elements = [];
            List<string> strings = [.. data.Split([separator], StringSplitOptions.RemoveEmptyEntries)];
            foreach (string line in strings)
            {
                string? s = pattern != null
                    ? pattern.Match(line).Groups[1].Value
                    : line.Split(["="], StringSplitOptions.RemoveEmptyEntries).LastOrDefault()?.Trim();
                elements.Add(s);
            }
            if (elements.Count == 0) return default;
            return elements.Count > 1 ? string.Join(joinChar, elements) : elements.FirstOrDefault()?.ToString();
        }

        public static List<byte[]> GetThumbnails(List<string> comments, string pattern = @"(?:^; thumbnail(?:_JPG)* begin \d+[x ]\d+ \d+)(?:\n|\r\n?)((?:.+(?:\n|\r\n?))+?)(?:^; thumbnail(?:_JPG)* end)")
        {
            // Pattern taken from: https://github.com/jneilliii/OctoPrint-PrusaSlicerThumbnails/blob/master/octoprint_prusaslicerthumbnails/__init__.py
            //pattern = @"(?:^; thumbnail(?:_JPG)* begin \d+[x ]\d+ \d+)(?:\n|\r\n?)((?:.+(?:\n|\r\n?))+?)(?:^; thumbnail(?:_JPG)* end)";
            List<byte[]> thumbnails = [];
            string thumbnail = string.Join(Environment.NewLine, comments);
            MatchCollection regex = Regex.Matches(thumbnail, pattern, RegexOptions.Multiline);
            foreach (var match in regex)
            {
                string? capture = match.ToString();
                // Remove first and last line
                //var p = capture?.Split("; ", StringSplitOptions.RemoveEmptyEntries);
                capture = string
                    .Join(
#if NET6_0_OR_GREATER || NETSTANDARD2_1
                        string.Empty, capture?.Split("; ", StringSplitOptions.RemoveEmptyEntries)
#else
                        string.Empty, capture?.Split(new string[] { "; " } , StringSplitOptions.RemoveEmptyEntries)
#endif
                        .Skip(1)
#if NET6_0_OR_GREATER || NETSTANDARD2_1
                        .SkipLast(1)
#else
                        .Take(capture.Split(new string[] { "; " }, StringSplitOptions.RemoveEmptyEntries).Count() - 2)
#endif
                    );
                byte[] image = Base64StringToByteArray(capture);
                if(image?.Length > 0)
                    thumbnails.Add(image);          
            }
            return thumbnails;
        }

        public static Gcode FromOctoPrintFile(OctoPrintFile file)
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
                if (file.Statistics.AveragePrintTime != null && file.Statistics.AveragePrintTime.DefaultValue > 0)
                    temp.PrintTime = Math.Round(file.Statistics.AveragePrintTime.DefaultValue / 3600, 2);
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

        public static string CommandsToText(Gcode gcode)
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

        public static byte[] StringToByteArray(string hex) => [.. Enumerable.Range(0, hex.Length)
                             .Where(x => x % 2 == 0)
                             .Select(x => Convert.ToByte(hex.Substring(x, 2), 16))];
        

        public static byte[] Base64StringToByteArray(string hex) => Convert.FromBase64String(hex);
        
#endregion
    }
}
