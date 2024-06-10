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
    <script type="text/javascript">
        var countdown;
        var timer;

        function startTimer() {
            countdown = 10;
            var countdownLabel = document.getElementById('<%= lblTimer.ClientID %>');
            countdownLabel.innerText = 'Resend OTP in ' + countdown + ' seconds';
            countdownLabel.style.display = 'block';

            timer = setInterval(function () {
                countdown--;
                countdownLabel.innerText = 'Resend OTP in ' + countdown + ' seconds';
                if (countdown <= 0) {
                    clearInterval(timer);
                    countdownLabel.style.display = 'none';
                    document.getElementById('<%= txtOtp.ClientID %>').style.display = 'none';
                    document.getElementById('<%= btnSubmitOtp.ClientID %>').style.display = 'none';
                    document.getElementById('<%= lblSubmitOtp.ClientID %>').style.display = 'none';
                    document.getElementById('<%= btnResend.ClientID %>').style.display = 'block';
                }
            }, 1000);
        }

        function showOtpInput() {
            document.getElementById('<%= lblSubmitOtp.ClientID %>').style.display = 'block';
            document.getElementById('<%= txtOtp.ClientID %>').style.display = 'block';
            document.getElementById('<%= btnSubmitOtp.ClientID %>').style.display = 'block';
            document.getElementById('<%= lblSubmitOtp.ClientID %>').style.display = 'block';
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="login-container">
        <div class="form-group">
            <asp:Label ID="lblUsername" runat="server" Text="Enter Mobile No"></asp:Label>
            <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Button ID="btnLogin" runat="server" Text="Send OTP" OnClick="btnLogin_Click" OnClientClick="showOtpInput(); startTimer(); return true;" CssClass="btn-login"/>
        </div>
        <div class="form-group">
            <asp:Label ID="lblSubmitOtp" runat="server" Text="Enter OTP" Visible="false"></asp:Label>
            <asp:TextBox ID="txtOtp" runat="server" Visible="false"></asp:TextBox>
            <asp:Button ID="btnSubmitOtp" runat="server" Text="Submit OTP" Visible="false" OnClick="btnSubmitOtp_Click" CssClass="btn-login"/>
        </div>
        <div class="form-group">
               <asp:Label ID="lblTimer" runat="server" Text="" ForeColor="Red" Style="display:none;"></asp:Label>
            <br />
        </div>
        <div class="form-group">
            <asp:Button ID="btnResend" runat="server" Text="Resend OTP" OnClick="btnResend_Click" Style="display:none;" CssClass="btn-resend"/>
        </div>
        <div class="form-group">
            <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Red"></asp:Label>
        </div>
    </div>
</asp:Content>