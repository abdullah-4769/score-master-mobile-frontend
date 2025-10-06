import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../../constants/appcolors.dart';
import '../api_models/game_format_phase.dart';
import '../api_urls.dart';

class GameFormatPhaseController extends GetxController {
  var isLoading = false.obs;
  var gameFormatPhaseModel = Rxn<GameFormatPhaseModel>();
  var errorMessage = ''.obs;
  var currentPhaseIndex = 0.obs; // Track current phase index
  var remainingSeconds = 0.obs; // Track remaining seconds for current phase
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    fetchGameFormatPhases();
  }

  // Fetch game format phases from API
  Future<void> fetchGameFormatPhases({int sessionId = 1}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final url = '${ApiEndpoints.gameFormatPhases}';
      print('Fetching from: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer YOUR_TOKEN',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        gameFormatPhaseModel.value = GameFormatPhaseModel.fromJson(jsonData);
        // Validate totalPhases against actual phases
        if (gameFormatPhaseModel.value?.gameFormat?.phases?.length !=
            gameFormatPhaseModel.value?.gameFormat?.totalPhases) {
          print('Warning: totalPhases (${gameFormatPhaseModel.value?.gameFormat?.totalPhases}) does not match actual phases (${gameFormatPhaseModel.value?.gameFormat?.phases?.length})');
        }
        startTimerForCurrentPhase();
        Get.snackbar(
          'Success',
          'Loaded ${gameFormatPhaseModel.value?.gameFormat?.phases?.length ?? 0} phases',
          snackPosition: SnackPosition.TOP,
        );
      } else {
        errorMessage.value = 'Failed to load phases: ${response.statusCode}';
        Get.snackbar(
          'Error',
          'Failed to load game format phases: ${response.statusCode}',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      print('Error fetching phases: $e');
      errorMessage.value = 'Error: $e';
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Start timer for the current phase
  void startTimerForCurrentPhase() {
    final currentPhase = this.currentPhase;
    if (currentPhase != null && currentPhase.timeDuration != null) {
      remainingSeconds.value = currentPhase.timeDuration! * 60; // Convert to seconds
      _timer?.cancel(); // Cancel any existing timer
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (remainingSeconds.value > 0) {
          remainingSeconds.value--;
        } else {
          timer.cancel();
          // Move to next phase if available
          if (currentPhaseIndex.value < totalPhasesCount - 1) {
            currentPhaseIndex.value++;
            startTimerForCurrentPhase();
          } else {
            Get.snackbar(
              'Info',
              'All phases completed',
              snackPosition: SnackPosition.TOP,
            );
          }
        }
      });
    }
  }

  // Get current phase
  Phases? get currentPhase {
    if (gameFormatPhaseModel.value?.gameFormat?.phases != null &&
        gameFormatPhaseModel.value!.gameFormat!.phases!.isNotEmpty) {
      return gameFormatPhaseModel.value!.gameFormat!.phases![currentPhaseIndex.value];
    }
    return null;
  }

  // Get phase status
  String getPhaseStatus(int index) {
    if (index < currentPhaseIndex.value) {
      return "completed".tr;
    } else if (index == currentPhaseIndex.value) {
      return "active".tr;
    } else {
      return "pending".tr;
    }
  }

  // Get phase status color
  Color getPhaseStatusColor(int index) {
    if (index < currentPhaseIndex.value) {
      return AppColors.forwardColor;
    } else if (index == currentPhaseIndex.value) {
      return AppColors.selectLangugaeColor;
    } else {
      return AppColors.watchColor;
    }
  }

  // Get phase status icon
  IconData getPhaseStatusIcon(int index) {
    if (index < currentPhaseIndex.value) {
      return Icons.check;
    } else if (index == currentPhaseIndex.value) {
      return Icons.play_arrow;
    } else {
      return Icons.watch_later;
    }
  }

  // Get all phases
  List<Phases> get allPhases {
    return gameFormatPhaseModel.value?.gameFormat?.phases ?? [];
  }

  // Get total phases count
  int get totalPhasesCount {
    return gameFormatPhaseModel.value?.gameFormat?.phases?.length ?? 0;
  }

  // Get total time duration
  int get totalTimeDuration {
    return gameFormatPhaseModel.value?.gameFormat?.timeDuration ?? 0;
  }

  // Get remaining time as formatted string
  String getRemainingTime(int phaseDuration) {
    final minutes = remainingSeconds.value ~/ 60;
    final seconds = remainingSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Move to next phase
  void nextPhase() {
    if (currentPhaseIndex.value < totalPhasesCount - 1) {
      currentPhaseIndex.value++;
      startTimerForCurrentPhase();
    } else {
      Get.snackbar(
        'Info',
        'No more phases available',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // Move to previous phase
  void previousPhase() {
    if (currentPhaseIndex.value > 0) {
      currentPhaseIndex.value--;
      startTimerForCurrentPhase();
    } else {
      Get.snackbar(
        'Info',
        'Already at the first phase',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // Refresh data
  Future<void> refreshPhases() async {
    await fetchGameFormatPhases();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}