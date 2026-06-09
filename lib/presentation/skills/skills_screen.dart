import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../data/models/skill_model.dart';
import '../../data/repositories/portfolio_repository.dart';
import '../../widgets/gradient_background.dart';
import '../../widgets/section_card.dart';
import '../../widgets/tag_chip.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: PortfolioRepository.skillCategories.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (BuildContext context, int index) {
            final SkillCategory category =
                PortfolioRepository.skillCategories[index];
            return SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    category.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: category.skills.map((SkillItem skill) {
                      if (skill.progress > 0) {
                        return _ProgressBubble(skill: skill);
                      }
                      return TagChip(label: skill.name);
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ProgressBubble extends StatelessWidget {
  const _ProgressBubble({required this.skill});

  final SkillItem skill;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
      ),
      child: CircularPercentIndicator(
        radius: 38,
        lineWidth: 6,
        animation: true,
        percent: skill.progress / 100,
        center: Text('${skill.progress}%'),
        progressColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(
          context,
        ).colorScheme.primary.withValues(alpha: 0.20),
        footer: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(skill.name),
        ),
      ),
    );
  }
}
