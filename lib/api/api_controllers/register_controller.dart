import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../shared_preferences/shared_preferences.dart';
import '../../constants/routename.dart';
import '../api_models/registration_model.dart';
import '../api_urls.dart';

class RegistrationController extends GetxController {
  var isLoading = false.obs;

  /// Returns true if registration was successful
  Future<bool> register(RegistrationModel user, {bool isAdmin = true}) async {
    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(ApiEndpoints.register),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        if (data['token'] != null) {
          await SharedPrefServices.setAuthToken(data['token']);
        }

        // ✅ Just show snackbar if Admin creates user
        if (isAdmin) {
          Get.snackbar("Success", "User created successfully");
          return true;
        }

        // ✅ If user is self-registering → navigate
        if (user.role.toLowerCase() == 'admin') {
          Get.offAllNamed(RouteName.adminLoginScreen);
        } else if (user.role.toLowerCase() == 'facilitator') {
          Get.offAllNamed(RouteName.facilLoginScreen);
        } else if (user.role.toLowerCase() == 'player') {
          Get.offAllNamed(RouteName.playerLoginScreen);
        }

        return true;
      } else {
        Get.snackbar("Error", "Registration failed: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
