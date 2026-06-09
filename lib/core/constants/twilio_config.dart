// Twilio Configuration
// 🔒 SECURITY WARNING: These credentials should be stored securely
// Consider using a backend API instead of storing in frontend code

class TwilioConfig {
  // Your Twilio Account Credentials
  static const String accountSid = 'USed400c37d144243cd99fc131dffaf6dc';
  static const String authToken = 'AMN6MUEHZV7RL5PVFR4URNCB';
  
  // Your Twilio Phone Number (verified in Twilio Console)
  static const String twilioPhoneNumber = '+916230278253';
  
  // Recipient phone number (your personal number)
  static const String recipientPhoneNumber = '+916230278253';
  
  // Twilio API Endpoint
  static const String twilioApiUrl = 'https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json';
  
  /// Get basic auth header for Twilio API
  static String getBasicAuth() {
    // base64 encode "accountSid:authToken"
    String credentials = '$accountSid:$authToken';
    return credentials;
  }
}
