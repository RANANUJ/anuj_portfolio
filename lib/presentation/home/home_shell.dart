import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/routes/app_routes.dart';
import '../../main.dart';
import '../about/about_screen.dart';
import '../achievements/achievements_screen.dart';
import '../certifications/certifications_screen.dart';
import '../contact/contact_screen.dart';
import '../education/education_screen.dart';
import '../experience/experience_screen.dart';
import '../home/home_screen.dart';
import '../projects/projects_screen.dart';
import '../settings/settings_screen.dart';
import '../skills/skills_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomeScreen(
        onGoToContact: () => setState(() => _tabIndex = 4),
        onOpenResume: () {
          Navigator.of(context).pushNamed(AppRoutes.resumeViewer);
        },
      ),
      const ProjectsScreen(),
      const SkillsScreen(),
      const AboutScreen(),
      const ContactScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appTitle),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.download_outlined),
            tooltip: 'Download App',
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.download);
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              final routes = <String, Widget>{
                'experience': const ExperienceScreen(),
                'certifications': const CertificationsScreen(),
                'education': const EducationScreen(),
                'achievements': const AchievementsScreen(),
              };
              final widget = routes[value];
              if (widget == null) {
                return;
              }
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => widget));
            },
            itemBuilder: (BuildContext context) =>
                const <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'experience',
                    child: Text('Experience'),
                  ),
                  PopupMenuItem<String>(
                    value: 'certifications',
                    child: Text('Certifications'),
                  ),
                  PopupMenuItem<String>(
                    value: 'education',
                    child: Text('Education'),
                  ),
                  PopupMenuItem<String>(
                    value: 'achievements',
                    child: Text('Achievements'),
                  ),
                ],
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SettingsScreen(
                    currentMode: PortfolioApp.of(context).themeMode,
                    onThemeChange: PortfolioApp.of(context).updateThemeMode,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 280),
        child: pages[_tabIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (int value) {
          setState(() => _tabIndex = value);
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.work_outline_rounded),
            selectedIcon: Icon(Icons.work_rounded),
            label: 'Projects',
          ),
          NavigationDestination(
            icon: Icon(Icons.star_outline_rounded),
            selectedIcon: Icon(Icons.star_rounded),
            label: 'Skills',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'About',
          ),
          NavigationDestination(
            icon: Icon(Icons.call_outlined),
            selectedIcon: Icon(Icons.call),
            label: 'Contact',
          ),
        ],
      ),
    );
  }
}
