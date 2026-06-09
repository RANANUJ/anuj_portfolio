class SkillItem {
  const SkillItem({required this.name, this.progress = 0});

  final String name;
  final int progress;
}

class SkillCategory {
  const SkillCategory({required this.title, required this.skills});

  final String title;
  final List<SkillItem> skills;
}
