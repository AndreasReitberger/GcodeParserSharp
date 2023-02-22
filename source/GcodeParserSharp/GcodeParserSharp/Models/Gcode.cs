using AndreasReitberger.Enums;
using AndreasReitberger.Core.Utilities;
using System;
using System.Collections.Generic;
using System.IO;
using AndreasReitberger.API.OctoPrint.Models;

#if NETFRAMEWORK
using HelixToolkit.Wpf;
using HelixToolkit.Wpf.SharpDX;
#elif NET6_0_OR_GREATER
using HelixToolkit.Wpf;
using HelixToolkit.SharpDX.Core;
#endif

namespace AndreasReitberger.Models
{
    public class Gcode : BaseModel
    {
        #region Properties

        #region General
        Guid _id = Guid.Empty;
        public Guid Id
        {
            get => _id;
            set
            {
                if (_id == value) return;
                _id = value;
                OnPropertyChanged();
            }
        }

        bool _isValid = false;
        public bool IsValid
        {
            get => _isValid;
            set
            {
                if (_isValid == value) return;
                _isValid = value;
                OnPropertyChanged();
            }
        }

        bool _isOctoPrintGcodeAnalysis = false;
        public bool IsOctoPrintGcodeAnalysis
        {
            get => _isOctoPrintGcodeAnalysis;
            set
            {
                if (_isOctoPrintGcodeAnalysis == value) return;
                _isOctoPrintGcodeAnalysis = value;
                OnPropertyChanged();
            }
        }

        bool _isWorking = false;
        public bool IsWorking
        {
            get => _isWorking;
            set
            {
                if (_isWorking == value) return;
                _isWorking = value;
                OnPropertyChanged();
            }
        }

        int _progress = 0;
        public int Progress
        {
            get => _progress;
            set
            {
                if (_progress == value) return;
                _progress = value;
                OnPropertyChanged();
            }
        }

        int _processOrder = 0;
        public int ProcessOrder
        {
            get => _processOrder;
            set
            {
                if (_processOrder == value) return;
                _processOrder = value;
                OnPropertyChanged();
            }
        }

        #endregion

        #region ParserInformation
        TimeSpan _parsingDuration;
        public TimeSpan ParsingDuration
        {
            get => _parsingDuration;
            set
            {
                if (_parsingDuration == value) return;
                _parsingDuration = value;
                OnPropertyChanged();
            }
        }

        Dictionary<double, int> _zHeights = new();
        public Dictionary<double, int> ZHeights
        {
            get => _zHeights;
            set
            {
                if (_zHeights == value) return;
                _zHeights = value;
                OnPropertyChanged();
            }
        }
        #endregion

        #region GcodeInformation
        SlicerName _slicerName = SlicerName.Unkown;
        public SlicerName SlicerName
        {
            get => _slicerName;
            set
            {
                if (_slicerName == value) return;
                _slicerName = value;
                OnPropertyChanged();
            }
        }

        string _fileName;
        public string FileName
        {
            get => _fileName;
            set
            {
                if (_fileName == value) return;
                _fileName = value;
                OnPropertyChanged();
            }
        }

        string _filePath;
        public string FilePath
        {
            get => _filePath;
            set
            {
                if (_filePath == value) return;
                _filePath = value;
                OnPropertyChanged();
            }
        }

        bool _layerModelGenerated = false;
        public bool LayerModelGenerated
        {
            get => _layerModelGenerated;
            set
            {
                if (value == _layerModelGenerated) return;
                _layerModelGenerated = value;
                OnPropertyChanged();
            }
        }

        List<double> _filamentUsage = new();
        public List<double> FilamentUsage
        {
            get => _filamentUsage;
            set
            {
                if (_filamentUsage == value) return;
                _filamentUsage = value;
                OnPropertyChanged();
            }
        }

        List<double> _filamentDiameters = new();
        public List<double> FilamentDiameters
        {
            get => _filamentDiameters;
            set
            {
                if (_filamentDiameters == value) return;
                _filamentDiameters = value;
                OnPropertyChanged();
            }
        }

        List<double> _filamentDensities = new();
        public List<double> FilamentDensities
        {
            get => _filamentDensities;
            set
            {
                if (_filamentDensities == value) return;
                _filamentDensities = value;
                OnPropertyChanged();
            }
        }

