using System;
using System.Collections.Generic;
using System.Text;
using System.Web;

namespace StudentHelperApp
{
    public partial class TryItSession : System.Web.UI.Page
    {
        private string CurrentUser
        {
            get
            {
                object user = Session["User"];
                return user == null ? null : user.ToString();
            }
        }

        private string StudyPlanSessionKey
        {
            get { return SessionKeys.GetStudyPlanEntriesKey(CurrentUser); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
         if (Session["User"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            lblSessionId.Text = "Session ID: " + Session.SessionID;
            DisplaySessionData();
        }

        protected void btnAddCourse_Click(object sender, EventArgs e)
        {
            string courseName = txtCourseName.Text.Trim();
            string creditStr = txtCreditHours.Text.Trim();
            string studyStr = txtStudyHours.Text.Trim();

            if (string.IsNullOrEmpty(courseName))
            {
                lblStatus.Text = "Please enter a course name.";
                return;
            }

            int credits;
            if (!int.TryParse(creditStr, out credits) || credits <= 0)
            {
                lblStatus.Text = "Credit hours must be a positive integer.";
                return;
            }

            double studyHours;
            if (!double.TryParse(studyStr, out studyHours) || studyHours <= 0)
            {
                lblStatus.Text = "Study hours must be a positive number.";
                return;
            }

            List<StudyEntry> entries = GetSessionEntries();

            entries.Add(new StudyEntry
            {
                CourseName = courseName,
                CreditHours = credits,
                PlannedStudyHours = studyHours,
                AddedAt = DateTime.Now
            });

            Session[StudyPlanSessionKey] = entries;

            txtCourseName.Text = "";
            txtCreditHours.Text = "";
            txtStudyHours.Text = "";

            lblStatus.Text = string.Format("Added '{0}' to session. Total entries: {1}",
                courseName, entries.Count);

            DisplaySessionData();
        }

        protected void btnClearSession_Click(object sender, EventArgs e)
        {
            Session.Remove(StudyPlanSessionKey);
            lblStatus.Text = "Session data cleared.";
            DisplaySessionData();
        }

        private List<StudyEntry> GetSessionEntries()
        {
            object obj = Session[StudyPlanSessionKey];
            if (obj != null && obj is List<StudyEntry>)
            {
                return (List<StudyEntry>)obj;
            }
            return new List<StudyEntry>();
        }

        private void DisplaySessionData()
        {
            List<StudyEntry> entries = GetSessionEntries();

            if (entries.Count == 0)
            {
                string who = string.IsNullOrEmpty(CurrentUser)
                    ? "(anonymous session)"
                    : ("for user: <strong>" + HttpUtility.HtmlEncode(CurrentUser) + "</strong>");

                litSessionData.Text = "No courses stored in session yet " + who + ". Add some above!";
                return;
            }

            StringBuilder sb = new StringBuilder();
            sb.Append("<table style='width:100%; border-collapse:collapse; margin-top:8px;'>");
            sb.Append("<tr style='background:#e8ecf1;'>");
            sb.Append("<th style='border:1px solid #bbb; padding:8px;'>#</th>");
            sb.Append("<th style='border:1px solid #bbb; padding:8px;'>Course</th>");
            sb.Append("<th style='border:1px solid #bbb; padding:8px;'>Credits</th>");
            sb.Append("<th style='border:1px solid #bbb; padding:8px;'>Study Hrs/Week</th>");
            sb.Append("<th style='border:1px solid #bbb; padding:8px;'>Added At</th>");
            sb.Append("</tr>");

            double totalStudy = 0;
            int totalCredits = 0;

            for (int i = 0; i < entries.Count; i++)
            {
                StudyEntry entry = entries[i];
                sb.AppendFormat(
                    "<tr><td style='border:1px solid #bbb; padding:8px; text-align:center;'>{0}</td>" +
                    "<td style='border:1px solid #bbb; padding:8px;'>{1}</td>" +
                    "<td style='border:1px solid #bbb; padding:8px; text-align:center;'>{2}</td>" +
                    "<td style='border:1px solid #bbb; padding:8px; text-align:center;'>{3}</td>" +
                    "<td style='border:1px solid #bbb; padding:8px;'>{4}</td></tr>",
                    i + 1,
                    HttpUtility.HtmlEncode(entry.CourseName),
                    entry.CreditHours,
                    entry.PlannedStudyHours,
                    entry.AddedAt.ToString("HH:mm:ss"));

                totalCredits += entry.CreditHours;
                totalStudy += entry.PlannedStudyHours;
            }

            sb.AppendFormat(
                "<tr style='background:#eef6ee; font-weight:bold;'>" +
                "<td style='border:1px solid #bbb; padding:8px;' colspan='2'>Totals</td>" +
                "<td style='border:1px solid #bbb; padding:8px; text-align:center;'>{0}</td>" +
                "<td style='border:1px solid #bbb; padding:8px; text-align:center;'>{1}</td>" +
                "<td style='border:1px solid #bbb; padding:8px;'></td></tr>",
                totalCredits, totalStudy);

            sb.Append("</table>");

            litSessionData.Text = sb.ToString();
        }
    }

    [Serializable]
    public class StudyEntry
    {
        public string CourseName { get; set; }
        public int CreditHours { get; set; }
        public double PlannedStudyHours { get; set; }
        public DateTime AddedAt { get; set; }
    }
}
