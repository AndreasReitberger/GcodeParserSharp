# GcodeParserSharp
A simple C# project to parse gcode files and get the estimated print time and extruded filament volume.
The logic behind the project is based on the gCodeViewer by @hudbrog.

Project: https://github.com/hudbrog/gCodeViewer
License: https://github.com/hudbrog/gCodeViewer/blob/master/LICENSE (https://creativecommons.org/licenses/by/4.0/)

# Usage
You can use the `GcodeParser.Instance` to parse any gcode file.
```csharp
var prog = new Progress<int>(percent =>
{
    gc.Progress = percent;
});
string filePath = "your.gcode";
Gcode gcode = await GcodeParser.Instance.FromFileAsync(filePath, prog, cts.Token, true);
```
