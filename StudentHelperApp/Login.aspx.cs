using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentHelperApp
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;

            if (UserManager.ValidateStaff(username, password))
            {
                Session["User"] = username;
                Response.Redirect("Staff.aspx");
            }
            else if (UserManager.ValidateUser(username, password))
            {
                Session["User"] = username;
                Response.Redirect("Member.aspx");
            }
            else
            {
                lblMessage.Text = "Invalid username or password.";
            }
        }

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;

            bool created = UserManager.CreateUser(username, password);

            if (created)
            {
                lblMessage.Text = "User created! You can now log in.";
            }
            else
            {
                lblMessage.Text = "Username already exists.";
            }
        }
    }
}