import 'package:flutter/material.dart';

import '../../presentation/home/home_shell.dart';
import '../../presentation/onboarding/onboarding_screen.dart';
import '../../presentation/projects/project_detail_screen.dart';
import '../../presentation/projects/resume_viewer_screen.dart';
import '../../presentation/splash/splash_screen.dart';
import '../../data/models/project_model.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String projectDetail = '/project-detail';
  static const String resumeViewer = '/resume-viewer';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeShell());
      case projectDetail:
        final project = settings.arguments as ProjectModel;
        return MaterialPageRoute(
          builder: (_) => ProjectDetailScreen(project: project),
        );
      case resumeViewer:
        return MaterialPageRoute(builder: (_) => const ResumeViewerScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
