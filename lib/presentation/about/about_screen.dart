import 'package:flutter/material.dart';

import '../../widgets/gradient_background.dart';
import '../../widgets/section_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            Text(
              'Who Am I?',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const SectionCard(
              child: Text(
                'Flutter developer skilled in building responsive mobile applications using Flutter, Firebase, REST APIs, and modern state management techniques. Familiar with React.js and Node.js, with experience developing cross-platform applications focused on clean UI, performance optimization, scalability, and user-friendly experiences.',
              ),
            ),
            const SizedBox(height: 16),
            const SectionCard(
              child: Text(
                'My journey started with learning mobile development and gradually expanded to full-stack development. I enjoy solving real-world problems through technology and continuously improving my development skills by working on impactful projects.',
              ),
            ),
            const SizedBox(height: 16),
            const SectionCard(
              child: Text(
                'Currently pursuing Bachelor of Computer Science at DAV University (2022-2026). Seeking opportunities as a Flutter Developer where I can contribute to impactful products while growing as a software engineer.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
