import 'package:flutter/material.dart';

import '../../data/repositories/portfolio_repository.dart';
import '../../services/analytics_service.dart';
import '../../services/github_service.dart';
import '../../widgets/gradient_background.dart';
import '../../widgets/section_card.dart';
import '../../widgets/tag_chip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.onGoToContact,
    required this.onOpenResume,
  });

  final VoidCallback onGoToContact;
  final VoidCallback onOpenResume;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<GithubStats> _statsFuture;

  @override
  void initState() {
    super.initState();
    AnalyticsService.trackProfileVisit();
    _statsFuture = GithubService.fetchStats();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Hello, I\'m',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ANUJ RANA',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Flutter App Developer',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Flutter developer skilled in building responsive mobile applications using Flutter, Firebase, REST APIs, and modern state management techniques. Familiar with React.js and Node.js, with experience developing cross-platform applications focused on clean UI, performance optimization, scalability, and user-friendly experiences.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: <Widget>[
                      FilledButton.icon(
                        onPressed: () {
                          AnalyticsService.trackResumeDownload();
                          widget.onOpenResume();
                        },
                        icon: const Icon(Icons.picture_as_pdf_rounded),
                        label: const Text('Download Resume'),
                      ),
                      OutlinedButton.icon(
                        onPressed: widget.onGoToContact,
                        icon: const Icon(Icons.send_rounded),
                        label: const Text('Contact Me'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const _StatsCard(),
            const SizedBox(height: 16),
            SectionCard(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: PortfolioRepository.previewSkills
                    .map((String s) => TagChip(label: s))
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),
            FutureBuilder<GithubStats>(
              future: _statsFuture,
              builder:
                  (BuildContext context, AsyncSnapshot<GithubStats> snapshot) {
                    if (!snapshot.hasData) {
                      return const SectionCard(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      );
                    }
                    final stats = snapshot.data!;
                    return SectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'GitHub Integration',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: <Widget>[
                              _MetricTile(
                                label: 'Repositories',
                                value: '${stats.repositories}',
                              ),
                              _MetricTile(
                                label: 'Stars',
                                value: '${stats.stars}',
                              ),
                              _MetricTile(
                                label: 'Followers',
                                value: '${stats.followers}',
                              ),
                              _MetricTile(
                                label: 'Contributions',
                                value: '${stats.contributions}',
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard();

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          _MetricTile(label: 'Projects', value: '2+'),
          _MetricTile(label: 'Certifications', value: '2+'),
          _MetricTile(label: 'Technologies', value: '15+'),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 92),
      child: Column(
        children: <Widget>[
          Text(value, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
