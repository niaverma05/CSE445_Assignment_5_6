using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using System.Web.Hosting;
using StudentHelperLib;

namespace StudentHelperApp
{
    public static class UserManager
    {
        private static string memberPath = HostingEnvironment.MapPath("~/App_Data/Member.xml");
        private static string staffPath = HostingEnvironment.MapPath("~/App_Data/Staff.xml");

        // ----------------- MEMBER -----------------

        public static bool CreateUser(string username, string password)
        {
            XmlDocument doc = new XmlDocument();
            doc.Load(memberPath);

            XmlNode root = doc.DocumentElement;

            foreach (XmlNode user in root.SelectNodes("User"))
            {
                if (user["Username"].InnerText == username)
                {
                    return false;
                }
            }

            XmlNode newUser = doc.CreateElement("User");

            XmlNode userNode = doc.CreateElement("Username");
            userNode.InnerText = username;

            XmlNode passNode = doc.CreateElement("Password");
            passNode.InnerText = SecurityHelper.HashPassword(password);

            XmlNode registeredNode = doc.CreateElement("Registered");
            registeredNode.InnerText = DateTime.Now.ToString("yyyy-MM-dd");

            newUser.AppendChild(userNode);
            newUser.AppendChild(passNode);
            newUser.AppendChild(registeredNode);

            root.AppendChild(newUser);
            doc.Save(memberPath);

            return true;
        }

        public static bool ValidateUser(string username, string password)
        {
            XmlDocument doc = new XmlDocument();
            doc.Load(memberPath);

            foreach (XmlNode user in doc.SelectNodes("//User"))
            {
                if (user["Username"].InnerText == username)
                {
                    string storedHash = user["Password"].InnerText;
                    return SecurityHelper.VerifyPassword(password, storedHash);
                }
            }

            return false;
        }

        // ----------------- STAFF -----------------

        public static bool ValidateStaff(string username, string password)
        {
            XmlDocument doc = new XmlDocument();
            doc.Load(staffPath);

            foreach (XmlNode user in doc.SelectNodes("//User"))
            {
                if (user["Username"].InnerText == username)
                {
                    string storedHash = user["Password"].InnerText;
                    return SecurityHelper.VerifyPassword(password, storedHash);
                }
            }

            return false;
        }
    }
}