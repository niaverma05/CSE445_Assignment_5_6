using System;
using System.Security.Cryptography;
using System.Text;

namespace StudentHelperApp
{
    public static class SecurityHelper
    {
        public static string HashPassword(string password)
        {
            if (string.IsNullOrEmpty(password))
                throw new ArgumentException("Password cannot be empty.");

            using (SHA256 sha256 = SHA256.Create())
            {
                // Convert password to bytes and compute hash
                byte[] bytes = Encoding.UTF8.GetBytes(password);
                byte[] hash  = sha256.ComputeHash(bytes);

                // Convert hash bytes to lowercase hex string
                StringBuilder sb = new StringBuilder();
                foreach (byte b in hash)
                    sb.Append(b.ToString("x2"));

                return sb.ToString();
            }
        }

        public static bool VerifyPassword(string password, string storedHash)
        {
            if (string.IsNullOrEmpty(password) || string.IsNullOrEmpty(storedHash))
                return false;

            string hashOfInput = HashPassword(password);

            // Case-insensitive comparison of hex strings
            return string.Equals(hashOfInput, storedHash,
                StringComparison.OrdinalIgnoreCase);
        }
    }
}