        List<double> _nozzleDiameters = new();
        public List<double> NozzleDiameters
        {
            get => _nozzleDiameters;
            set
            {
                if (_nozzleDiameters == value) return;
                _nozzleDiameters = value;
                OnPropertyChanged();
            }
        }

        double _filamentUsed = 0;
        /// <summary>Gets the filament used in "mm"</summary>
        /// <value>The filament used.</value>
        public double FilamentUsed
        {
            get => _filamentUsed;
            set
            {
                if (_filamentUsed == value)
                    return;
                _filamentUsed = value;
                OnPropertyChanged();
            }
        }

        double _filamentDiameter = 1.75f;
        public double FilamentDiameter
        {
            get => _filamentDiameter;
            set
            {
                if (_filamentDiameter == value)
                    return;
                _filamentDiameter = value;
                OnPropertyChanged();
            }
        }

        double _extrudedFilamentVolume;
        public double ExtrudedFilamentVolume
        {
            get => _extrudedFilamentVolume;
            set
            {
                if (_extrudedFilamentVolume == value)
                    return;
                _extrudedFilamentVolume = value;
                OnPropertyChanged();
            }
        }

        double _printTime;
        public double PrintTime
        {
            get => _printTime;
            set
            {
                if (_printTime == value)
                    return;
                _printTime = value;
                OnPropertyChanged();
            }
        }

        string _filamentType;
        public string FilamentType
        {
            get => _filamentType;
            set
            {
                if (_filamentType == value)
                    return;
                _filamentType = value;
                OnPropertyChanged();
            }
        }

        double _filamentDensity;
        public double FilamentDensity
        {
            get => _filamentDensity;
            set
            {
                if (_filamentDensity == value)
                    return;
                _filamentDensity = value;
                OnPropertyChanged();
            }
        }

        double _filamentWeight;
        public double FilamentWeight
        {
            get => _filamentWeight;
            set
            {
                if (_filamentWeight == value)
                    return;
                _filamentWeight = value;
                OnPropertyChanged();
            }
        }

        double _NozzleDiameter;
        public double NozzleDiameter
        {
            get => _NozzleDiameter;
            set
            {
                if (_NozzleDiameter == value)
                    return;
                _NozzleDiameter = value;
                OnPropertyChanged();
            }
        }

        double _width = 0;
        public double Width
        {
            get => _width;
            set
            {
                if (_width == value) return;
                _width = value;
                OnPropertyChanged();
            }
        }

        double _depth = 0;
        public double Depth
        {
            get => _depth;
            set
            {
                if (_depth == value) return;
                _depth = value;
                OnPropertyChanged();
            }
        }

        double _height = 0;
        public double Height
        {
            get => _height;
            set
            {
                if (_height == value) return;
                _height = value;
                OnPropertyChanged();
            }
        }

        int _layers = 0;
        public int Layers
        {
            get => _layers;
            set
            {
                if (_layers == value) return;
                _layers = value;
                OnPropertyChanged();
            }
        }
        #endregion

        #region Commands & Comments
        List<List<GcodeCommandLine>> _commands = new();
        public List<List<GcodeCommandLine>> Commands
        {
            get => _commands;
            set
            {
                if (_commands == value) return;
                _commands = value;
                OnPropertyChanged();
            }
        }

        List<string> _comments = new();
        public List<string> Comments
        {
            get => _comments;
            set
            {
                if (_comments == value) return;
                _comments = value;
                OnPropertyChanged();
            }
        }
        #endregion

#if NETFRAMEWORK || NET6_0_OR_GREATER
        #region Model
        List<LinesVisual3D> _modelLayers = new();
        public List<LinesVisual3D> ModelLayers
        {
            get => _modelLayers;
            set
            {
                if (_modelLayers == value) return;
                _modelLayers = value;
                OnPropertyChanged();
            }
        }

        List<LineBuilder> _model3d = new();
        public List<LineBuilder> Model3D
        {
            get => _model3d;
            set
            {
                if (_model3d == value) return;
                _model3d = value;
                OnPropertyChanged();
            }
        }
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
            FilePath = file.Path;
            FileName = file.Display;
            IsOctoPrintGcodeAnalysis = true;

        }
        #endregion

        #region Methods

        #region Public

#if NETFRAMEWORK || NET6_0_OR_GREATER
        public LineBuilder GetGcodeLayerLineBuilder(int LayerNumber)
        {
            var lineBuilder = new LineBuilder();
            if (LayerNumber < Model3D.Count)
                lineBuilder = Model3D[LayerNumber];              

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
