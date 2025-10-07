import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scorer/api/api_controllers/session_controller.dart';
import '../../constants/routename.dart';
import '../../shared_preferences/shared_preferences.dart';
import '../api_models/login_response.dart';
import '../api_urls.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var token = ''.obs;
  var user = Rxn<User>();

  /// Login function to authenticate user and save credentials
  Future<void> login(String email, String password) async {
    // === Initialization ===
    try {
      isLoading.value = true;
      print("🔄 [LoginController] Starting login process...");
      print("📤 [LoginController] Sending request to: ${ApiEndpoints.login}");
      print("📧 [LoginController] Email: $email | 🔑 Password: $password");

      // === API Request ===
      final response = await http.post(
        Uri.parse(ApiEndpoints.login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      print("✅ [LoginController] Response received with status: ${response.statusCode}");
      print("📦 [LoginController] Response body: ${response.body}");

      // === Handle Success Response ===
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = LoginResponse.fromJson(jsonDecode(response.body));

        print("🎯 [LoginController] Login successful!");
        print("🔑 [LoginController] Token: ${result.token}");
        print("👤 [LoginController] User: ${result.user.toJson()}");

        // === Update Observables ===
        token.value = result.token;
        user.value = result.user;

        // === Save to SharedPreferences ===
        await SharedPrefServices.setAuthToken(result.token);
        await SharedPrefServices.saveUserProfile(result.user.toJson());
        await SharedPrefServices.saveUserId(result.user.id);
        await SharedPrefServices.setUserName(result.user.name);
        await SharedPrefServices.setUserRole(result.user.role);

        // === Handle Session ID for Facilitators ===
        if (result.sessionId != null) {
          await SharedPrefServices.saveSessionId(result.sessionId!);
          print("💾 [LoginController] Saved sessionId: ${result.sessionId}");

          // Initialize SessionController for facilitators
          try {
            final sessionController = Get.find<SessionController>();
            await sessionController.fetchSession(result.sessionId!);
            print("✅ [LoginController] SessionController initialized for facilitator");
          } catch (e) {
            print("⚠️ [LoginController] SessionController not found, will be initialized later: $e");
          }
        }

        print("💾 [LoginController] Saved user data in SharedPreferences");

        // === Role-based Navigation ===
        final role = result.user.role.toLowerCase();
        print("👥 [LoginController] User role: $role");

        final roleRoutes = {
          "admin": RouteName.bottomNavigation,
          "facilitator": RouteName.facilitatorDashboard,
          "player": RouteName.playerDashboard,
        };

        if (roleRoutes.containsKey(role)) {
          print("➡️ [LoginController] Navigating to ${roleRoutes[role]}");
          Get.offAllNamed(roleRoutes[role]!);
        } else {
          print("⚠️ [LoginController] Unknown role encountered: ${result.user.role}");
          Get.snackbar(
            "Error",
            "Unknown role: ${result.user.role}",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        // === Handle Failed Response ===
        print("❌ [LoginController] Login failed with status: ${response.statusCode}");
        Get.snackbar(
          "Login Failed",
          "Server responded: ${response.statusCode}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e, stack) {
      // === Handle Exceptions ===
      print("🔥 [LoginController] Exception occurred during login: $e");
      print("📚 [LoginController] Stacktrace: $stack");
      Get.snackbar(
        "Login Failed",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      // === Final Cleanup ===
      isLoading.value = false;
      print("✅ [LoginController] Login process finished");
    }
  }
}














// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:scorer/api/api_controllers/session_controller.dart';
// import '../../constants/routename.dart';
// import '../../shared_preferences/shared_preferences.dart';
// import '../api_models/login_response.dart';
// import '../api_urls.dart';
//
// class LoginController extends GetxController {
//   var isLoading = false.obs;
//   var token = ''.obs;
//   var user = Rxn<User>();
//
//   /// Login function
//   Future<void> login(String email, String password) async {
//     try {
//       isLoading.value = true;
//       print("🔄 Starting login process...");
//       print("📤 Sending request to: ${ApiEndpoints.login}");
//       print("📧 Email: $email | 🔑 Password: $password");
//
//       final response = await http.post(
//         Uri.parse(ApiEndpoints.login),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({
//           "email": email,
//           "password": password,
//         }),
//       );
//
//       print("✅ Response received with status: ${response.statusCode}");
//       print("📦 Response body: ${response.body}");
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final result = LoginResponse.fromJson(jsonDecode(response.body));
//
//         print("🎯 Login successful!");
//         print("🔑 Token: ${result.token}");
//         print("👤 User: ${result.user.toJson()}");
//
//         // Update observables
//         token.value = result.token;
//         user.value = result.user;
//
//         // Save in SharedPreferences
//         await SharedPrefServices.setAuthToken(result.token);
//         await SharedPrefServices.saveUserProfile(result.user.toJson());
//         await SharedPrefServices.saveUserId(result.user.id);
//         await SharedPrefServices.setUserName(result.user.name);
//         await SharedPrefServices.setUserRole(result.user.role);
//
//         // NEW: Save sessionId if present (for facilitators)
//         if (result.sessionId != null) {
//           await SharedPrefServices.saveSessionId(result.sessionId!);
//           print("💾 Saved sessionId: ${result.sessionId}");
//
//           // Initialize SessionController for facilitators
//           try {
//             final sessionController = Get.find<SessionController>();
//             await sessionController.fetchSession(result.sessionId!);
//             print("✅ SessionController initialized for facilitator");
//           } catch (e) {
//             print("⚠️ SessionController not found, will be initialized later: $e");
//           }
//         }
//
//         print("💾 Saved user data in SharedPreferences");
//
//         // Normalize role (case-insensitive)
//         final role = result.user.role.toLowerCase();
//         print("👥 User role: $role");
//
//         // Role-based routing
//         final roleRoutes = {
//           "admin": RouteName.bottomNavigation,
//           "facilitator": RouteName.facilitatorDashboard,
//           "player": RouteName.playerDashboard,
//         };
//
//         if (roleRoutes.containsKey(role)) {
//           print("➡️ Navigating to ${roleRoutes[role]}");
//           Get.offAllNamed(roleRoutes[role]!);
//         } else {
//           print("⚠️ Unknown role encountered: ${result.user.role}");
//           Get.snackbar(
//             "Error",
//             "Unknown role: ${result.user.role}",
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//           );
//         }
//       } else {
//         print("❌ Login failed with status: ${response.statusCode}");
//         Get.snackbar(
//           "Login Failed",
//           "Server responded: ${response.statusCode}",
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e, stack) {
//       print("🔥 Exception occurred during login: $e");
//       print("📚 Stacktrace: $stack");
//       Get.snackbar(
//         "Login Failed",
//         e.toString(),
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//       print("✅ Login process finished");
//     }
//   }
// }