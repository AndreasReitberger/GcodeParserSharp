namespace AndreasReitberger.Models
{
    public class GcodeLineProcessResult
    {
        #region Properties
        public bool ValidX { get; set; } = false;
        public bool ValidY { get; set; } = false;
        public bool ValidZ { get; set; } = false;
        public double MaxX { get; set; } = double.MinValue;
        public double MinX { get; set; } = double.MaxValue;
        public double MaxY { get; set; } = double.MinValue;
        public double MinY { get; set; } = double.MaxValue;
        public double MaxZ { get; set; } = double.MinValue;
        public double MinZ { get; set; } = double.MaxValue;
        public double PrintTimeAddition { get; set; } = 0;
        public double TotalFilament { get; set; } = 0;
        public double TotalPrintTime { get; set; } = 0;
        public double LastSpeed { get; set; } = 0;

        #endregion
    }
}
