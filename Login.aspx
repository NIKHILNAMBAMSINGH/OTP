<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .login-container {
            width: 300px;
            margin: 70px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.2);
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: calc(100% - 22px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn-login, .btn-resend {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            border: none;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-resend {
            background-color: #28a745;
        }
        #timer {
            text-align: center;
            margin-top: 20px;
        }
    </style>
    <script>
        var duration = 10000;
        function startTimer() {
            countdown = 10;
            document.getElementById('<%= lblTimer.ClientID %>').innerText = `Resend OTP in ${countdown} seconds`;
            document.getElementById('<%= btnResend.ClientID %>').style.display = 'none';
            timer = setInterval(updateTimer, 1000);
        }

        function updateTimer() {
            countdown--;
            document.getElementById('<%= lblTimer.ClientID %>').innerText = `Resend OTP in ${countdown} seconds`;
            if (countdown <= 0) {
                clearInterval(timer);
                document.getElementById('<%= lblTimer.ClientID %>').innerText = '';
                document.getElementById('<%= btnResend.ClientID %>').style.display = 'block';
            }
        }
        setTimeout(function() {
            document.getElementById('<%= btnSubmitOtp.ClientID %>').style.display = 'none';
            document.getElementById('<%= btnResend.ClientID %>').style.display = 'inline'; // Show Resend button
        }, duration);

       
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    
    <div class="login-container">
        <h2 style="text-align:center;">Registration</h2>
        <div class="form-group">
            <label for="username">Mobile Number:</label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" />
        </div>
        <asp:Button ID="btnLogin" runat="server" Text="Register" OnClick="btnLogin_Click" CssClass="btn-login" Font-Size="Large" />
        <div class="form-group">
            <label ID="lblSubmitOtp" runat="server">Otp</label>
            <asp:TextBox ID="txtOtp" runat="server" CssClass="form-control" />
        </div>
        <asp:Button ID="btnSubmitOtp" runat="server" Text="Submit OTP" OnClick="btnSubmitOtp_Click" CssClass="btn-login" Font-Size="Large" />
        <asp:Label ID="lblTimer" runat="server" CssClass="form-control" />
        <asp:Button ID="btnResend" runat="server" Text="Resend OTP" OnClick="btnResend_Click" CssClass="btn-resend" Font-Size="Large" Style="display:none;" />
        <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
    </div>
</asp:Content>