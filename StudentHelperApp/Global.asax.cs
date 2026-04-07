using System;
using System.IO;
using System.Web;
using System.Web.Hosting;

namespace StudentHelperApp
{
    public class Global : HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            try
            {
                string logPath = HostingEnvironment.MapPath("~/App_Data/startup.log");

                if (!File.Exists(logPath))
                {
                    string dir = Path.GetDirectoryName(logPath);
                    if (!Directory.Exists(dir))
                    {
                        Directory.CreateDirectory(dir);
                    }

                    File.WriteAllText(logPath, string.Empty);
                }

                File.AppendAllText(
                    logPath,
                    $"{DateTime.Now:yyyy-MM-dd HH:mm:ss} - Application started{Environment.NewLine}"
                );
            }
            catch
            {
            }
        }
    }
}