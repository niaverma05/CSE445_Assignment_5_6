<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TryItValidation.aspx.cs" Inherits="StudentHelperApp.TryItValidation" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>TryIt - Validation DLL</title>
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            margin: 24px;
            background: #f5f6fa;
            color: #222;
        }
        .panel {
            max-width: 900px;
            margin: 0 auto;
            background: #fff;
            padding: 24px;
            border: 1px solid #ddd;
            border-radius: 10px;
        }
        h1 { margin-top: 0; }
        h3 { margin-top: 20px; color: #444; }
        label { font-weight: bold; display: block; margin-top: 10px; }
        input[type="text"] {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            margin-top: 4px;
            margin-bottom: 6px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .btn {
            padding: 8px 16px;
            margin-top: 8px;
            background: #4a6fa5;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        .btn:hover { background: #3a5f95; }
        .result {
            margin-top: 10px;
            padding: 10px;
            border-radius: 5px;
            font-weight: bold;
        }
        .pass { background: #d4edda; border: 1px solid #b5d8b5; color: #155724; }
        .fail { background: #f8d7da; border: 1px solid #f5c6cb; color: #721c24; }
        .info { color: #555; font-size: 0.95em; }
        .section {
            border: 1px solid #e0e0e0;
            padding: 16px;
            margin-top: 16px;
            border-radius: 6px;
            background: #fafbfc;
        }
        a.back { display: inline-block; margin-bottom: 16px; color: #4a6fa5; }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="panel">
        <a class="back" href="Default.aspx">&larr; Back to Default</a>

        <h1>Validation DLL TryIt</h1>
        <p class="info">
            This page tests the ValidationLib DLL, which provides input validation
            utilities. Test each validator below with your own inputs.
        </p>

        <div class="section">
            <h3>Password Validator</h3>
            <p class="info">
                Requirements: 8+ characters, uppercase, lowercase, digit, special character.
                Try: <strong>Cse445!</strong> (should fail - too short) or <strong>Cse445!Pass</strong> (should pass)
            </p>
            <label for="txtPassword">Password</label>
            <asp:TextBox ID="txtPassword" runat="server" placeholder="Enter a password to validate" />
            <asp:Button ID="btnValidatePassword" runat="server" Text="Validate Password"
                CssClass="btn" OnClick="btnValidatePassword_Click" />
            <asp:Panel ID="pnlPasswordResult" runat="server" Visible="false" CssClass="result">
                <asp:Label ID="lblPasswordResult" runat="server" />
            </asp:Panel>
        </div>

        <div class="section">
            <h3>Email Validator</h3>
            <p class="info">
                Try: <strong>test@asu.edu</strong> (valid) or <strong>not-an-email</strong> (invalid)
            </p>
            <label for="txtEmail">Email</label>
            <asp:TextBox ID="txtEmail" runat="server" placeholder="Enter an email to validate" />
            <asp:Button ID="btnValidateEmail" runat="server" Text="Validate Email"
                CssClass="btn" OnClick="btnValidateEmail_Click" />
            <asp:Panel ID="pnlEmailResult" runat="server" Visible="false" CssClass="result">
                <asp:Label ID="lblEmailResult" runat="server" />
            </asp:Panel>
        </div>

        <div class="section">
            <h3>Numeric Range Validator</h3>
            <p class="info">
                Validates that a value is a number within [0, 4]. Try: <strong>3.5</strong> (pass) or <strong>5</strong> (fail)
            </p>
            <label for="txtNumber">Value</label>
            <asp:TextBox ID="txtNumber" runat="server" placeholder="Enter a number" />
            <asp:Button ID="btnValidateNumber" runat="server" Text="Validate Range [0, 4]"
                CssClass="btn" OnClick="btnValidateNumber_Click" />
            <asp:Panel ID="pnlNumberResult" runat="server" Visible="false" CssClass="result">
                <asp:Label ID="lblNumberResult" runat="server" />
            </asp:Panel>
        </div>

        <div class="section">
            <h3>Grade List Validator</h3>
            <p class="info">
                Validates comma-separated letter grades. Try: <strong>A,B+,C</strong> (pass)
                or <strong>A,B+,Z</strong> (fail)
            </p>
            <label for="txtGrades">Grades (comma-separated)</label>
            <asp:TextBox ID="txtGrades" runat="server" placeholder="e.g., A,B+,C,A-" />
            <asp:Button ID="btnValidateGrades" runat="server" Text="Validate Grades"
                CssClass="btn" OnClick="btnValidateGrades_Click" />
            <asp:Panel ID="pnlGradesResult" runat="server" Visible="false" CssClass="result">
                <asp:Label ID="lblGradesResult" runat="server" />
            </asp:Panel>
        </div>

        <div class="section">
            <h3>Input Sanitizer</h3>
            <p class="info">
                Strips HTML tags and trims whitespace. Try: <strong>&lt;script&gt;alert('hi')&lt;/script&gt; hello</strong>
            </p>
            <label for="txtSanitize">Raw Input</label>
            <asp:TextBox ID="txtSanitize" runat="server" placeholder="Enter text with HTML tags" />
            <asp:Button ID="btnSanitize" runat="server" Text="Sanitize"
                CssClass="btn" OnClick="btnSanitize_Click" />
            <asp:Panel ID="pnlSanitizeResult" runat="server" Visible="false" CssClass="result pass">
                <asp:Label ID="lblSanitizeResult" runat="server" />
            </asp:Panel>
        </div>

    </div>
</form>
</body>
</html>
