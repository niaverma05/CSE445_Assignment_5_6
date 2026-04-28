using System;
using System.Collections.Generic;
using System.Web;
using System.Xml;
using System.Web.Hosting;


namespace StudentHelperApp
{
    public partial class Staff : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Must be logged in as Staff
            if (Session["User"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (Session["Role"] == null || Session["Role"].ToString() != "Staff")
            {
                Response.Redirect("Member.aspx");
                return;
            }

            if (!IsPostBack)
            {
                string username = Session["User"].ToString();
                lblStaffName.Text = Server.HtmlEncode(username);
                lblStaffSession.Text = Server.HtmlEncode(username);
                lblSessionId.Text = Session.SessionID;

                LoadMemberList();
            }
        }

        private void LoadMemberList()
        {
            try
            {
                string memberPath = HostingEnvironment.MapPath("~/App_Data/Member.xml");
                XmlDocument doc = new XmlDocument();
                doc.Load(memberPath);

                var members = new List<MemberRow>();
                foreach (XmlNode node in doc.SelectNodes("//User"))
                {
                    members.Add(new MemberRow
                    {
                        Username = node["Username"]?.InnerText ?? "",
                        Registered = node["Registered"]?.InnerText ?? "N/A"
                    });
                }

                gvMembers.DataSource = members;
                gvMembers.DataBind();
            }
            catch (Exception ex)
            {
                lblStaffSession.Text += " [Error loading members: " +
                    Server.HtmlEncode(ex.Message) + "]";
            }
        }

        // Logout
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        public class MemberRow
        {
            public string Username { get; set; }
            public string Registered { get; set; }
        }
    }
}
