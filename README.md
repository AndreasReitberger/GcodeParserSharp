# GcodeParserSharp
A simple C# project to parse gcode files and get the estimated print time and extruded filament volume.
The logic behind the project is based on the gCodeViewer by @hudbrog.

Project: https://github.com/hudbrog/gCodeViewer </br>
License: https://github.com/hudbrog/gCodeViewer/blob/master/LICENSE (https://creativecommons.org/licenses/by/4.0/)

# Nuget
Get the latest version from nuget.org<br>
[![NuGet](https://img.shields.io/nuget/v/GcodeParserSharp.svg?style=flat-square&label=nuget)](https://www.nuget.org/packages/GcodeParserSharp/)


# Usage
You can use the `GcodeParser.Instance` to parse any gcode file.
```csharp

public async Task ParseGcodeAsync()
{
    public string testfile = @"Gcodes\Test.gcode";
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
```

# Dependencies
RCoreSharp: https://github.com/AndreasReitberger/CoreSharp </br>
OctoPrintRestApiSharp: https://github.com/AndreasReitberger/OctoPrintRestApiSharp
