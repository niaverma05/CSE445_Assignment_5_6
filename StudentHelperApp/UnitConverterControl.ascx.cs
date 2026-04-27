using System;
using System.Web;
using System.Web.UI;

// NOTE: Before building, add a Service Reference to your deployed WCF service.
// In Visual Studio: right-click project → Add Service Reference →
//   enter http://your-webstar-url/UnitConverter.svc?wsdl
//   Namespace: UnitConverterServiceRef
// Then uncomment the "using StudentHelperApp.UnitConverterServiceRef;" line below.

// using StudentHelperApp.UnitConverterServiceRef;

namespace StudentHelperApp
{
    /// <summary>
    /// Reusable User Control that wraps the UnitConverter WCF service.
    /// Cookie component is embedded here: the control saves and restores
    /// the user's last selected From/To units and value via an HTTP cookie.
    /// Provider: [Your Name]
    /// </summary>
    public partial class UnitConverterControl : UserControl
    {
        private const string CookieName   = "UnitConverterPrefs";
        private const string CookieValue  = "LastValue";
        private const string CookieFrom   = "LastFrom";
        private const string CookieTo     = "LastTo";

        // Expiry: preferences remembered for 30 days
        private static readonly TimeSpan CookieExpiry = TimeSpan.FromDays(30);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // On first load: restore last inputs from cookie (if present)
                RestoreFromCookie();
            }
        }

        protected void btnConvert_Click(object sender, EventArgs e)
        {
            // Validate numeric input
            double value;
            if (!double.TryParse(txtValue.Text.Trim(), out value))
            {
                lblResult.Text       = "⚠ Please enter a valid number.";
                lblCookieStatus.Text = "";
                return;
            }

            string fromUnit = ddlFrom.SelectedValue;
            string toUnit   = ddlTo.SelectedValue;

            try
            {
                double result = CallConverterService(value, fromUnit, toUnit);

                lblResult.Text = string.Format("{0} {1}  =  {2} {3}",
                    value, fromUnit.ToUpper(),
                    result, toUnit.ToUpper());

                // Save preferences to cookie after a successful conversion
                SaveToCookie(txtValue.Text.Trim(), fromUnit, toUnit);
                lblCookieStatus.Text = "✔ Preferences saved to cookie " +
                    "(expires " + DateTime.Now.Add(CookieExpiry).ToShortDateString() + ")";
            }
            catch (Exception ex)
            {
                lblResult.Text       = "Error: " + ex.Message;
                lblCookieStatus.Text = "";
            }
        }

        protected void btnClearCookie_Click(object sender, EventArgs e)
        {
            // Expire the cookie immediately
            if (Request.Cookies[CookieName] != null)
            {
                HttpCookie expiredCookie = new HttpCookie(CookieName)
                {
                    Expires = DateTime.Now.AddDays(-1)
                };
                Response.Cookies.Add(expiredCookie);
            }

            // Reset form fields to defaults
            txtValue.Text        = "";
            ddlFrom.SelectedIndex = 0;
            ddlTo.SelectedIndex   = 0;

            lblResult.Text       = "";
            lblCookieStatus.Text = "Cookie cleared.";
        }

        /// <summary>
        /// Writes (or overwrites) the preferences cookie.
        /// </summary>
        private void SaveToCookie(string value, string fromUnit, string toUnit)
        {
            HttpCookie cookie = new HttpCookie(CookieName)
            {
                Expires  = DateTime.Now.Add(CookieExpiry),
                HttpOnly = true
            };

            // Store sub-values inside the single cookie
            cookie[CookieValue] = value;
            cookie[CookieFrom]  = fromUnit;
            cookie[CookieTo]    = toUnit;

            Response.Cookies.Add(cookie);
        }

        /// <summary>
        /// Reads the preferences cookie and pre-populates the form.
        /// </summary>
        private void RestoreFromCookie()
        {
            HttpCookie cookie = Request.Cookies[CookieName];

            if (cookie == null)
            {
                lblCookieStatus.Text = "No saved preferences found (cookie not set yet).";
                return;
            }

            // Restore value
            if (!string.IsNullOrEmpty(cookie[CookieValue]))
                txtValue.Text = cookie[CookieValue];

            // Restore From dropdown
            if (!string.IsNullOrEmpty(cookie[CookieFrom]))
            {
                System.Web.UI.WebControls.ListItem fromItem =
                    ddlFrom.Items.FindByValue(cookie[CookieFrom]);
                if (fromItem != null)
                    ddlFrom.SelectedValue = fromItem.Value;
            }

            // Restore To dropdown
            if (!string.IsNullOrEmpty(cookie[CookieTo]))
            {
                System.Web.UI.WebControls.ListItem toItem =
                    ddlTo.Items.FindByValue(cookie[CookieTo]);
                if (toItem != null)
                    ddlTo.SelectedValue = toItem.Value;
            }

            lblCookieStatus.Text = "✔ Form pre-filled from saved cookie " +
                "(expires " + DateTime.Now.AddDays(30).ToShortDateString() + ")";
        }

        // ---------------------------------------------------------------
        // Service call (proxy call to deployed WCF service)
        // ---------------------------------------------------------------

        /// <summary>
        /// Calls the deployed UnitConverter WCF service.
        ///
        /// HOW TO WIRE THIS UP:
        ///   1. Deploy UnitConverterService to WebStrar.
        ///   2. Right-click StudentHelperApp project → Add Service Reference.
        ///   3. Enter the ?wsdl URL, set namespace to UnitConverterServiceRef.
        ///   4. Delete the fallback method below and use the proxy client instead.
        ///
        /// The commented-out block shows the production proxy call.
        /// The fallback below does local math so the page works even before
        /// the service reference is added (useful during development).
        /// </summary>
        private double CallConverterService(double value, string fromUnit, string toUnit)
        {
            using (var client = new UnitConverterServiceRef.UnitConverterServiceClient())
            {
                return client.ConvertUnits(value, fromUnit, toUnit);
            }
        }
    }
}
