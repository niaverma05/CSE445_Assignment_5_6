<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TryItStudyHelper.aspx.cs" Inherits="StudentHelperApp.TryItStudyHelper" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>TryIt - Study Helper Service</title>
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
            margin-right: 8px;
            margin-top: 8px;
            background: #4a6fa5;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        .btn:hover { background: #3a5f95; }
        .btn-sample { background: #27ae60; }
        .btn-sample:hover { background: #1e8449; }
        .result {
            margin-top: 16px;
            padding: 14px;
            background: #f0f4f8;
            border: 1px solid #d0d8e0;
            border-radius: 5px;
            white-space: pre-wrap;
        }
        .info { color: #555; font-size: 0.95em; }
        .section {
            border: 1px solid #e0e0e0;
            padding: 16px;
            margin-top: 16px;
            border-radius: 6px;
            background: #fafbfc;
        }
        a.back { display: inline-block; margin-bottom: 16px; color: #4a6fa5; }
        .status-ok { color: #155724; font-weight: bold; }
        .status-err { color: #721c24; font-weight: bold; }
        table.plan {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        table.plan th, table.plan td {
            border: 1px solid #bbb;
            padding: 8px;
        }
        table.plan th { background: #e8ecf1; text-align: left; }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="panel">
        <a class="back" href="Default.aspx">&larr; Back to Default</a>

        <h1>Study Helper Service TryIt</h1>
        <p class="info">
            This page tests the Study Helper WCF service. The service generates
            study time recommendations based on your courses, credit hours, and
            available weekly study time.
        </p>

        <div class="section">
            <h3>Quick Study Recommendation</h3>
            <p class="info">
                Enter total credit hours to get a general study time recommendation.
            </p>
            <label for="txtQuickCredits">Total Credit Hours</label>
            <asp:TextBox ID="txtQuickCredits" runat="server" placeholder="e.g., 15" />
            <asp:Button ID="btnQuickRec" runat="server" Text="Get Recommendation"
                CssClass="btn" OnClick="btnQuickRec_Click" />
            <div class="result">
                <asp:Label ID="lblQuickResult" runat="server" Text="Enter credit hours and click the button." />
            </div>
        </div>

        <div class="section">
            <h3>Generate Full Study Plan</h3>
            <p class="info">
                Enter your courses, their credit hours, and how many hours/week you can study.
                The service will allocate time proportionally across courses.
            </p>

            <label for="txtCourses">Courses (comma-separated)</label>
            <asp:TextBox ID="txtCourses" runat="server" placeholder="e.g., CSE445, DAT301, CSE463" />

            <label for="txtCredits">Credits per course (comma-separated)</label>
            <asp:TextBox ID="txtCredits" runat="server" placeholder="e.g., 3, 3, 3" />

            <label for="txtAvailableHours">Available Study Hours/Week</label>
            <asp:TextBox ID="txtAvailableHours" runat="server" placeholder="e.g., 20" />

            <div>
                <asp:Button ID="btnLoadSample" runat="server" Text="Load Sample"
                    CssClass="btn btn-sample" OnClick="btnLoadSample_Click" />
                <asp:Button ID="btnGeneratePlan" runat="server" Text="Generate Study Plan"
                    CssClass="btn" OnClick="btnGeneratePlan_Click" />
            </div>

            <asp:Panel ID="pnlPlanResult" runat="server" Visible="false">
                <div class="result">
                    <asp:Literal ID="litPlanTable" runat="server" />
                    <br />
                    <asp:Label ID="lblPlanSummary" runat="server" />
                </div>
            </asp:Panel>

            <asp:Label ID="lblPlanError" runat="server" CssClass="status-err" />
        </div>

    </div>
</form>
</body>
</html>
