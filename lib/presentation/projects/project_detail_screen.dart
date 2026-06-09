import 'package:flutter/material.dart';

import '../../data/models/project_model.dart';
import '../../widgets/section_card.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(project.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Problem', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(project.problem),
                const SizedBox(height: 16),
                Text('Solution', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(project.solution),
                const SizedBox(height: 16),
                Text(
                  'Architecture',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                ...project.architecture.map(
                  (String node) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(node),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
