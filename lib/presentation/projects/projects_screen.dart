import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/routes/app_routes.dart';
import '../../data/models/project_model.dart';
import '../../data/repositories/portfolio_repository.dart';
import '../../widgets/gradient_background.dart';
import '../../widgets/section_card.dart';
import '../../widgets/tag_chip.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProjectModel> projects = PortfolioRepository.projects;

    return GradientBackground(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            Text('Projects', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 14),
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                enlargeCenterPage: false,
                height: 200,
              ),
              items: projects.map((ProjectModel project) {
                return SectionCard(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.mobile_screen_share,
                        size: 48,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        project.title,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        project.subtitle,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        alignment: WrapAlignment.center,
                        children: project.techStack
                            .take(3)
                            .map(
                              (String tech) => Chip(
                                label: Text(
                                  tech,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ...projects.map((ProjectModel project) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        project.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 6),
                      Text(project.subtitle),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: project.techStack
                            .map((String tech) => TagChip(label: tech))
                            .toList(),
                      ),
                      const SizedBox(height: 10),
                      ...project.features.map(
                        (String feature) => Text('- $feature'),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: <Widget>[
                          FilledButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.projectDetail,
                                arguments: project,
                              );
                            },
                            child: const Text('View Details'),
                          ),
                          if (project.githubUrl.isNotEmpty)
                            OutlinedButton(
                              onPressed: () async {
                                final Uri uri = Uri.parse(project.githubUrl);
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(
                                    uri,
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                              child: const Text('GitHub'),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
