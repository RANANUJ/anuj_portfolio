import 'package:flutter/material.dart';

import '../../widgets/section_card.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Experience')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const <Widget>[
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Flutter Developer'),
                SizedBox(height: 6),
                Text('2024 -> Present'),
                SizedBox(height: 10),
                Text('- Developed Flutter applications.'),
                Text('- Integrated Firebase Authentication.'),
                Text('- Worked with REST APIs.'),
                Text('- Implemented BLoC architecture.'),
                Text('- Optimized application performance.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
