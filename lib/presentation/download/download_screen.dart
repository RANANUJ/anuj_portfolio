import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/gradient_background.dart';
import '../../widgets/section_card.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Link copied to clipboard!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // GitHub Release download link
    const String downloadUrl = 'https://github.com/RANANUJ/anuj_portfolio/releases/download/v0.1.0/app-release.apk';
    const String appVersion = '0.1.0';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Download App'),
      ),
      body: GradientBackground(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // App Info Card
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.download_outlined,
                    size: 64,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Anuj Portfolio',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Version $appVersion',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'APK • 49.7 MB',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Download Button
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Download Options',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: downloadUrl == 'YOUR_DOWNLOAD_LINK_HERE'
                        ? () => _showConfigDialog(context)
                        : () => _launchURL(downloadUrl),
                    icon: const Icon(Icons.download),
                    label: const Text('Download APK'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  if (downloadUrl != 'YOUR_DOWNLOAD_LINK_HERE')
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            _copyToClipboard(context, downloadUrl),
                        icon: const Icon(Icons.copy),
                        label: const Text('Copy Link'),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Installation Instructions
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Installation Guide',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildInstruction(context, 1, 'Download', 'Click the download button above'),
                  const SizedBox(height: 12),
                  _buildInstruction(
                    context,
                    2,
                    'Enable Installation',
                    'Go to Settings > Security > Unknown Sources and enable it',
                  ),
                  const SizedBox(height: 12),
                  _buildInstruction(
                    context,
                    3,
                    'Install',
                    'Open the downloaded APK file and tap Install',
                  ),
                  const SizedBox(height: 12),
                  _buildInstruction(
                    context,
                    4,
                    'Launch',
                    'Open the app from your app drawer',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // System Requirements
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'System Requirements',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildRequirement(context, 'Android Version', '5.0 and above'),
                  const SizedBox(height: 12),
                  _buildRequirement(context, 'Storage', 'At least 100 MB free space'),
                  const SizedBox(height: 12),
                  _buildRequirement(
                    context,
                    'Permissions',
                    'Camera, Storage, Internet',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Support
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.help_outline, size: 48),
                  const SizedBox(height: 12),
                  Text(
                    'Need Help?',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'If you encounter any issues, please contact support',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInstruction(
    BuildContext context,
    int step,
    String title,
    String description,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
          child: Center(
            child: Text(
              '$step',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRequirement(
    BuildContext context,
    String requirement,
    String value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          requirement,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }

  void _showConfigDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Setup Required'),
        content: const Text(
          'You need to:\n\n'
          '1. Upload your APK to a hosting service\n'
          '2. Update the download URL in download_screen.dart\n\n'
          'See DOWNLOAD_SETUP.md for detailed instructions.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
