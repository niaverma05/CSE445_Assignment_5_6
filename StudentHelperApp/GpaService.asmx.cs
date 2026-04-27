using System.Collections.Generic;
using System.Web.Services;
using System.Web.Script.Services;
using StudentHelperLib;

namespace StudentHelperApp
{
    [WebService(Namespace = "http://studenthelperapp.local/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [ScriptService]
    public class GpaService : WebService
    {
        [WebMethod]
        public double CalculateGpa(string gradesCsv, string creditsCsv)
        {
            List<CourseInput> courses = GpaCalculator.ParseInputs(gradesCsv, creditsCsv);
            return GpaCalculator.CalculateGpa(courses);
        }

        [WebMethod]
        public string GetAdvice(double gpa)
        {
            return GpaCalculator.BuildAdvice(gpa);
        }

        [WebMethod]
        public string HealthCheck()
        {
            return "StudentHelper GPA service is running.";
        }
    }
}