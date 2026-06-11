import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationService {
  // Google Apps Script URL (auto-saves to Google Sheet)
  // UPDATE THIS with your Google Apps Script URL from Step 3
  static const String googleSheetUrl =
      'https://script.google.com/macros/s/AKfycbyWKCwUGSFxYMSF8m-6A8PDX9OeozHttF9H6_8XULR-I-ugY_lCN3ZuM0zqrbkBK663/exec';

  // Send contact submission to Google Sheet
  static Future<bool> sendContactFormSubmission({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      debugPrint('📤 Sending to Google Sheets: $googleSheetUrl');
      final response = await http.post(
        Uri.parse(googleSheetUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'message': message,
        }),
      ).timeout(const Duration(seconds: 30));

      debugPrint('📥 Response Status: ${response.statusCode}');
      debugPrint('📥 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        debugPrint('✅ Submission saved to Google Sheet');
        return true;
      } else {
        debugPrint('❌ Failed with status: ${response.statusCode}');
        debugPrint('Response: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('❌ Error: $e');
      return false;
    }
  }

  // Send notifications (saves to Google Sheet)
  static Future<bool> sendNotifications({
    required String name,
    required String email,
    required String message,
  }) async {
    return sendContactFormSubmission(
      name: name,
      email: email,
      message: message,
    );
  }
}
