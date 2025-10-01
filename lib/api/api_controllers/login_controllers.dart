import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants/routename.dart';
import '../../shared_preferences/shared_preferences.dart';
import '../api_models/login_response.dart';
import '../api_urls.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var token = ''.obs;
  var user = Rxn<User>();

  /// Login function
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(ApiEndpoints.login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = LoginResponse.fromJson(jsonDecode(response.body));

        // Update observables
        token.value = result.token;
        user.value = result.user;

        // Save in SharedPreferences
        await SharedPrefServices.setAuthToken(result.token);
        await SharedPrefServices.saveUserProfile(result.user.toJson());
        await SharedPrefServices.saveUserId(result.user.id);
        await SharedPrefServices.setUserName(result.user.name);
        await SharedPrefServices.setUserRole(result.user.role);

        // Normalize role (case-insensitive)
        final role = result.user.role.toLowerCase();

        // Role-based routing
        final roleRoutes = {
          "admin": RouteName.bottomNavigation,
          "facilitator": RouteName.facilitatorDashboard,
          "player": RouteName.playerDashboard,
        };

        if (roleRoutes.containsKey(role)) {
          Get.offAllNamed(roleRoutes[role]!);
        } else {
          Get.snackbar(
            "Error",
            "Unknown role: ${result.user.role}",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Login Failed",
          "Server responded: ${response.statusCode}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Login Failed",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
