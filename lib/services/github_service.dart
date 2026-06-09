import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GithubStats {
  const GithubStats({
    required this.repositories,
    required this.stars,
    required this.followers,
    required this.contributions,
  });

  final int repositories;
  final int stars;
  final int followers;
  final int contributions;
}

class GithubService {
  static const String _username = 'RANANUJ';
  static const String _baseUrl = 'https://api.github.com';

  static Future<GithubStats> fetchStats() async {
    try {
      final Uri userUrl = Uri.parse('$_baseUrl/users/$_username');
      final http.Response userResponse = await http
          .get(userUrl)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () =>
                http.Response('{"public_repos": 0, "followers": 0}', 408),
          );

      if (userResponse.statusCode != 200) {
        debugPrint('GitHub API error: ${userResponse.statusCode}');
        return const GithubStats(
          repositories: 12,
          stars: 28,
          followers: 34,
          contributions: 287,
        );
      }

      final Map<String, dynamic> userData =
          jsonDecode(userResponse.body) as Map<String, dynamic>;
      final int repos = userData['public_repos'] as int? ?? 0;
      final int followers = userData['followers'] as int? ?? 0;

      final Uri reposUrl = Uri.parse(
        '$_baseUrl/users/$_username/repos?sort=stars&per_page=100',
      );
      final http.Response reposResponse = await http
          .get(reposUrl)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => http.Response('[]', 408),
          );

      int totalStars = 0;
      if (reposResponse.statusCode == 200) {
        final List<dynamic> reposData =
            jsonDecode(reposResponse.body) as List<dynamic>;
        totalStars = reposData.fold<int>(0, (int sum, dynamic repo) {
          return sum +
              ((repo as Map<String, dynamic>)['stargazers_count'] as int? ?? 0);
        });
      }

      return GithubStats(
        repositories: repos,
        stars: totalStars,
        followers: followers,
        contributions: 287,
      );
    } catch (e) {
      debugPrint('GitHub API fetch failed: $e');
      return const GithubStats(
        repositories: 12,
        stars: 28,
        followers: 34,
        contributions: 287,
      );
    }
  }
}
