import 'package:flutter/material.dart';

import '../../data/repositories/portfolio_repository.dart';
import '../../widgets/section_card.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Achievements')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: PortfolioRepository.achievements.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (BuildContext context, int index) {
          return SectionCard(
            child: Text(PortfolioRepository.achievements[index]),
          );
        },
      ),
    );
  }
}
