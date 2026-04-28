using System;
using System.Web;
using System.Web.UI;

namespace StudentHelperApp
{
    public partial class Login : System.Web.UI.Page
    {
        private const string UsernameCookieName = "RememberUsername";
        private static readonly TimeSpan CookieExpiry = TimeSpan.FromDays(30);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // If the user is already logged in, skip the login page
                if (Session["User"] != null)
                {
                    // Redirect to appropriate page based on role
                    if (Session["Role"] != null && Session["Role"].ToString() == "Staff")
                        Response.Redirect("Staff.aspx");
                    else
                        Response.Redirect("Member.aspx");
                }

                // Restore username from cookie
                HttpCookie cookie = Request.Cookies[UsernameCookieName];
                if (cookie != null && !string.IsNullOrEmpty(cookie["Username"]))
                {
                    txtUsername.Text = cookie["Username"];
                    chkRemember.Checked = true;
                    lblCookieInfo.Text =
                        "&#10003; Username pre-filled from saved cookie " +
                        "(expires " + DateTime.Now.Add(CookieExpiry).ToShortDateString() + "). " +
                        "Cookie key: <strong>RememberUsername</strong>.";
                }
                else
                {
                    lblCookieInfo.Text =
                        "No saved username cookie found. " +
                        "Check &ldquo;Remember my username&rdquo; and log in to save one.";
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                ShowError("Please enter both username and password.");
                return;
            }

            // Check staff credentials first, then member credentials
            if (UserManager.ValidateStaff(username, password))
            {
                // Save cookie before redirecting
                HandleRememberMeCookie(username);

                Session["User"] = username;
                Session["Role"] = "Staff";
                Response.Redirect("Staff.aspx");
            }
            else if (UserManager.ValidateUser(username, password))
            {
                // Save cookie before redirecting
                HandleRememberMeCookie(username);

                Session["User"] = username;
                Session["Role"] = "Member";
                Response.Redirect("Member.aspx");
            }
            else
            {
                ShowError("Invalid username or password.");
                UpdateCookieStatus();
            }
        }

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                ShowError("Please enter a username and password to sign up.");
                return;
            }

            if (password.Length < 6)
            {
                ShowError("Password must be at least 6 characters.");
                return;
            }

            bool created = UserManager.CreateUser(username, password);

            if (created)
            {
                // Save cookie for newly created user if remember is checked
                HandleRememberMeCookie(username);

                lblMessage.Text = "Account created! You can now log in.";
                lblMessage.CssClass = "msg-success";
                UpdateCookieStatus();
            }
            else
            {
                ShowError("Username already exists. Please choose a different username.");
            }
        }

        private void HandleRememberMeCookie(string username)
        {
            if (chkRemember.Checked)
            {
                // Write persistent cookie with username
                HttpCookie cookie = new HttpCookie(UsernameCookieName)
                {
                    Expires = DateTime.Now.Add(CookieExpiry),
                    HttpOnly = true
                };
                cookie["Username"] = username;
                Response.Cookies.Add(cookie);
            }
            else
            {
                // Clear any existing cookie if the user unchecked the box
                if (Request.Cookies[UsernameCookieName] != null)
                {
                    HttpCookie expiredCookie = new HttpCookie(UsernameCookieName)
                    {
                        Expires = DateTime.Now.AddDays(-1)
                    };
                    Response.Cookies.Add(expiredCookie);
                }
            }
        }

        private void UpdateCookieStatus()
        {
            HttpCookie cookie = Request.Cookies[UsernameCookieName];
            if (cookie != null && !string.IsNullOrEmpty(cookie["Username"]))
            {
                lblCookieInfo.Text =
                    "&#10003; Cookie active — saved username: <strong>" +
                    Server.HtmlEncode(cookie["Username"]) + "</strong>.";
            }
            else
            {
                lblCookieInfo.Text = "No username cookie currently saved.";
            }
        }

        private void ShowError(string message)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "msg-error";
        }

        protected void btnTestHash_Click(object sender, EventArgs e)
        {
            string hash1 = SecurityHelper.HashPassword("Cse445!");
            string hash2 = SecurityHelper.HashPassword("test1pass");
            lblHashResult.Text =
                "Hash of Cse445!: " + hash1 + "<br />" +
                "Hash of test1pass: " + hash2;
        }
    }
}
