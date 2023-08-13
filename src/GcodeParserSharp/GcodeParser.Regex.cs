using System.Text.RegularExpressions;

namespace AndreasReitberger.Parser.Gcode
{
    public partial class GcodeParser
    {
        #region Recurring Regex Pattern

        public static string FilamentVolumePattern => @"[;]\s*filament used\s*\[cm3\]\s*=\s*\d*.\d*";
        public static string FilamentLengthPattern => @"[;]\s*filament used\s*\[mm\]\s*=\s*\d*.\d*";
        public static string FilamentWeightPattern => @"[;]\s*filament used\s*\[mm\]\s*=\s*\d*.\d*";
        public static string PrintingTimePattern => @"([;]\s*(total estimated time)|(estimated printing time)\s*=*)";
        #endregion

        #region Regex
        public static Regex FilamentVolume => new(FilamentVolumePattern);
        public static Regex FilamentLength => new(FilamentLengthPattern);
        public static Regex FilamentWeight => new(FilamentWeightPattern);
        public static Regex PrintingTime => new(PrintingTimePattern);

        #endregion
    }
}
