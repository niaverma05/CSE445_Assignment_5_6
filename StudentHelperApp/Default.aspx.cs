using System;
using System.IO;
using System.Web.Hosting;

namespace StudentHelperApp
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnShowLog_Click(object sender, EventArgs e)
        {
            try
            {
                string logPath = HostingEnvironment.MapPath("~/App_Data/startup.log");

                if (File.Exists(logPath))
                {
                    string[] lines = File.ReadAllLines(logPath);

                    if (lines.Length > 0)
                    {
                        lblLog.Text = "Latest startup log entry: " + Server.HtmlEncode(lines[lines.Length - 1]);
                    }
                    else
                    {
                        lblLog.Text = "The startup log exists, but it is empty.";
                    }
                }
                else
                {
                    lblLog.Text = "Startup log not found yet.";
                }
            }
            catch (Exception ex)
            {
                lblLog.Text = "Error reading startup log: " + Server.HtmlEncode(ex.Message);
            }
        }
    }
}