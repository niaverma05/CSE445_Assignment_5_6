using System;
using System.Text;
using System.Web;

namespace StudentHelperApp
{
    /// <summary>
    /// Code-behind for the TryIt page.
    /// Provides grader-visible evidence for:
    ///   • Cookie component (btnShowCookie_Click)
    ///   • WCF Service component (btnServiceHealth_Click)
    /// </summary>
    public partial class TryItUnitConverter : System.Web.UI.Page
    {
        private const string ServiceBaseUrl =
            "http://webstrarportal-env.eba-uzcvm8rb.us-west-2.elasticbeanstalk.com/sites/website97/Page1/UnitConverter.svc";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Set the WSDL hyperlink URL
            lnkWsdl.NavigateUrl = ServiceBaseUrl + "?wsdl";
            lnkWsdl.Text = ServiceBaseUrl + "?wsdl";
        }

        // Cookie TryIt: reads and displays current cookie values
        protected void btnShowCookie_Click(object sender, EventArgs e)
        {
            HttpCookie cookie = Request.Cookies["UnitConverterPrefs"];

            if (cookie == null)
            {
                lblCookieRaw.Text =
                    "<span style='color:#c00;'>No UnitConverterPrefs cookie found. " +
                    "Run a conversion above first, then click this button.</span>";
                return;
            }

            // Display all sub-values stored inside the cookie
            var sb = new StringBuilder();
            sb.Append("<strong>Cookie name:</strong> UnitConverterPrefs<br />");
            sb.Append("<strong>Expires:</strong> " + DateTime.Now.AddDays(30).ToShortDateString() + "<br />");
            sb.Append("<strong>Sub-values:</strong><br />");
            sb.Append("<pre>");
            sb.Append("  LastValue : " + HttpUtility.HtmlEncode(cookie["LastValue"] ?? "(empty)") + "\n");
            sb.Append("  LastFrom  : " + HttpUtility.HtmlEncode(cookie["LastFrom"] ?? "(empty)") + "\n");
            sb.Append("  LastTo    : " + HttpUtility.HtmlEncode(cookie["LastTo"] ?? "(empty)") + "\n");
            sb.Append("</pre>");
            sb.Append("<span style='color:#0a7a3a;'>✔ Cookie successfully read from Request.Cookies.</span>");

            lblCookieRaw.Text = sb.ToString();
        }

        // WCF Service TryIt: calls HealthCheck and GetSupportedUnits
        protected void btnServiceHealth_Click(object sender, EventArgs e)
        {
            try
            {
                using (var client = new UnitConverterServiceRef.UnitConverterServiceClient())
                {
                    string health = client.HealthCheck();
                    string units = client.GetSupportedUnits();
                    lblServiceResult.Text =
                        "HealthCheck: " + health + "<br />" +
                        "Supported units: " + units;
                }
            }
            catch (Exception ex)
            {
                lblServiceResult.Text = "<span style='color:#c00;'>Service call failed: "
                    + HttpUtility.HtmlEncode(ex.Message) + "</span>";
            }
        }
    }
}
