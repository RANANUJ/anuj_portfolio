/**
 * Firebase Cloud Function to handle contact form submissions
 * 
 * TO DEPLOY THIS:
 * 1. Go to Firebase Console: https://console.firebase.google.com
 * 2. Create a "functions" folder in your Firebase project
 * 3. Copy this code into functions/index.js
 * 4. Run: firebase deploy --only functions
 * 
 * SETUP REQUIRED:
 * - Gmail credentials (setup in Firebase admin)
 * - nodemailer package installed
 */

const functions = require("firebase-functions");
const nodemailer = require("nodemailer");
const cors = require("cors")({ origin: true });

// Configure your Gmail (use App Password for security)
// Instructions: https://support.google.com/accounts/answer/185833
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "YOUR_GMAIL@gmail.com",  // ← UPDATE THIS
    pass: "YOUR_APP_PASSWORD",      // ← UPDATE THIS (NOT regular password!)
  },
});

// Cloud Function to send contact form emails
exports.sendContactEmail = functions.https.onRequest((request, response) => {
  cors(request, response, () => {
    if (request.method !== "POST") {
      return response.status(400).send("Please send a POST request");
    }

    const { senderName, senderEmail, message, timestamp } = request.body;

    // Validate input
    if (!senderName || !senderEmail || !message) {
      return response.status(400).send("Missing required fields");
    }

    // Email content for you
    const mailOptions = {
      from: "YOUR_GMAIL@gmail.com",
      to: "anujrana14052005@gmail.com",
      subject: `New Portfolio Submission from ${senderName}`,
      html: `
        <h2>New Contact Form Submission</h2>
        <p><strong>From:</strong> ${senderName}</p>
        <p><strong>Email:</strong> ${senderEmail}</p>
        <p><strong>Submitted:</strong> ${timestamp}</p>
        <hr>
        <p><strong>Message:</strong></p>
        <p>${message.replace(/\n/g, "<br>")}</p>
        <hr>
        <p><em>This submission was sent from your portfolio app contact form.</em></p>
      `,
    };

    // Send email
    transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
        console.log("Email error:", error);
        return response.status(500).send({
          success: false,
          error: error.toString(),
        });
      }

      console.log("Email sent:", info.response);
      return response.status(200).send({
        success: true,
        message: "Email sent successfully",
        messageId: info.messageId,
      });
    });
  });
});
