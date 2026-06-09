import 'package:flutter/material.dart';

import '../../data/repositories/portfolio_repository.dart';
import '../../widgets/section_card.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Education')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: PortfolioRepository.education.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (BuildContext context, int index) {
          final item = PortfolioRepository.education[index];
          return SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(item.title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(item.institute),
                const SizedBox(height: 4),
                Text(item.periodOrScore),
              ],
            ),
          );
        },
      ),
    );
  }
}
