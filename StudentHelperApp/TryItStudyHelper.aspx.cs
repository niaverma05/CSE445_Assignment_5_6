using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;

namespace StudentHelperApp
{
    public partial class TryItStudyHelper : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnHealthCheck_Click(object sender, EventArgs e)
        {
            try
            {
                string baseUrl = Request.Url.GetLeftPart(UriPartial.Authority)
                    + Request.ApplicationPath.TrimEnd('/');
                string url = baseUrl + "/StudyHelperService.svc/HealthCheck";

                HttpWebRequest req = (HttpWebRequest)WebRequest.Create(url);
                req.Method = "GET";
                req.Accept = "application/json";
                req.Timeout = 10000;

                using (HttpWebResponse resp = (HttpWebResponse)req.GetResponse())
                using (StreamReader reader = new StreamReader(resp.GetResponseStream()))
                {
                    string body = reader.ReadToEnd();
                    lblHealthStatus.Text = " Service OK: " + body;
                    lblHealthStatus.CssClass = "status-ok";
                }
            }
            catch (Exception ex)
            {
                lblHealthStatus.Text = " Service error: " + ex.Message;
                lblHealthStatus.CssClass = "status-err";
            }
        }

        protected void btnQuickRec_Click(object sender, EventArgs e)
        {
            try
            {
                int credits;
                if (!int.TryParse(txtQuickCredits.Text.Trim(), out credits) || credits <= 0)
                {
                    lblQuickResult.Text = "Please enter a valid positive number for credit hours.";
                    return;
                }

                var service = new StudyHelperService();
                string recommendation = service.GetStudyRecommendation(credits);
                lblQuickResult.Text = recommendation;
            }
            catch (Exception ex)
            {
                lblQuickResult.Text = "Error: " + ex.Message;
            }
        }

        protected void btnLoadSample_Click(object sender, EventArgs e)
        {
            txtCourses.Text = "CSE445, DAT301, CSE463";
            txtCredits.Text = "3, 3, 3";
            txtAvailableHours.Text = "20";
        }

        protected void btnGeneratePlan_Click(object sender, EventArgs e)
        {
            try
            {
                lblPlanError.Text = "";
                pnlPlanResult.Visible = false;

                string courses = txtCourses.Text.Trim();
                string credits = txtCredits.Text.Trim();
                string hoursStr = txtAvailableHours.Text.Trim();

                if (string.IsNullOrEmpty(courses) || string.IsNullOrEmpty(credits))
                {
                    lblPlanError.Text = "Please enter courses and credit hours.";
                    return;
                }

                double availableHours;
                if (!double.TryParse(hoursStr, out availableHours))
                    availableHours = 0;

                var request = new StudyPlanRequest
                {
                    CoursesCsv = courses,
                    CreditsCsv = credits,
                    AvailableHoursPerWeek = availableHours
                };

                var service = new StudyHelperService();
                StudyPlan plan = service.GenerateStudyPlan(request);

                StringBuilder sb = new StringBuilder();
                sb.Append("<table class='plan'>");
                sb.Append("<tr><th>Course</th><th>Credits</th><th>Recommended Study Hrs/Week</th></tr>");

                foreach (var alloc in plan.Allocations)
                {
                    sb.AppendFormat(
                        "<tr><td>{0}</td><td style='text-align:center;'>{1}</td>" +
                        "<td style='text-align:center;'>{2}</td></tr>",
                        HttpUtility.HtmlEncode(alloc.CourseName),
                        alloc.CreditHours,
                        alloc.RecommendedStudyHours);
                }

                sb.AppendFormat(
                    "<tr style='font-weight:bold; background:#eef6ee;'>" +
                    "<td>Total</td><td></td><td style='text-align:center;'>{0}</td></tr>",
                    plan.TotalHoursAllocated);

                sb.Append("</table>");

                litPlanTable.Text = sb.ToString();
                lblPlanSummary.Text = plan.Summary;
                pnlPlanResult.Visible = true;
            }
            catch (Exception ex)
            {
                lblPlanError.Text = "Error: " + ex.Message;
            }
        }
    }
}
