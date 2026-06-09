import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> trackProfileVisit() async {
    try {
      await _analytics.logEvent(
        name: 'profile_visit',
        parameters: <String, Object>{
          'timestamp': DateTime.now().toIso8601String(),
          'user_role': 'recruiter',
        },
      );
      debugPrint('Analytics: profile visit tracked');
    } catch (e) {
      debugPrint('Analytics error: $e');
    }
  }

  static Future<void> trackResumeDownload() async {
    try {
      await _analytics.logEvent(
        name: 'resume_download',
        parameters: <String, Object>{
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
      debugPrint('Analytics: resume download tracked');
    } catch (e) {
      debugPrint('Analytics error: $e');
    }
  }

  static Future<void> trackContactRequest() async {
    try {
      await _analytics.logEvent(
        name: 'contact_request',
        parameters: <String, Object>{
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
      debugPrint('Analytics: contact request tracked');
    } catch (e) {
      debugPrint('Analytics error: $e');
    }
  }

  static Future<void> trackProjectView(String projectTitle) async {
    try {
      await _analytics.logEvent(
        name: 'project_view',
        parameters: <String, Object>{
          'project': projectTitle,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
      debugPrint('Analytics: project view tracked - $projectTitle');
    } catch (e) {
      debugPrint('Analytics error: $e');
    }
  }
}
