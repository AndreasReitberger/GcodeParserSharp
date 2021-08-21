using AndreasReitberger;
using AndreasReitberger.Models;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
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
            @"Gcodes\PrusaSlicer.gcode",
            @"Gcodes\FlashForge.gcode",
            @"Gcodes\IdeaMaker.gcode",
        };

        [TestMethod]
        public async Task ParseGcodesAsync()
        {
            var prog = new Progress<int>(percent =>
            {
                Console.WriteLine($"Parsed: {percent}%");
            });
            GcodeParser.Instance.SupportedSlicers = new List<SlicerInfo>()
            {
                new SlicerInfo() { SlicerName = AndreasReitberger.Enums.SlicerName.Cura },
                new SlicerInfo() { SlicerName = AndreasReitberger.Enums.SlicerName.FlashForge },
                new SlicerInfo() { SlicerName = AndreasReitberger.Enums.SlicerName.PrusaSlicer },
            };
            GcodeParser.Instance.Error += (a, b) =>
            {
                Console.WriteLine($"Exception: {b}");
            };
            foreach (string file in testfiles)
            {
                if (File.Exists(file))
                {
                    CancellationTokenSource cts = new CancellationTokenSource();
                    Gcode gcode = await GcodeParser.Instance.FromFileAsync(file, prog, cts.Token, true);
                    if (gcode != null)
                    {
                        Console.WriteLine($"Gcode parsed in: {gcode.ParsingDuration}");
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
