namespace AndreasReitberger.Parser.Gcode
{
    public partial class GcodeCommandLine
    {
        #region Properties
        public bool IsComplete { get; set; } = false;
        public string Command { get; set; } = string.Empty;
        public string Gcode { get; set; } = string.Empty;
        public double X { get; set; }// = double.NegativeInfinity;
        public double Y { get; set; }// = double.NegativeInfinity;
        public double Z { get; set; }// = double.NegativeInfinity;
        public double PrevX { get; set; }// = double.NegativeInfinity;
        public double PrevY { get; set; }// = double.NegativeInfinity;
        public double PrevZ { get; set; }// = double.NegativeInfinity;
        public double Speed { get; set; } = 4000;
        public double VolumePerMM { get; set; } = -1;

        public bool IsExtruding { get; set; } = false;
        public bool IsRetracting { get; set; } = false;
        public bool NoMove { get; set; } = false;
        public int Retract { get; set; } = 0;
        public double Retraction { get; set; } = 0;
        public double Extrusion { get; set; } = 0;
        public string Extruder { get; set; } = string.Empty;
        public int LayerChanges { get; set; } = 0;
        public int Layer { get; set; } = 0;
        #endregion
    }
}
