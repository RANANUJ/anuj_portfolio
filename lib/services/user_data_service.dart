import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserDataService {
  static const String _userDataKey = 'user_data';
  static const String _contactSubmissionsKey = 'contact_submissions';

  // Save user profile information
  static Future<void> saveUserProfile({
    required String name,
    required String email,
    required String phone,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = {
      'name': name,
      'email': email,
      'phone': phone,
      'savedAt': DateTime.now().toIso8601String(),
    };
    await prefs.setString(_userDataKey, jsonEncode(userData));
  }

  // Get user profile information
  static Future<Map<String, dynamic>> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataJson = prefs.getString(_userDataKey);
    
    if (userDataJson != null) {
      return jsonDecode(userDataJson);
    }
    return {};
  }

  // Save contact form submissions
  static Future<void> saveContactSubmission({
    required String name,
    required String email,
    required String message,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Get existing submissions
    final submissionsJson = prefs.getString(_contactSubmissionsKey);
    List<dynamic> submissions = [];
    
    if (submissionsJson != null) {
      submissions = jsonDecode(submissionsJson);
    }
    
    // Add new submission
    submissions.add({
      'name': name,
      'email': email,
      'message': message,
      'submittedAt': DateTime.now().toIso8601String(),
    });
    
    // Save back to storage (keep last 50 submissions)
    if (submissions.length > 50) {
      submissions = submissions.sublist(submissions.length - 50);
    }
    
    await prefs.setString(_contactSubmissionsKey, jsonEncode(submissions));
  }

  // Get all contact submissions
  static Future<List<Map<String, dynamic>>> getContactSubmissions() async {
    final prefs = await SharedPreferences.getInstance();
    final submissionsJson = prefs.getString(_contactSubmissionsKey);
    
    if (submissionsJson != null) {
      final submissions = jsonDecode(submissionsJson) as List;
      return submissions.map((item) => Map<String, dynamic>.from(item)).toList();
    }
    return [];
  }

  // Clear all data
  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userDataKey);
    await prefs.remove(_contactSubmissionsKey);
  }

  // Get storage summary
  static Future<Map<String, dynamic>> getStorageSummary() async {
    final prefs = await SharedPreferences.getInstance();
    final userProfile = await getUserProfile();
    final submissions = await getContactSubmissions();
    
    return {
      'userProfile': userProfile,
      'totalSubmissions': submissions.length,
      'submissions': submissions,
      'allKeys': prefs.getKeys().toList(),
    };
  }
}
