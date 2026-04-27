using System.ServiceModel;
using System.ServiceModel.Web;
using System.Runtime.Serialization;
using System.Collections.Generic;

namespace StudentHelperApp
{
    [ServiceContract]
    public interface IStudyHelperService
    {
        [OperationContract]
        [WebInvoke(Method = "POST",
            RequestFormat = WebMessageFormat.Json,
            ResponseFormat = WebMessageFormat.Json,
            UriTemplate = "GenerateStudyPlan")]
        StudyPlan GenerateStudyPlan(StudyPlanRequest request);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json,
            UriTemplate = "GetStudyRecommendation?creditHours={creditHours}")]
        string GetStudyRecommendation(int creditHours);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json,
            UriTemplate = "HealthCheck")]
        string HealthCheck();
    }

    [DataContract]
    public class StudyPlanRequest
    {
        [DataMember]
        public string CoursesCsv { get; set; }

        [DataMember]
        public string CreditsCsv { get; set; }

        [DataMember]
        public double AvailableHoursPerWeek { get; set; }
    }

    [DataContract]
    public class StudyPlan
    {
        [DataMember]
        public List<CourseAllocation> Allocations { get; set; }

        [DataMember]
        public double TotalHoursAllocated { get; set; }

        [DataMember]
        public string Summary { get; set; }
    }

    [DataContract]
    public class CourseAllocation
    {
        [DataMember]
        public string CourseName { get; set; }

        [DataMember]
        public int CreditHours { get; set; }

        [DataMember]
        public double RecommendedStudyHours { get; set; }
    }
}
