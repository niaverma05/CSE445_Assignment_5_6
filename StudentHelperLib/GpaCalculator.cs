using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace StudentHelperLib
{
    public class CourseInput
    {
        public string Grade { get; set; }
        public double Credits { get; set; }
    }

    public static class GpaCalculator
    {
        public static double CalculateGpa(IEnumerable<CourseInput> courses)
        {
            if (courses == null)
                throw new ArgumentNullException(nameof(courses));

            double totalCredits = 0;
            double totalPoints = 0;

            foreach (var course in courses)
            {
                if (course == null)
                    continue;

                if (course.Credits <= 0)
                    continue;

                double gradePoints = GradeToPoints(course.Grade);
                totalCredits += course.Credits;
                totalPoints += gradePoints * course.Credits;
            }

            if (totalCredits == 0)
                return 0.0;

            return Math.Round(totalPoints / totalCredits, 2);
        }

        public static double GradeToPoints(string grade)
        {
            if (string.IsNullOrWhiteSpace(grade))
                throw new ArgumentException("Grade is required.");

            switch (grade.Trim().ToUpperInvariant())
            {
                case "A": return 4.0;
                case "A-": return 3.7;
                case "B+": return 3.3;
                case "B": return 3.0;
                case "B-": return 2.7;
                case "C+": return 2.3;
                case "C": return 2.0;
                case "C-": return 1.7;
                case "D+": return 1.3;
                case "D": return 1.0;
                case "F": return 0.0;
                default:
                    throw new ArgumentException("Unsupported grade: " + grade);
            }
        }

        public static string BuildAdvice(double gpa)
        {
            if (gpa >= 3.5)
                return "Excellent work. Keep your workload balanced.";
            if (gpa >= 3.0)
                return "Good standing. Stay consistent with study habits.";
            if (gpa >= 2.0)
                return "You may need to improve one or more courses.";
            return "Talk to an advisor and review your study plan.";
        }

        public static List<CourseInput> ParseInputs(string gradesCsv, string creditsCsv)
        {
            var grades = SplitCsv(gradesCsv);
            var credits = SplitCsv(creditsCsv);

            if (grades.Count != credits.Count)
                throw new ArgumentException("Grades and credits must have the same number of values.");

            var result = new List<CourseInput>();

            for (int i = 0; i < grades.Count; i++)
            {
                double c = double.Parse(credits[i], CultureInfo.InvariantCulture);
                result.Add(new CourseInput
                {
                    Grade = grades[i],
                    Credits = c
                });
            }

            return result;
        }

        private static List<string> SplitCsv(string input)
        {
            if (string.IsNullOrWhiteSpace(input))
                return new List<string>();

            return input
                .Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                .Select(x => x.Trim())
                .Where(x => x.Length > 0)
                .ToList();
        }
    }
}