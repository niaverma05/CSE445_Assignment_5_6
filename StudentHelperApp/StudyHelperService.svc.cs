using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel.Activation;

namespace StudentHelperApp
{
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class StudyHelperService : IStudyHelperService
    {
        private const double STUDY_HOURS_PER_CREDIT = 2.5;

        public StudyPlan GenerateStudyPlan(StudyPlanRequest request)
        {
            if (request == null)
                throw new ArgumentNullException("request");

            string[] courseNames = ParseCsv(request.CoursesCsv);
            string[] creditStrings = ParseCsv(request.CreditsCsv);

            if (courseNames.Length == 0)
                throw new ArgumentException("At least one course is required.");

            if (courseNames.Length != creditStrings.Length)
                throw new ArgumentException("Number of courses must match number of credit values.");

            int[] credits = new int[creditStrings.Length];
            for (int i = 0; i < creditStrings.Length; i++)
            {
                if (!int.TryParse(creditStrings[i], out credits[i]) || credits[i] <= 0)
                    throw new ArgumentException("Invalid credit hours: " + creditStrings[i]);
            }

            int totalCredits = credits.Sum();
            double recommendedTotal = totalCredits * STUDY_HOURS_PER_CREDIT;
            double availableHours = request.AvailableHoursPerWeek;

            if (availableHours <= 0)
                availableHours = recommendedTotal;

            var allocations = new List<CourseAllocation>();
            double totalAllocated = 0;

            for (int i = 0; i < courseNames.Length; i++)
            {
                double proportion = (double)credits[i] / totalCredits;
                double hours = Math.Round(proportion * availableHours, 1);

                allocations.Add(new CourseAllocation
                {
                    CourseName = courseNames[i],
                    CreditHours = credits[i],
                    RecommendedStudyHours = hours
                });

                totalAllocated += hours;
            }

            string summary;
            if (availableHours >= recommendedTotal)
            {
                summary = string.Format(
                    "You have {0} hrs/week available for {1} total credits. " +
                    "Recommended minimum is {2} hrs. You are on track.",
                    availableHours, totalCredits, recommendedTotal);
            }
            else
            {
                summary = string.Format(
                    "You have {0} hrs/week available but {1} hrs/week is recommended " +
                    "for {2} credits. Consider reducing your course load or freeing up more time.",
                    availableHours, recommendedTotal, totalCredits);
            }

            return new StudyPlan
            {
                Allocations = allocations,
                TotalHoursAllocated = Math.Round(totalAllocated, 1),
                Summary = summary
            };
        }

        public string GetStudyRecommendation(int creditHours)
        {
            if (creditHours <= 0)
                return "Credit hours must be a positive number.";

            double recommended = creditHours * STUDY_HOURS_PER_CREDIT;

            string level;
            if (creditHours <= 12)
                level = "part-time";
            else if (creditHours <= 18)
                level = "full-time";
            else
                level = "heavy";

            return string.Format(
                "For {0} credit hours ({1} load), aim for about {2} study hours per week " +
                "(roughly {3} hours per credit).",
                creditHours, level, recommended, STUDY_HOURS_PER_CREDIT);
        }

        public string HealthCheck()
        {
            return "StudyHelperService is running. Server time: " +
                   DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
        }

        private string[] ParseCsv(string input)
        {
            if (string.IsNullOrWhiteSpace(input))
                return new string[0];

            return input
                .Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                .Select(s => s.Trim())
                .Where(s => s.Length > 0)
                .ToArray();
        }
    }
}
