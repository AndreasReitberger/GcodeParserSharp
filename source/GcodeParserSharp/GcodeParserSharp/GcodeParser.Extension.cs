using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;

namespace AndreasReitberger
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
                if (double.TryParse(s, out double diameter))
                {
                    diameter = Convert.ToDouble(s, culture);
                    elements.Add(diameter);
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

        #endregion
    }
}
