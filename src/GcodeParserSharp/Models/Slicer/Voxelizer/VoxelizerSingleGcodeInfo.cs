using Newtonsoft.Json;

namespace AndreasReitberger.Parser.Gcode.Slicer
{
    public partial class VoxelizerSingleGcodeInfo
    {
        [JsonProperty("info", Required = Required.Always)]
        public VoxelizerInfo[] Info { get; set; }
    }
}
