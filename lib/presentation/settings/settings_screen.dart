import 'package:flutter/material.dart';

import '../../widgets/section_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.currentMode,
    required this.onThemeChange,
  });

  final ThemeMode currentMode;
  final ValueChanged<ThemeMode> onThemeChange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Theme', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                RadioListTile<ThemeMode>(
                  value: ThemeMode.dark,
                  groupValue: currentMode,
                  onChanged: (ThemeMode? mode) {
                    if (mode != null) {
                      onThemeChange(mode);
                    }
                  },
                  title: const Text('Dark Mode'),
                ),
                RadioListTile<ThemeMode>(
                  value: ThemeMode.light,
                  groupValue: currentMode,
                  onChanged: (ThemeMode? mode) {
                    if (mode != null) {
                      onThemeChange(mode);
                    }
                  },
                  title: const Text('Light Mode'),
                ),
                RadioListTile<ThemeMode>(
                  value: ThemeMode.system,
                  groupValue: currentMode,
                  onChanged: (ThemeMode? mode) {
                    if (mode != null) {
                      onThemeChange(mode);
                    }
                  },
                  title: const Text('System Theme'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Language: English'),
                SizedBox(height: 8),
                Text(
                  'About App: Recruiter-ready portfolio built with Flutter.',
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
