import 'package:flutter/material.dart';

import '../../data/repositories/portfolio_repository.dart';
import '../../widgets/section_card.dart';

class CertificationsScreen extends StatelessWidget {
  const CertificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Certifications')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: PortfolioRepository.certifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (BuildContext context, int index) {
          final cert = PortfolioRepository.certifications[index];
          return SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(cert.title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text('Organization: ${cert.organization}'),
                const SizedBox(height: 4),
                Text(cert.date),
              ],
            ),
          );
        },
      ),
    );
  }
}
