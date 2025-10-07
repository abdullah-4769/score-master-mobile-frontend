import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_models/user_model.dart';
import '../api_urls.dart'; // ✅ Added import

class UserService {
  static Future<List<UserModel>> fetchUsers() async {
    final url = ApiEndpoints.users; // ✅ Using ApiEndpoints
    print("📡 Fetching users from: $url");

    final response = await http.get(Uri.parse(url));
    print("📥 Response status: ${response.statusCode}");
    print("📦 Response body: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print("✅ Parsed ${data.length} users");
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception("❌ Failed to load users: ${response.statusCode}");
    }
  }
}
