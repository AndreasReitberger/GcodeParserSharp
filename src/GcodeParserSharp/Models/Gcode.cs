using AndreasReitberger.Parser.Gcode.Enums;
using AndreasReitberger.Core.Utilities;
using System;
using System.Collections.Generic;
using System.IO;
using AndreasReitberger.API.OctoPrint.Models;
using CommunityToolkit.Mvvm.ComponentModel;

#if NETFRAMEWORK
using HelixToolkit.Wpf;
using HelixToolkit.Wpf.SharpDX;
#elif NET6_0_OR_GREATER && USE_HELIX
using HelixToolkit.Wpf;
using HelixToolkit.SharpDX.Core;
#endif

namespace AndreasReitberger.Parser.Gcode
{
    public partial class Gcode : BaseModel
    {
        #region Properties

        #region General
        [ObservableProperty]
        Guid id = Guid.Empty;

        [ObservableProperty]
        bool isValid = false;

        [ObservableProperty]
        bool isOctoPrintGcodeAnalysis = false;

        [ObservableProperty]
        bool isWorking = false;

        [ObservableProperty]
        int progress = 0;

        [ObservableProperty]
        int processOrder = 0;

        #endregion

        #region Thumbnails
        [ObservableProperty]
        List<byte[]> thumbnails = new();
        #endregion

        #region ParserInformation
        [ObservableProperty]
        TimeSpan parsingDuration;

        [ObservableProperty]
        Dictionary<double, int> zHeights = new();

        #endregion

        #region GcodeInformation
        [ObservableProperty]
        SlicerName slicerName = SlicerName.Unkown;

        [ObservableProperty]
        string fileName;

        [ObservableProperty]
        string filePath;

        [ObservableProperty]
        bool layerModelGenerated = false;

        [ObservableProperty]
        List<double> filamentUsage = new();

        [ObservableProperty]
        List<double> filamentDiameters = new();

        [ObservableProperty]
        List<double> filamentDensities = new();

        [ObservableProperty]
        List<double> nozzleDiameters = new();

        [ObservableProperty]
        double filamentUsed = 0;

        [ObservableProperty]
        double filamentDiameter = 1.75f;

        [ObservableProperty]
        double extrudedFilamentVolume;

        [ObservableProperty]
        double printTime;

        [ObservableProperty]
        string filamentType;

        [ObservableProperty]
        List<string> filamentTypes = new();

        [ObservableProperty]
        double filamentDensity;

        [ObservableProperty]
        double filamentWeight;

        [ObservableProperty]
        double nozzleDiameter;

        [ObservableProperty]
        double width = 0;

        [ObservableProperty]
        double depth = 0;

        [ObservableProperty]
        double height = 0;

        [ObservableProperty]
        int layers = 0;

        #endregion

        #region Commands & Comments

        [ObservableProperty]
        List<List<GcodeCommandLine>> commands = new();

        [ObservableProperty]
        List<string> comments = new();
        #endregion

#if NETFRAMEWORK || (NET6_0_OR_GREATER && USE_HELIX)
        #region Model

        [ObservableProperty]
        List<LinesVisual3D> modelLayers = new();

        [ObservableProperty]
        List<LineBuilder> model3d = new();

        #endregion
#endif
        #endregion

        #region Constructor
        public Gcode(string file)
        {
            Id = Guid.NewGuid();
            FilePath = file;
            FileName = Path.GetFileName(file);
        }
        public Gcode(OctoPrintFile file)
        {
            Id = Guid.NewGuid();
            FilePath = file.FilePath;
            FileName = file.Display;
            IsOctoPrintGcodeAnalysis = true;
        }
        #endregion

        #region Methods

        #region Public

#if NETFRAMEWORK || (NET6_0_OR_GREATER && USE_HELIX)
        public LineBuilder GetGcodeLayerLineBuilder(int LayerNumber)
        {
            LineBuilder lineBuilder = new();
            if (LayerNumber < Model3d.Count)
                lineBuilder = Model3d[LayerNumber];              

            return lineBuilder;
        }
#endif

        #endregion

        #endregion

        #region Overrides
        public override string ToString()
        {
            return FileName;
        }
        public override bool Equals(object obj)
        {
            if (obj is not Gcode item)
                return false;
            return Id.Equals(item.Id);
        }
        public override int GetHashCode()
        {
            return Id.GetHashCode();
        }
        #endregion
    }
}
