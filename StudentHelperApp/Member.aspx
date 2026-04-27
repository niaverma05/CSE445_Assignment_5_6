<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Member.aspx.cs" Inherits="StudentHelperApp.Member" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Member Page</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 24px; background: #f5f6fa; }
        .panel {
            max-width: 600px; margin: 0 auto; background: #fff;
            padding: 24px; border: 1px solid #ddd; border-radius: 10px;
            text-align: center;
        }
        a.back { display: inline-block; margin-bottom: 16px; color: #4a6fa5; }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="panel">
        <a class="back" href="Default.aspx">&larr; Back to Default</a>
        <h1>Member Page</h1>
        <p>This page will require authentication in Assignment 6.</p>
        <p>Self-enrollment, login redirection, and Member.xml integration will be added.</p>
    </div>
</form>
</body>
</html>
