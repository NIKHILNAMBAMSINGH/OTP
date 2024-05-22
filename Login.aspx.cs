using System;
using System.Web.UI; 


public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Set initial visibility of controls
            UpdateControlVisibility(false, false, false);
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        // Logic to register user and send OTP.
        SendOtp();

        // Show OTP input field, Submit OTP button, and associated label
        UpdateControlVisibility(true, true, true);

        // Start the timer to allow resend after 10 seconds
        ScriptManager.RegisterStartupScript(this, GetType(), "startTimer", "startTimer();", true);
    }

    protected void btnSubmitOtp_Click(object sender, EventArgs e)
    {
        // Logic to verify OTP.
    }

    protected void btnResend_Click(object sender, EventArgs e)
    {
        string mobileNumber = txtUsername.Text;

        // Check if the resend attempt count is less than 3
        if (GetResendAttemptCount(mobileNumber) < 2) // Changed from 3 to 2 for a total of 3 attempts
        {
            // Logic to resend OTP.
            SendOtp();
            IncrementResendAttemptCount(mobileNumber);

            // Reset timer
            ScriptManager.RegisterStartupScript(this, GetType(), "startTimer", "startTimer();", true);
        }
        else
        {
            // Display message or handle maximum resend attempts reached
            lblMessage.Text = "Maximum resend attempts reached for this mobile number.";
            // Hide all relevant controls
            UpdateControlVisibility(false, false, false);
        }
    }

    private void UpdateControlVisibility(bool otpVisible, bool submitVisible, bool labelVisible)
    {
        txtOtp.Visible = otpVisible;
        btnSubmitOtp.Visible = submitVisible;
        lblSubmitOtp.Visible = labelVisible;
    }

    private int GetResendAttemptCount(string mobileNumber)
    {
        // Check if the session variable exists, initialize with 0 if not
        if (Session[mobileNumber] == null)
        {
            Session[mobileNumber] = 1;
        }
        // Return the resend attempt count stored in the session
        return (int)Session[mobileNumber];
    }

    private void IncrementResendAttemptCount(string mobileNumber)
    {
        // Increment the resend attempt count stored in the session
        Session[mobileNumber] = GetResendAttemptCount(mobileNumber) + 1;
    }

    private void SendOtp()
    {
        // Logic to generate and send OTP.
        // Example: Send OTP to the mobile number in txtUsername.Text
    }
}