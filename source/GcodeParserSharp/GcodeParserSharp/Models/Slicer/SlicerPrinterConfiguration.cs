using AndreasReitberger.Core.Utilities;
using CommunityToolkit.Mvvm.ComponentModel;

namespace AndreasReitberger.Parser.Gcode.Slicer
{
    public partial class SlicerPrinterConfiguration : BaseModel
    {
        #region  Default
        public static SlicerPrinterConfiguration Default = new()
        {
            PrinterName = "Default",
            AMax_xy = 1000,
            AMax_z = 1000,
            AMax_e = 5000,
            AMax_eExtrude = 1250,
            AMax_eRetract = 1250,
            PrintDurationCorrection = 1
        };
        #endregion

        #region Properties

        [ObservableProperty]
        string printerName = string.Empty;
        [ObservableProperty]
        double aMax_xy;
        [ObservableProperty]
        double aMax_z;
        [ObservableProperty]
        double aMax_e;
        [ObservableProperty]
        double aMax_eExtrude;
        [ObservableProperty]
        double aMax_eRetract;
        [ObservableProperty]
        double printDurationCorrection = 1;

        #endregion

        #region Overrides

        public override bool Equals(object obj)
        {
            if (obj is not SlicerPrinterConfiguration item)
                return false;
            return PrinterName.Equals(item.PrinterName);
        }
        public override int GetHashCode() => PrinterName.GetHashCode();
        
        #endregion
    }
}
