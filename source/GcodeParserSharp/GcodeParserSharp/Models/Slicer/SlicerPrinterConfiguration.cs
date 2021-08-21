namespace AndreasReitberger.Models
{
    public class SlicerPrinterConfiguration
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

        public string PrinterName { get; set; } 
        public double AMax_xy { get; set; }
        public double AMax_z { get; set; }
        public double AMax_e { get; set; }
        public double AMax_eExtrude { get; set; }
        public double AMax_eRetract { get; set; }
        public double PrintDurationCorrection { get; set; } = 1;

        #endregion

        #region Overrides

        public override bool Equals(object obj)
        {
            if (obj is not SlicerPrinterConfiguration item)
                return false;
            return PrinterName.Equals(item.PrinterName);
        }
        public override int GetHashCode()
        {
            return PrinterName.GetHashCode();
        }

        #endregion
    }
}
