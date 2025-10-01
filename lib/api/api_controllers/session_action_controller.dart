import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:scorer/api/api_urls.dart';


import '../api_models/resume_model.dart';

class SessionActionController extends GetxController {
  final isLoading = false.obs;

  Future<void> startSession(int sessionId) async {
    print("[SessionActionController] Starting session with ID: $sessionId");
    try {
      isLoading.value = true;
      print("[SessionActionController] Loading state set to true for startSession");

      final url = "${ApiEndpoints.startSession}";
     // final url = "${ApiEndpoints.startSession}/$sessionId";
      print("[SessionActionController] Start API URL: $url");

      final response = await http.patch(Uri.parse(url));
      print("[SessionActionController] Start API Response Status: ${response.statusCode}");
      print("[SessionActionController] Start API Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        StartModel startModel = StartModel.fromJson(jsonData);
        print("[SessionActionController] Start Session Success: ${startModel.toJson()}");
        Get.snackbar(
          'Success',
          'Session started successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        print("[SessionActionController] Start Session Failed: Status Code ${response.statusCode}");
        Get.snackbar(
          'Error',
          'Failed to start session: ${response.statusCode}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("[SessionActionController] Start Session Exception: $e");
      Get.snackbar(
        'Error',
        'An error occurred while starting session: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
      print("[SessionActionController] Loading state set to false for startSession");
    }
  }

  Future<void> pauseSession(int sessionId) async {
    print("[SessionActionController] Pausing session with ID: $sessionId");
    try {
      isLoading.value = true;
      print("[SessionActionController] Loading state set to true for pauseSession");

      final url = "${ApiEndpoints.pauseSession}";
      //final url = "${ApiEndpoints.pauseSession}/$sessionId";
      print("[SessionActionController] Pause API URL: $url");

      final response = await http.post(Uri.parse(url));
      print("[SessionActionController] Pause API Response Status: ${response.statusCode}");
      print("[SessionActionController] Pause API Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        PauseModel pauseModel = PauseModel.fromJson(jsonData);
        print("[SessionActionController] Pause Session Success: ${pauseModel.toJson()}");
        Get.snackbar(
          'Success',
          'Session paused successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        print("[SessionActionController] Pause Session Failed: Status Code ${response.statusCode}");
        Get.snackbar(
          'Error',
          'Failed to pause session: ${response.statusCode}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("[SessionActionController] Pause Session Exception: $e");
      Get.snackbar(
        'Error',
        'An error occurred while pausing session: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
      print("[SessionActionController] Loading state set to false for pauseSession");
    }
  }

  Future<void> resumeSession(int sessionId) async {
    print("[SessionActionController] Resuming session with ID: $sessionId");
    try {
      isLoading.value = true;
      print("[SessionActionController] Loading state set to true for resumeSession");

      final url = "${ApiEndpoints.resumeSession}";
      //final url = "${ApiEndpoints.resumeSession}/$sessionId";
      print("[SessionActionController] Resume API URL: $url");

      final response = await http.post(Uri.parse(url));
      print("[SessionActionController] Resume API Response Status: ${response.statusCode}");
      print("[SessionActionController] Resume API Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        ResumeModel resumeModel = ResumeModel.fromJson(jsonData);
        print("[SessionActionController] Resume Session Success: ${resumeModel.toJson()}");
        Get.snackbar(
          'Success',
          'Session resumed successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        print("[SessionActionController] Resume Session Failed: Status Code ${response.statusCode}");
        Get.snackbar(
          'Error',
          'Failed to resume session: ${response.statusCode}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("[SessionActionController] Resume Session Exception: $e");
      Get.snackbar(
        'Error',
        'An error occurred while resuming session: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
      print("[SessionActionController] Loading state set to false for resumeSession");
    }
  }
}