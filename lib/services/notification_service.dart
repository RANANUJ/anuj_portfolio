import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationService {
  // Google Apps Script URL (auto-saves to Google Sheet)
  // UPDATE THIS with your Google Apps Script URL from Step 3
  static const String googleSheetUrl =
      'https://script.google.com/macros/s/AKfycbx01J_DGx-MenDQmTxTJwiYb0Oxwqj5yGAUdYNtQSjjvI5hE3WG5UZYd64WEvdwzm-f/exec';

  // Send contact submission to Google Sheet
  static Future<bool> sendContactFormSubmission({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
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
      );

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
