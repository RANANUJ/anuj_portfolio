import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/analytics_service.dart';
import '../../services/notification_service.dart';
import '../../widgets/gradient_background.dart';
import '../../widgets/section_card.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            const SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('📧 Email: anujrana14052005@gmail.com'),
                  SizedBox(height: 6),
                  Text('📱 Phone: +91-6230278253'),
                  SizedBox(height: 6),
                  Text(
                    '📍 Location: Vill Tayal, Dist Kangra, Himachal Pradesh',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Social Links',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.start,
                      children: <Widget>[
                        FilledButton.icon(
                          onPressed: () async {
                            final Uri uri = Uri.parse(
                              'https://www.linkedin.com/in/anujrana12',
                            );
                            await launchUrl(uri);
                          },
                          icon: const Text('💼'),
                          label: const Text('LinkedIn'),
                        ),
                        FilledButton.icon(
                          onPressed: () async {
                            final Uri uri = Uri.parse(
                              'https://github.com/RANANUJ',
                            );
                            await launchUrl(uri);
                          },
                          icon: const Text('🐙'),
                          label: const Text('GitHub'),
                        ),
                        FilledButton.icon(
                          onPressed: () async {
                            final Uri uri = Uri.parse('https://anujrana.dev');
                            await launchUrl(uri);
                          },
                          icon: const Text('🌐'),
                          label: const Text('Portfolio'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SectionCard(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (String? value) {
                        if (value == null || !value.contains('@')) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _messageController,
                      minLines: 4,
                      maxLines: 5,
                      decoration: const InputDecoration(labelText: 'Message'),
                      validator: (String? value) {
                        if (value == null || value.trim().length < 8) {
                          return 'Message should be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FilledButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Show loading indicator
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Sending your message...'),
                                duration: Duration(seconds: 2),
                              ),
                            );

                            // Send email notification
                            final sent = await NotificationService.sendContactFormSubmission(
                              name: _nameController.text,
                              email: _emailController.text,
                              message: _messageController.text,
                            );

                            // Track analytics
                            AnalyticsService.trackContactRequest();

                            if (mounted) {
                              if (sent) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      '✅ Message sent! Check your email for confirmation',
                                    ),
                                    duration: Duration(seconds: 4),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      '✅ Submitted successfully! Thank you for your message.',
                                    ),
                                    duration: Duration(seconds: 4),
                                  ),
                                );
                              }
                            }

                            _nameController.clear();
                            _emailController.clear();
                            _messageController.clear();
                          }
                        },
                        child: const Text('Send'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
