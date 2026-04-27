using System;
using System.Web;
using ValidationLib;

namespace StudentHelperApp
{
    public partial class TryItValidation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnValidatePassword_Click(object sender, EventArgs e)
        {
            string password = txtPassword.Text;
            ValidationResult result = InputValidator.ValidatePassword(password);

            lblPasswordResult.Text = result.Message;
            pnlPasswordResult.CssClass = result.IsValid ? "result pass" : "result fail";
            pnlPasswordResult.Visible = true;
        }

        protected void btnValidateEmail_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text;
            ValidationResult result = InputValidator.ValidateEmail(email);

            lblEmailResult.Text = result.Message;
            pnlEmailResult.CssClass = result.IsValid ? "result pass" : "result fail";
            pnlEmailResult.Visible = true;
        }

        protected void btnValidateNumber_Click(object sender, EventArgs e)
        {
            string value = txtNumber.Text;
            ValidationResult result = InputValidator.ValidateNumericRange(value, 0, 4);

            lblNumberResult.Text = result.Message;
            pnlNumberResult.CssClass = result.IsValid ? "result pass" : "result fail";
            pnlNumberResult.Visible = true;
        }

        protected void btnValidateGrades_Click(object sender, EventArgs e)
        {
            string grades = txtGrades.Text;
            ValidationResult result = InputValidator.ValidateGradeList(grades);

            lblGradesResult.Text = result.Message;
            pnlGradesResult.CssClass = result.IsValid ? "result pass" : "result fail";
            pnlGradesResult.Visible = true;
        }

        protected void btnSanitize_Click(object sender, EventArgs e)
        {
            string raw = txtSanitize.Text;
            string sanitized = InputValidator.SanitizeInput(raw);

            lblSanitizeResult.Text = "Sanitized output: \"" +
                HttpUtility.HtmlEncode(sanitized) + "\"";
            pnlSanitizeResult.Visible = true;
        }
    }
}
