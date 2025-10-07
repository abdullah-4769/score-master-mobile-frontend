import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_models/team_view_model.dart';
import '../api_urls.dart'; // ✅ Added import

class TeamViewService {
  /// Fetch all teams for a session
  static Future<TeamViewModel?> fetchTeams(int sessionId) async {
    final url = Uri.parse(ApiEndpoints.teamsForSession(sessionId)); // ✅ Using ApiEndpoints

    try {
      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
      });

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return TeamViewModel.fromJson(jsonData);
      } else {
        print("❌ [TeamViewService] Failed to fetch teams: ${response.body}");
        return null;
      }
    } catch (e) {
      print("🔥 [TeamViewService] Exception: $e");
      return null;
    }
  }
}
