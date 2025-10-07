import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../api_models/session_detail_model.dart';
import '../api_urls.dart';

class SessionService {
  Future<String?> _getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('auth_token');
    } catch (e) {
      developer.log('Error getting token: $e', name: 'SessionService');
      return null;
    }
  }

  Future<SessionModel?> fetchSessionDetail(int sessionId) async {
    final url = ApiEndpoints.sessionDetail(sessionId);
    developer.log('Fetching session detail from URL: $url', name: 'SessionService');

    try {
      final token = await _getToken();

      if (token == null) {
        developer.log('No auth token found', name: 'SessionService');
        return null;
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      developer.log('API Response Status: ${response.statusCode}', name: 'SessionService');
      developer.log('API Response Body: ${response.body}', name: 'SessionService');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return SessionModel.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        developer.log('Unauthorized - token may be invalid', name: 'SessionService');
        return null;
      } else if (response.statusCode == 404) {
        developer.log('Session not found', name: 'SessionService');
        return null;
      } else {
        developer.log('Failed to load session detail: ${response.statusCode} - ${response.reasonPhrase}', name: 'SessionService');
        return null;
      }
    } catch (e) {
      developer.log('Error fetching session detail: $e', name: 'SessionService');
      return null;
    }
  }
}
