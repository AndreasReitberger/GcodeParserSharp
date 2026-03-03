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
        public partial Guid Id { get; set; } = Guid.Empty;

        [ObservableProperty]
        public partial bool IsValid { get; set; } = false;

        [ObservableProperty]
        public partial bool IsOctoPrintGcodeAnalysis { get; set; } = false;

        [ObservableProperty]
        public partial bool IsWorking { get; set; } = false;

        [ObservableProperty]
        public partial int Progress { get; set; } = 0;

        [ObservableProperty]
        public partial int ProcessOrder { get; set; } = 0;

        #endregion

        #region Thumbnails
        [ObservableProperty]
        public partial List<byte[]> Thumbnails { get; set; } = [];
        #endregion

        #region ParserInformation
        [ObservableProperty]
        public partial TimeSpan ParsingDuration { get; set; }

        [ObservableProperty]
        public partial Dictionary<double, int> ZHeights { get; set; } = [];

        #endregion

        #region GcodeInformation
        [ObservableProperty]
        public partial SlicerName SlicerName { get; set; } = SlicerName.Unkown;

        [ObservableProperty]
        public partial string FileName { get; set; } = string.Empty;

        [ObservableProperty]
        public partial string FilePath { get; set; } = string.Empty;

        [ObservableProperty]
        public partial bool LayerModelGenerated { get; set; } = false;

        [ObservableProperty]
        public partial List<double> FilamentUsage { get; set; } = [];

        [ObservableProperty]
        public partial List<double> FilamentDiameters { get; set; } = [];

        [ObservableProperty]
        public partial List<double> FilamentDensities { get; set; } = [];

        [ObservableProperty]
        public partial List<double> NozzleDiameters { get; set; } = [];

        [ObservableProperty]
        public partial double FilamentUsed { get; set; } = 0;

        [ObservableProperty]
        public partial double FilamentDiameter { get; set; } = 1.75f;

        [ObservableProperty]
        public partial double ExtrudedFilamentVolume { get; set; }

        [ObservableProperty]
        public partial double PrintTime { get; set; }

        [ObservableProperty]
        public partial string FilamentType { get; set; } = string.Empty;

        [ObservableProperty]
        public partial List<string> FilamentTypes { get; set; } = [];

        [ObservableProperty]
        public partial double FilamentDensity { get; set; }

        [ObservableProperty]
        public partial double FilamentWeight { get; set; }

        [ObservableProperty]
        public partial double NozzleDiameter { get; set; }

        [ObservableProperty]
        public partial double Width { get; set; } = 0;

        [ObservableProperty]
        public partial double Depth { get; set; } = 0;

        [ObservableProperty]
        public partial double Height { get; set; } = 0;

        [ObservableProperty]
        public partial int Layers { get; set; } = 0;

        #endregion

        #region Commands & Comments

        [ObservableProperty]
        public partial List<List<GcodeCommandLine>> Commands { get; set; } = [];

        [ObservableProperty]
        public partial List<string> Comments { get; set; } = [];
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
        public override string ToString() => FileName;
        
        public override bool Equals(object? obj)
        {
            if (obj is not Gcode item)
                return false;
            return Id.Equals(item.Id);
        }
        public override int GetHashCode() =>  Id.GetHashCode();
        
        #endregion
    }
}
