import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../widgets/gradient_background.dart';
import '../../widgets/glassmorphism_card.dart';
import '../../widgets/custom_animations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _index = 0;

  static const Color primaryColor = Color(0xFF6366F1);

  static const List<({
    String title,
    String subtitle,
    IconData icon,
  })> _pages = <({
    String title,
    String subtitle,
    IconData icon,
  })>[
    (
      title: 'Build Beautiful\nMobile Experiences',
      subtitle: 'Flutter App Development',
      icon: Icons.phone_android_rounded,
    ),
    (
      title: 'Clean Architecture\nScalable Applications',
      subtitle: 'Code Structure',
      icon: Icons.account_tree_rounded,
    ),
    (
      title: 'Firebase + Flutter\nModern Development',
      subtitle: 'Ship production-ready apps faster',
      icon: Icons.cloud_done_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _index == _pages.length - 1;
    
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: <Widget>[
                // Progress indicator with animation
                FadeInAnimation(
                  duration: const Duration(milliseconds: 600),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(_pages.length, (int i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeInOut,
                          width: _index == i ? 28 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: _index == i
                                ? const LinearGradient(
                                    colors: [
                                      primaryColor,
                                      Color.fromARGB(153, 99, 102, 241),
                                    ],
                                  )
                                : null,
                            color: _index == i
                                ? null
                                : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withValues(alpha: 0.28),
                            boxShadow: _index == i
                                ? [
                                    BoxShadow(
                                      color: primaryColor.withValues(alpha: 0.5),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    ),
                                  ]
                                : [],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 32),
                
                // Main content with PageView
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _pages.length,
                    onPageChanged: (int value) {
                      setState(() {
                        _index = value;
                      });
                    },
                    itemBuilder: (BuildContext context, int i) {
                      final page = _pages[i];
                      
                      return Center(
                        child: FadeInAnimation(
                          duration: const Duration(milliseconds: 800),
                          delay: const Duration(milliseconds: 200),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Animated icon in glassmorphism container
                              ScaleInAnimation(
                                duration: const Duration(milliseconds: 700),
                                curve: Curves.elasticOut,
                                child: AnimatedGradientRotation(
                                  duration: const Duration(seconds: 8),
                                  spin: true,
                                  child: GlassmorphismContainer(
                                    width: 140,
                                    height: 140,
                                    padding: const EdgeInsets.all(20),
                                    borderRadius: 50,
                                    backgroundColor:
                                        primaryColor.withValues(alpha: 0.1),
                                    blurSigma: 12.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color.fromARGB(77, 99, 102, 241),
                                            Color.fromARGB(26, 99, 102, 241),
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF6366F1)
                                                .withValues(alpha: 0.4),
                                            blurRadius: 20,
                                            spreadRadius: 5,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        page.icon,
                                        size: 100,
                                        color: const Color.fromARGB(255, 255, 255, 255),
                                        shadows: [
                                          Shadow(
                                            color: const Color(0xFF6366F1)
                                                .withValues(alpha: 0.6),
                                            blurRadius: 15,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              
                              // Title with fade animation
                              FadeInAnimation(
                                duration: const Duration(milliseconds: 800),
                                delay: const Duration(milliseconds: 300),
                                child: Text(
                                  page.title,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              
                              // Subtitle with fade animation
                              FadeInAnimation(
                                duration: const Duration(milliseconds: 800),
                                delay: const Duration(milliseconds: 400),
                                child: GlassmorphismCard(
                                  backgroundColor:
                                      primaryColor.withValues(alpha: 0.08),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                  borderRadius: 12,
                                  blurSigma: 8.0,
                                  child: Text(
                                    page.subtitle,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: const Color.fromARGB(179, 255, 255, 255),
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
                
                // Navigation buttons
                FadeInAnimation(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 500),
                  child: Row(
                    children: [
                      // Skip button
                      if (!isLast)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(AppRoutes.home);
                            },
                            style: OutlinedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              side: BorderSide(
                                color: Colors.white.withValues(alpha: 0.3),
                                width: 1.5,
                              ),
                            ),
                            child: const Text('Skip'),
                          ),
                        ),
                      if (!isLast) const SizedBox(width: 16),
                      
                      // Next/Get Started button
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [
                                primaryColor,
                                Color.fromARGB(204, 99, 102, 241),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withValues(alpha: 0.5),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: FilledButton(
                            onPressed: () {
                              if (isLast) {
                                Navigator.of(context)
                                    .pushReplacementNamed(AppRoutes.home);
                                return;
                              }
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: Text(
                              isLast ? 'Get Started' : 'Next',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
