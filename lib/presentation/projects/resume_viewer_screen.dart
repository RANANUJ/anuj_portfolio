import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResumeViewerScreen extends StatefulWidget {
  const ResumeViewerScreen({super.key});

  @override
  State<ResumeViewerScreen> createState() => _ResumeViewerScreenState();
}

class _ResumeViewerScreenState extends State<ResumeViewerScreen> {
  // Google Drive PDF - View and Download URLs
  static const String fileId = '1D0FldxAridCTcEU5ZG4_2fWHINOm1MZV';
  static const String resumeViewUrl =
      'https://drive.google.com/file/d/$fileId/view?usp=sharing';
  static const String resumeDownloadUrl =
      'https://drive.google.com/uc?export=download&id=$fileId';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume'),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_browser),
            tooltip: 'Open in Browser',
            onPressed: _openResume,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.description, size: 80, color: Colors.grey),
            const SizedBox(height: 24),
            Text(
              'My Resume',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Click below to view or download my resume',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: _openResume,
              icon: const Icon(Icons.visibility),
              label: const Text('View Resume'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _downloadResume,
              icon: const Icon(Icons.download),
              label: const Text('Download PDF'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openResume() async {
    try {
      final Uri uri = Uri.parse(resumeViewUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open resume')),
          );
        }
      }
    } catch (e) {
      debugPrint('Error opening resume: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _downloadResume() async {
    try {
      final Uri uri = Uri.parse(resumeDownloadUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not download resume')),
          );
        }
      }
    } catch (e) {
      debugPrint('Error downloading resume: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
}
