using Newtonsoft.Json;

namespace AndreasReitberger.Parser.Gcode.Slicer
{
    public partial class VoxelizerInfo
    {
        [JsonProperty("toolhead", Required = Required.DisallowNull, NullValueHandling = NullValueHandling.Ignore)]
        public string Toolhead { get; set; }

        [JsonProperty("workflow", Required = Required.DisallowNull, NullValueHandling = NullValueHandling.Ignore)]
        public string Workflow { get; set; }

        [JsonProperty("voxelizer_version", Required = Required.DisallowNull, NullValueHandling = NullValueHandling.Ignore)]
        public string VoxelizerVersion { get; set; }

        [JsonProperty("voxel_size", Required = Required.DisallowNull, NullValueHandling = NullValueHandling.Ignore)]
        public double? VoxelSize { get; set; }

        [JsonProperty("printing_time", Required = Required.DisallowNull, NullValueHandling = NullValueHandling.Ignore)]
        public string PrintingTime { get; set; }

        [JsonProperty("printer", Required = Required.DisallowNull, NullValueHandling = NullValueHandling.Ignore)]
        public string Printer { get; set; }

        [JsonProperty("filament_usage", Required = Required.DisallowNull, NullValueHandling = NullValueHandling.Ignore)]
        public double[] FilamentUsage { get; set; }

        [JsonProperty("preset_name_material", Required = Required.DisallowNull, NullValueHandling = NullValueHandling.Ignore)]
        public string PresetNameMaterial { get; set; }

        [JsonProperty("preset_name_durability", Required = Required.DisallowNull, NullValueHandling = NullValueHandling.Ignore)]
        public string PresetNameDurability { get; set; }

        [JsonProperty("preset_name_support", Required = Required.DisallowNull, NullValueHandling = NullValueHandling.Ignore)]
        public string PresetNameSupport { get; set; }

        [JsonProperty("min_path_width", Required = Required.DisallowNull, NullValueHandling = NullValueHandling.Ignore)]
        public double? MinPathWidth { get; set; }

        [JsonProperty("max_path_width", Required = Required.DisallowNull, NullValueHandling = NullValueHandling.Ignore)]
        public double? MaxPathWidth { get; set; }

        [JsonProperty("min_layer_height", Required = Required.DisallowNull, NullValueHandling = NullValueHandling.Ignore)]
        public double? MinLayerHeight { get; set; }

        [JsonProperty("max_layer_height", Required = Required.DisallowNull, NullValueHandling = NullValueHandling.Ignore)]
        public double? MaxLayerHeight { get; set; }
    }
}
