using AndreasReitberger;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.IO;
using System.Threading;
using System.Threading.Tasks;

namespace GcodeParserSharp.Test
{
    [TestClass]
    public class UnitTest
    {
        public string testfile = @"Gcodes\Test.gcode";
        [TestMethod]
        public async Task ParseGcodeAsync()
        {
            var prog = new Progress<int>(percent =>
            {
                Console.WriteLine($"Parsed: {percent}%");
            });
            if (File.Exists(testfile))
            {
                CancellationTokenSource cts = new CancellationTokenSource();
                var gcode = await GcodeParser.Instance.FromFileAsync(testfile, prog, cts.Token, false);
                if (gcode != null)
                {
                    Console.WriteLine($"Gcode parsed in: {gcode.ParsingDuration}");
                }
                else
                    Assert.Fail($"Parsed gcoe was null: {testfile}");
            }
            else
                Assert.Fail($"{testfile} not found!");
        }
    }
}
