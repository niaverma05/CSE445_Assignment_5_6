using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace ValidationLib
{
    public static class InputValidator
    {
        // Validates that a password meets security requirements:
        // - At least 8 characters
        // - Contains uppercase, lowercase, digit, and special character
        // Input: string password
        // Output: ValidationResult with IsValid flag and Message
        public static ValidationResult ValidatePassword(string password)
        {
            if (string.IsNullOrEmpty(password))
                return new ValidationResult(false, "Password cannot be empty.");

            if (password.Length < 8)
                return new ValidationResult(false, "Password must be at least 8 characters.");

            if (!Regex.IsMatch(password, @"[A-Z]"))
                return new ValidationResult(false, "Password must contain at least one uppercase letter.");

            if (!Regex.IsMatch(password, @"[a-z]"))
                return new ValidationResult(false, "Password must contain at least one lowercase letter.");

            if (!Regex.IsMatch(password, @"[0-9]"))
                return new ValidationResult(false, "Password must contain at least one digit.");

            if (!Regex.IsMatch(password, @"[!@#$%^&*()_+\-=\[\]{};':""\\|,.<>\/?]"))
                return new ValidationResult(false, "Password must contain at least one special character.");

            return new ValidationResult(true, "Password meets all requirements.");
        }

        // Validates an email address format using regex
        // Input: string email
        // Output: ValidationResult
        public static ValidationResult ValidateEmail(string email)
        {
            if (string.IsNullOrWhiteSpace(email))
                return new ValidationResult(false, "Email cannot be empty.");

            string pattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
            if (!Regex.IsMatch(email, pattern))
                return new ValidationResult(false, "Invalid email format.");

            return new ValidationResult(true, "Email format is valid.");
        }

        // Validates that a numeric string falls within a specified range
        // Input: string value, double min, double max
        // Output: ValidationResult
        public static ValidationResult ValidateNumericRange(string value, double min, double max)
        {
            if (string.IsNullOrWhiteSpace(value))
                return new ValidationResult(false, "Value cannot be empty.");

            double parsed;
            if (!double.TryParse(value, out parsed))
                return new ValidationResult(false, "Value must be a valid number.");

            if (parsed < min || parsed > max)
                return new ValidationResult(false,
                    string.Format("Value must be between {0} and {1}. Got: {2}", min, max, parsed));

            return new ValidationResult(true,
                string.Format("Value {0} is within range [{1}, {2}].", parsed, min, max));
        }

        // Validates that a string contains only comma-separated grade values
        // Accepted grades: A, A-, B+, B, B-, C+, C, C-, D+, D, F
        // Input: string gradesCsv
        // Output: ValidationResult
        public static ValidationResult ValidateGradeList(string gradesCsv)
        {
            if (string.IsNullOrWhiteSpace(gradesCsv))
                return new ValidationResult(false, "Grade list cannot be empty.");

            string[] validGrades = { "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "F" };
            string[] parts = gradesCsv.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

            foreach (string part in parts)
            {
                string trimmed = part.Trim().ToUpperInvariant();
                bool found = false;
                foreach (string vg in validGrades)
                {
                    if (trimmed == vg) { found = true; break; }
                }
                if (!found)
                    return new ValidationResult(false, "Invalid grade: " + part.Trim());
            }

            return new ValidationResult(true,
                string.Format("All {0} grade(s) are valid.", parts.Length));
        }

        // Sanitizes user input by trimming whitespace and removing HTML tags
        // Input: string raw input
        // Output: sanitized string
        public static string SanitizeInput(string input)
        {
            if (string.IsNullOrEmpty(input))
                return string.Empty;

            string cleaned = Regex.Replace(input, @"<[^>]*>", string.Empty);
            cleaned = cleaned.Trim();
            return cleaned;
        }
    }

    public class ValidationResult
    {
        public bool IsValid { get; set; }
        public string Message { get; set; }

        public ValidationResult(bool isValid, string message)
        {
            IsValid = isValid;
            Message = message;
        }
    }

}
