using System;
using System.Web;

namespace StudentHelperApp
{
    public partial class Member : System.Web.UI.Page
    {
        private const string UsernameCookieName = "RememberUsername";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Redirect to login if not authenticated
            if (Session["User"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Make sure only members (not staff) access this page
            if (Session["Role"] != null && Session["Role"].ToString() == "Staff")
            {
                Response.Redirect("Staff.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblUsername.Text = Server.HtmlEncode(Session["User"].ToString());
                lblSessionInfo.Text = Server.HtmlEncode(Session["User"].ToString());
                lblSessionId.Text = Session.SessionID;

                HttpCookie cookie = Request.Cookies[UsernameCookieName];
                if (cookie != null && !string.IsNullOrEmpty(cookie["Username"]))
                {
                    lblMemberCookieStatus.Text =
                        "&#10003; RememberUsername cookie is active. " +
                        "Saved username: <strong>" +
                        Server.HtmlEncode(cookie["Username"]) +
                        "</strong>. Your login form will be pre-filled next visit.";
                }
                else
                {
                    lblMemberCookieStatus.Text =
                        "No RememberUsername cookie found. " +
                        "Check &ldquo;Remember my username&rdquo; on the login page to save one.";
                }
            }
        }

        // Logout button — clears session and redirects to login
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}
