using AndreasReitberger.Enums;
using AndreasReitberger.Models;
using System.Collections.Generic;

namespace AndreasReitberger
{
    public static class GcodeParserGloblStaticConfig
    {
        public static List<SlicerInfo> SupportedSlicersForCommentRead = new()
        {
            new SlicerInfo() { SlicerName = SlicerName.Slic3r},
            new SlicerInfo() { SlicerName = SlicerName.PrusaSlicer},
            new SlicerInfo() { SlicerName = SlicerName.Simplify3D},
            new SlicerInfo() { SlicerName = SlicerName.Voxelizer2},
            new SlicerInfo() { SlicerName = SlicerName.CraftWare},
            new SlicerInfo() { SlicerName = SlicerName.IdeaMaker},
            new SlicerInfo() { SlicerName = SlicerName.Cura},
        };
    }
}
