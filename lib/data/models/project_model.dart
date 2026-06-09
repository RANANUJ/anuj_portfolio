class ProjectModel {
  const ProjectModel({
    required this.title,
    required this.subtitle,
    required this.techStack,
    required this.features,
    required this.problem,
    required this.solution,
    required this.architecture,
    this.githubUrl = '',
    this.imageUrl = '',
  });

  final String title;
  final String subtitle;
  final List<String> techStack;
  final List<String> features;
  final String problem;
  final String solution;
  final List<String> architecture;
  final String githubUrl;
  final String imageUrl;
}
