<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TryItGpa.aspx.cs" Inherits="StudentHelperApp.TryItGpa" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>GPA TryIt</title>
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            margin: 24px;
            background: #f8f8f8;
        }
        .panel {
            max-width: 1000px;
            background: #fff;
            padding: 24px;
            border: 1px solid #ddd;
            border-radius: 10px;
        }
        input[type="text"] {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            margin-top: 6px;
            margin-bottom: 14px;
        }
        .btns button {
            margin-right: 10px;
            padding: 8px 14px;
        }
        .result {
            margin-top: 16px;
            padding: 12px;
            background: #f3f3f3;
            border: 1px solid #ddd;
            white-space: pre-wrap;
        }
        .small {
            color: #666;
        }
    </style>

    <script type="text/javascript">
        function postJson(url, payload, ok, fail) {
            var xhr = new XMLHttpRequest();
            xhr.open("POST", url, true);
            xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");

            xhr.onreadystatechange = function () {
                if (xhr.readyState !== 4) return;

                if (xhr.status === 200) {
                    try {
                        var data = JSON.parse(xhr.responseText);
                        ok(data);
                    } catch (e) {
                        fail("Could not parse service response: " + e.message);
                    }
                } else {
                    fail("HTTP " + xhr.status + ": " + xhr.responseText);
                }
            };

            xhr.send(JSON.stringify(payload));
        }

        function calculateGpa() {
            var grades = document.getElementById("<%= txtGrades.ClientID %>").value;
            var credits = document.getElementById("<%= txtCredits.ClientID %>").value;

            postJson(
                "GpaService.asmx/CalculateGpa",
                { gradesCsv: grades, creditsCsv: credits },
                function (data) {
                    var gpa = data.d;
                    document.getElementById("<%= lblResult.ClientID %>").innerHTML =
                        "GPA: " + gpa.toFixed(2);

                    postJson(
                        "GpaService.asmx/GetAdvice",
                        { gpa: gpa },
                        function (adviceData) {
                            document.getElementById("<%= lblAdvice.ClientID %>").innerHTML =
                                "Advice: " + adviceData.d;
                        },
                        function (err) {
                            document.getElementById("<%= lblAdvice.ClientID %>").innerHTML =
                                "Advice error: " + err;
                        }
                    );
                },
                function (err) {
                    document.getElementById("<%= lblResult.ClientID %>").innerHTML =
                        "Calculation error: " + err;
                    document.getElementById("<%= lblAdvice.ClientID %>").innerHTML = "";
                }
            );
        }

        function checkService() {
            postJson(
                "GpaService.asmx/HealthCheck",
                {},
                function (data) {
                    document.getElementById("<%= lblStatus.ClientID %>").innerHTML =
                        "Service status: " + data.d;
                },
                function (err) {
                    document.getElementById("<%= lblStatus.ClientID %>").innerHTML =
                        "Service status error: " + err;
                }
            );
        }

        function loadSample() {
            document.getElementById("<%= txtGrades.ClientID %>").value = "A,B+,C";
            document.getElementById("<%= txtCredits.ClientID %>").value = "3,4,2";
        }
    </script>
</head>
<body>
<form id="form1" runat="server">
    <div class="panel">
        <h1>GPA Calculator TryIt</h1>
        <p class="small">
            Enter comma-separated grades and comma-separated credits with matching counts.
            Example: grades = <b>A,B+,C</b> and credits = <b>3,4,2</b>
        </p>

        <label for="txtGrades">Grades</label>
        <asp:TextBox ID="txtGrades" runat="server" />

        <label for="txtCredits">Credits</label>
        <asp:TextBox ID="txtCredits" runat="server" />

        <div class="btns">
            <button type="button" onclick="loadSample()">Load sample</button>
            <button type="button" onclick="calculateGpa()">Calculate GPA</button>
            <button type="button" onclick="checkService()">Check service</button>
        </div>

        <div class="result">
            <asp:Label ID="lblStatus" runat="server" />
            <br /><br />
            <asp:Label ID="lblResult" runat="server" />
            <br /><br />
            <asp:Label ID="lblAdvice" runat="server" />
        </div>
    </div>
</form>
</body>
</html>