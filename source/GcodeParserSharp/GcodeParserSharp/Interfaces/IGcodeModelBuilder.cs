#if NETFRAMEWORK || NET6_0_OR_GREATER
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

#if NETFRAMEWORK
using HelixToolkit.Wpf;
using HelixToolkit.Wpf.SharpDX;
#elif NET6_0_OR_GREATER
using HelixToolkit.Wpf;
using HelixToolkit.SharpDX.Core;
#endif

namespace AndreasReitberger.Parser.Gcode.Interfaces
{
    public interface IGcodeModelBuilder
    {
        Task<List<LinesVisual3D>> Create2dGcodeLayerModelListAsync(Gcode gcode, IProgress<int> prog);
        Task<List<LineBuilder>> BuildGcodeLayerModelListAsync(Gcode gcode, IProgress<int> prog);
        Task<List<LinesVisual3D>> Create3dGcodeLayerModelListAsync(Gcode gcode, IProgress<int> prog);
    }
}

#endif