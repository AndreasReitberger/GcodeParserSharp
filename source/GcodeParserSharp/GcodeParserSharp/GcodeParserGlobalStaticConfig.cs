using AndreasReitberger.Parser.Gcode.Enums;
using AndreasReitberger.Parser.Gcode.Slicer;
using System.Collections.Generic;

namespace AndreasReitberger.Parser.Gcode
{
    public static class GcodeParserGlobalStaticConfig
    {
        public static List<SlicerInfo> SupportedSlicersForCommentRead = new()
        {
            new SlicerInfo() { SlicerName = SlicerName.Slic3r, RepositoryUri = "https://github.com/slic3r/Slic3r" },
            new SlicerInfo() { SlicerName = SlicerName.PrusaSlicer, RepositoryUri = "https://github.com/prusa3d/PrusaSlicer" },
            new SlicerInfo() { SlicerName = SlicerName.Simplify3D },
            new SlicerInfo() { SlicerName = SlicerName.Voxelizer2 },
            new SlicerInfo() { SlicerName = SlicerName.CraftWare },
            new SlicerInfo() { SlicerName = SlicerName.IdeaMaker, RepositoryUri = "https://github.com/Raise3D/ideaMaker" },
            new SlicerInfo() { SlicerName = SlicerName.Cura, RepositoryUri = "https://github.com/Ultimaker/Cura" },
            new SlicerInfo() { SlicerName = SlicerName.OrcaSlicer, RepositoryUri = "https://github.com/SoftFever/OrcaSlicer" },
            new SlicerInfo() { SlicerName = SlicerName.BambuStudio, RepositoryUri = "https://github.com/bambulab/BambuStudio" },
        };
    }
}
