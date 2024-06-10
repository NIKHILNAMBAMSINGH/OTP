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

            // Start the timer to allow resend after 60 seconds
            ScriptManager.RegisterStartupScript(this, GetType(), "startTimer", "startTimer();", true);
        }

        protected void btnSubmitOtp_Click(object sender, EventArgs e)
        {
            // Logic to verify OTP.
            string enteredOtp = txtOtp.Text.Trim();
            string generatedOtp = Session["GeneratedOtp"] as string;

            if (enteredOtp == generatedOtp)
            {
                // OTP is correct, proceed with further logic
                lblMessage.Text = "OTP verified successfully!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                // OTP is incorrect
                lblMessage.Text = "Incorrect OTP, please try again.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
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
            string otp = GenerateOtp();
            // Simulate sending OTP
            lblMessage.Text = "Your OTP is: " + otp;

            // Store OTP in session for verification
            Session["GeneratedOtp"] = otp;
        }

        private string GenerateOtp()
        {
            Random random = new Random();
            return random.Next(100000, 999999).ToString();
        }
    }
