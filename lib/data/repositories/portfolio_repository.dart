import '../models/certification_model.dart';
import '../models/education_model.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';

class PortfolioRepository {
  static const List<String> previewSkills = <String>[
    'Flutter',
    'Firebase',
    'BLoC',
    'REST API',
    'SQLite',
    'MongoDB',
  ];

  static const List<SkillCategory> skillCategories = <SkillCategory>[
    SkillCategory(
      title: 'Mobile Development',
      skills: <SkillItem>[
        SkillItem(name: 'Flutter', progress: 90),
        SkillItem(name: 'Dart', progress: 85),
      ],
    ),
    SkillCategory(
      title: 'Frontend',
      skills: <SkillItem>[
        SkillItem(name: 'HTML'),
        SkillItem(name: 'CSS'),
        SkillItem(name: 'JavaScript'),
        SkillItem(name: 'React.js'),
      ],
    ),
    SkillCategory(
      title: 'Backend',
      skills: <SkillItem>[
        SkillItem(name: 'Node.js'),
        SkillItem(name: 'REST APIs'),
      ],
    ),
    SkillCategory(
      title: 'Database',
      skills: <SkillItem>[
        SkillItem(name: 'Firebase'),
        SkillItem(name: 'Firestore'),
        SkillItem(name: 'SQLite'),
        SkillItem(name: 'MongoDB'),
      ],
    ),
    SkillCategory(
      title: 'State Management',
      skills: <SkillItem>[
        SkillItem(name: 'BLoC'),
        SkillItem(name: 'Provider'),
      ],
    ),
    SkillCategory(
      title: 'Tools',
      skills: <SkillItem>[
        SkillItem(name: 'Git'),
        SkillItem(name: 'GitHub'),
        SkillItem(name: 'VS Code'),
        SkillItem(name: 'Android Studio'),
        SkillItem(name: 'Figma'),
      ],
    ),
  ];

  static const List<ProjectModel> projects = <ProjectModel>[
    ProjectModel(
      title: 'Connect & Contribute',
      subtitle: 'NGO Engagement Platform',
      techStack: <String>['Flutter', 'Firebase', 'BLoC'],
      features: <String>[
        'Dashboard: Comprehensive overview of campaigns, donations, volunteers, and activities',
        'Campaign Management: Create, edit, and manage fundraising campaigns with goals and timelines',
        'Volunteer Management: View, approve, and coordinate with registered volunteers',
        'Donation Tracking: Monitor incoming donations and generate reports',
        'SOS Alerts: Send emergency alerts to volunteers for urgent needs',
        'Quick Tasks: Create and assign quick tasks to volunteers',
        'Reports & Analytics: Generate detailed reports with charts and insights',
      ],
      problem:
          'NGOs struggle with volunteer engagement, campaign coordination, donation management, and lack centralized platforms for community building.',
      solution:
          'Designed and developed a comprehensive Flutter-based mobile application bridging the gap between Non-Governmental Organizations (NGOs) and volunteers. The platform facilitates seamless collaboration, donation management, campaign coordination, and community building to maximize social impact.',
      architecture: <String>[
        'Flutter',
        'BLoC',
        'Firebase',
        'Firestore',
        'Cloud Storage',
      ],
      githubUrl: 'https://github.com/RANANUJ/ngo_app',
    ),
    ProjectModel(
      title: 'Wellnezz Wave',
      subtitle: 'Fitness & Meditation App',
      techStack: <String>['Flutter', 'Dart', 'SQLite'],
      features: <String>[
        'Discover fitness programs and meditation sessions',
        'Track daily workouts with detailed logging',
        'Guided meditation sessions for stress relief',
        'Personal progress tracking and statistics',
        'Responsive and intuitive user interface',
        'Offline functionality with local storage',
      ],
      problem:
          'Users need one consistent app for fitness tracking, workout planning, and meditation routines without switching between multiple applications.',
      solution:
          'Developed a cross-platform application using Flutter and SQLite with optimized performance, enabling users to manage fitness and wellness in one integrated experience.',
      architecture: <String>['Flutter', 'SQLite', 'Dart', 'Provider'],
      githubUrl: 'https://github.com/RANANUJ/wellnezz-wave',
    ),
  ];

  static const List<CertificationModel> certifications = <CertificationModel>[
    CertificationModel(
      title: 'Flutter App Development Certificate',
      organization: '07 Services',
      date: 'Jun 2024 - Jul 2024',
    ),
    CertificationModel(
      title: 'Graphics Designing using Figma and Photoshop',
      organization: 'Coder Roots',
      date: 'Jun 2025 - Aug 2025',
    ),
  ];

  static const List<EducationModel> education = <EducationModel>[
    EducationModel(
      title: 'Bachelor of Computer Science',
      institute: 'DAV University, Jalandhar',
      periodOrScore: '2022 - 2026',
    ),
    EducationModel(
      title: 'Senior Secondary Education',
      institute: 'HP Board',
      periodOrScore: '2021 - 2022 | 80%',
    ),
    EducationModel(
      title: 'Secondary Education',
      institute: 'HP Board',
      periodOrScore: '2019 - 2020 | 85.7%',
    ),
  ];

  static const List<String> achievements = <String>[
    'Designed and developed Flutter-based NGO engagement platform',
    'Developed cross-platform Fitness & Meditation app with performance optimization',
    'Completed Flutter App Development certification from 07 Services',
    'Expertise in Firebase, BLoC, REST APIs, and responsive design',
  ];
}
