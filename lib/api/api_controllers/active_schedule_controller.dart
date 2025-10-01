import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scorer/api/api_urls.dart';
import 'dart:convert';

import '../api_models/schedule_and_active_session_model.dart';

class ActiveAndSessionController extends GetxController {
  // Observables for reactive state management
  final isLoading = false.obs;
  final scheduleAndActiveSession = ScheduleAndActiveSessionModel().obs;
  final selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    print("[ActiveAndSessionController] onInit called ✅");
    fetchScheduleAndActiveSessions();
  }

  Future<void> fetchScheduleAndActiveSessions() async {
    print("[fetchScheduleAndActiveSessions] Started fetching sessions...");
    try {
      isLoading.value = true;
      print("[fetchScheduleAndActiveSessions] Loading state set to true");

      final url = ApiEndpoints.scheduleAndActiveSession;
      print("[fetchScheduleAndActiveSessions] API URL -> $url");

      final response = await http.get(Uri.parse(url));
      print("[fetchScheduleAndActiveSessions] Response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print("[fetchScheduleAndActiveSessions] API Response Body: $jsonData");

        scheduleAndActiveSession.value = ScheduleAndActiveSessionModel.fromJson(jsonData);
        print("[fetchScheduleAndActiveSessions] Parsed Model: ${scheduleAndActiveSession.value}");
      } else {
        print("[fetchScheduleAndActiveSessions] Error: Status Code -> ${response.statusCode}");
        Get.snackbar(
          'Error',
          'Failed to fetch sessions: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("[fetchScheduleAndActiveSessions] Exception occurred: $e");
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
      print("[fetchScheduleAndActiveSessions] Loading state set to false ✅");
    }
  }

  void changeTabIndex(int index) {
    print("[changeTabIndex] Changing index from ${selectedIndex.value} → $index");
    selectedIndex.value = index;
  }
}
