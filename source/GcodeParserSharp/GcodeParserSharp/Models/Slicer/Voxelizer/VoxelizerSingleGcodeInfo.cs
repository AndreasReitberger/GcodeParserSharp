using Newtonsoft.Json;

namespace AndreasReitberger.Models
{
    public partial class VoxelizerSingleGcodeInfo
    {
        [JsonProperty("info", Required = Required.Always)]
        public VoxelizerInfo[] Info { get; set; }
    }
}
