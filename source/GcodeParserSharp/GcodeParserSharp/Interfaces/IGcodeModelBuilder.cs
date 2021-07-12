#if NETFRAMEWORK

using System;
using System.Collections.Generic;
using System.Threading.Tasks;

using AndreasReitberger.Models;
using HelixToolkit.Wpf;
using HelixToolkit.Wpf.SharpDX;

namespace AndreasReitberger.Interfaces
{
    public interface IGcodeModelBuilder
    {
        Task<List<LinesVisual3D>> Create2dGcodeLayerModelListAsync(Gcode gcode, IProgress<int> prog);
        Task<List<LineBuilder>> BuildGcodeLayerModelListAsync(Gcode gcode, IProgress<int> prog);
        Task<List<LinesVisual3D>> Create3dGcodeLayerModelListAsync(Gcode gcode, IProgress<int> prog);
    }
}

#endif