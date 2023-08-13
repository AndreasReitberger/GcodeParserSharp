using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace AndreasReitberger.Parser.Gcode
{
    public partial class GcodeParser
    {
        #region Extensions

        public string ConcatNumericDataString(List<string> data, CultureInfo culture, Regex pattern = null, string joinChar = "|")
        {
            List<double> elements = new();
            foreach (string line in data)
            {
                string s = pattern != null
                    ? pattern.Match(line).Groups[1].Value
                    : line.Split(new string[] { "=" }, StringSplitOptions.RemoveEmptyEntries).LastOrDefault().Trim();
                // Check if it's a valid double format
                if (double.TryParse(s, out double diameter))
                {
                    diameter = Convert.ToDouble(s, culture);
                    elements.Add(diameter);
                }
            }
            if (elements.Count == 0) return default;
            return elements.Count > 1 ? string.Join(joinChar, elements) : elements.FirstOrDefault().ToString();
        }

        public string ConcatNumericDataString(string data, string separator, CultureInfo culture, Regex pattern = null, string joinChar = "|")
        {
            List<double> elements = new();
            List<string> strings = new(data.Split(new string[] { separator }, StringSplitOptions.RemoveEmptyEntries));
            foreach (string line in strings)
            {
                string s = pattern != null
                    ? pattern.Match(line).Groups[1].Value
                    : line.Split(new string[] { "=" }, StringSplitOptions.RemoveEmptyEntries).LastOrDefault().Trim();
                // Check if it's a valid double format
                if (double.TryParse(s, out double numericValue))
                {
                    numericValue = Convert.ToDouble(s, culture);
                    elements.Add(numericValue);
                }
            }
            if (elements.Count == 0) return default;
            return elements.Count > 1 ? string.Join(joinChar, elements) : elements.FirstOrDefault().ToString();
        }

        public string ConcatDataString(string data, string separator, CultureInfo culture, Regex pattern = null, string joinChar = "|")
        {
            List<string> elements = new();
            List<string> strings = new(data.Split(new string[] { separator }, StringSplitOptions.RemoveEmptyEntries));
            foreach (string line in strings)
            {
                string s = pattern != null
                    ? pattern.Match(line).Groups[1].Value
                    : line.Split(new string[] { "=" }, StringSplitOptions.RemoveEmptyEntries).LastOrDefault().Trim();
                elements.Add(s);
            }
            if (elements.Count == 0) return default;
            return elements.Count > 1 ? string.Join(joinChar, elements) : elements.FirstOrDefault().ToString();
        }

        public List<byte[]> GetThumbnails(List<string> comments, string pattern = @"(?:^; thumbnail(?:_JPG)* begin \d+[x ]\d+ \d+)(?:\n|\r\n?)((?:.+(?:\n|\r\n?))+?)(?:^; thumbnail(?:_JPG)* end)")
        {
            // Pattern taken from: https://github.com/jneilliii/OctoPrint-PrusaSlicerThumbnails/blob/master/octoprint_prusaslicerthumbnails/__init__.py
            //pattern = @"(?:^; thumbnail(?:_JPG)* begin \d+[x ]\d+ \d+)(?:\n|\r\n?)((?:.+(?:\n|\r\n?))+?)(?:^; thumbnail(?:_JPG)* end)";
            List<byte[]> thumbnails = new();
            string thumbnail = string.Join(Environment.NewLine, comments);
            MatchCollection regex = Regex.Matches(thumbnail, pattern, RegexOptions.Multiline);
            foreach (var match in regex)
            {
                string capture = match.ToString();
                // Remove first and last line
                //var p = capture?.Split("; ", StringSplitOptions.RemoveEmptyEntries);
                capture = string
                    .Join(
#if NET6_0_OR_GREATER || NETSTANDARD2_1
                        string.Empty, capture?.Split("; ", StringSplitOptions.RemoveEmptyEntries)
#else
                        string.Empty, capture?.Split(new string[] { "; " } , StringSplitOptions.RemoveEmptyEntries)
#endif
                        .Skip(1)
#if NET6_0_OR_GREATER || NETSTANDARD2_1
                        .SkipLast(1)
#else
                        .Take(capture.Split(new string[] { "; " }, StringSplitOptions.RemoveEmptyEntries).Count() - 2)
#endif
                    );
                byte[] image = Base64StringToByteArray(capture);
                if(image?.Length > 0)
                    thumbnails.Add(image);          
            }
            return thumbnails;
        }

        public static byte[] StringToByteArray(string hex)
        {
            return Enumerable.Range(0, hex.Length)
                             .Where(x => x % 2 == 0)
                             .Select(x => Convert.ToByte(hex.Substring(x, 2), 16))
                             .ToArray();
        }

        public static byte[] Base64StringToByteArray(string hex)
        {
            return Convert.FromBase64String(hex);
        }
#endregion
    }
}
