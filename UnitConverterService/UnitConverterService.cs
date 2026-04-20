using System;
using System.Collections.Generic;

namespace UnitConverterService
{
    // Implements the IUnitConverterService contract.
    public class UnitConverterService : IUnitConverterService
    {
        private static readonly Dictionary<string, Func<double, double>> _conversions
            = new Dictionary<string, Func<double, double>>(StringComparer.OrdinalIgnoreCase)
        {
            // Distance
            { "miles_to_km",     v => Math.Round(v * 1.60934,   4) },
            { "km_to_miles",     v => Math.Round(v / 1.60934,   4) },
            { "feet_to_meters",  v => Math.Round(v * 0.3048,    4) },
            { "meters_to_feet",  v => Math.Round(v / 0.3048,    4) },

            // Weight
            { "lbs_to_kg",       v => Math.Round(v * 0.453592,  4) },
            { "kg_to_lbs",       v => Math.Round(v / 0.453592,  4) },

            // Temperature
            { "f_to_c",          v => Math.Round((v - 32) * 5.0 / 9.0, 4) },
            { "c_to_f",          v => Math.Round(v * 9.0 / 5.0 + 32,   4) },

            // Volume
            { "gallons_to_liters", v => Math.Round(v * 3.78541, 4) },
            { "liters_to_gallons", v => Math.Round(v / 3.78541, 4) },
        };

        /// <summary>
        /// Converts <paramref name="value"/> from <paramref name="fromUnit"/> to
        /// <paramref name="toUnit"/>.  Throws ArgumentException for unsupported pairs.
        /// </summary>
        public double ConvertUnits(double value, string fromUnit, string toUnit)
        {
            if (string.IsNullOrWhiteSpace(fromUnit))
                throw new ArgumentException("fromUnit is required.");
            if (string.IsNullOrWhiteSpace(toUnit))
                throw new ArgumentException("toUnit is required.");

            // Build the lookup key, e.g. "miles_to_km"
            string key = fromUnit.Trim().ToLowerInvariant()
                         + "_to_"
                         + toUnit.Trim().ToLowerInvariant();

            if (!_conversions.ContainsKey(key))
                throw new ArgumentException(
                    $"Conversion from '{fromUnit}' to '{toUnit}' is not supported. " +
                    "Call GetSupportedUnits() for a full list.");

            return _conversions[key](value);
        }

        /// <summary>
        /// Returns every supported unit token so callers can populate dropdowns.
        /// </summary>
        public string GetSupportedUnits()
        {
            return "miles, km, feet, meters, lbs, kg, f, c, gallons, liters";
        }

        /// <summary>
        /// Quick health-check used by the TryIt page.
        /// </summary>
        public string HealthCheck()
        {
            return "UnitConverter service is running.";
        }
    }
}
