using AndreasReitberger.Parser.Gcode;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Threading;
using System.Threading.Tasks;

namespace GcodeParserSharp.Test
{
    [TestClass]
    public class UnitTest
    {
        public List<string> testfiles = new List<string>()
        {
            @"C:\Users\Andreas\Desktop\Gcodes\BKG_ESP32_V4_ASA_25m48s.gcode",
            @"Gcodes\BambuStudio.gcode",
            @"Gcodes\PrusaSlicer2.gcode",
            @"Gcodes\OrcaSlicer.gcode",
            @"Gcodes\Cura.gcode",
            @"Gcodes\PrusaSlicer.gcode",
            @"Gcodes\FlashForge.gcode",
            @"Gcodes\IdeaMaker.gcode",
            @"Gcodes\Simplify3D.gcode",
        };

        [TestMethod]
        public async Task ParseGcodesAsync()
        {
            var prog = new Progress<int>(percent =>
            {
                Debug.WriteLine($"Parsed: {percent}%");
            });
            GcodeParser.Instance.SupportedSlicers = GcodeParserGlobalStaticConfig.SupportedSlicersForCommentRead;
            GcodeParser.Instance.Error += (a, b) =>
            {
                Debug.WriteLine($"Exception: {b}");
                Assert.Fail(b.ToString());
            };
            foreach (string file in testfiles)
            {
                if (File.Exists(file))
                {
                    CancellationTokenSource cts = new CancellationTokenSource();
                    Gcode gcode = await GcodeParser.Instance.FromFileAsync(file, prog, cts.Token, true);
                    if (gcode != null)
                    {
                        Debug.WriteLine($"Gcode parsed in: {gcode.ParsingDuration}, Volume: {gcode.ExtrudedFilamentVolume}, PrintTime: {gcode.PrintTime}");
                        // Make sure that print time and volume is not 0 
                        Assert.IsTrue(gcode.PrintTime > 0 && gcode.ExtrudedFilamentVolume > 0);
                    }
                    else
                        Assert.Fail($"Parsed gcoe was null: {file}");
                }
                else
                    Assert.Fail($"{file} not found!");
            }
        }
    }
}
