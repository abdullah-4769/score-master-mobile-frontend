import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:scorer/api/api_urls.dart';
import 'package:scorer/shared_preferences/shared_preferences.dart';
import '../api_models/resume_model.dart';
import 'active_schedule_controller.dart';

class SessionActionController extends GetxController {
  // Observable variables for reactive UI
  final isLoading = false.obs;
  final currentSession = Rxn<StartSessionModel>();
  final sessionStatus = ''.obs;
  final elapsedTime = 0.obs;
  final remainingTime = 0.obs;
  final totalDuration = 0.obs;
  final joinCode = ''.obs;
  final joiningLink = ''.obs;
  final gameFormatId = 0.obs;
  final currentPhaseId = 1.obs;
  final phases = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    print("[SessionActionController] 🎮 Controller initialized");
    loadSavedSessionData();
  }

  // Load saved session data from SharedPreferences
  Future<void> loadSavedSessionData() async {
    try {
      final sessionId = await SharedPrefServices.getSessionId();
      final gameId = await SharedPrefServices.getGameId();
      final code = await SharedPrefServices.getAuthToken();
      final userId = await SharedPrefServices.getUserId();

      if (sessionId != null) {
        print("[SessionActionController] 📖 Loaded saved session ID: $sessionId");
      }
      if (gameId != null) {
        gameFormatId.value = gameId;
        print("[SessionActionController] 📖 Loaded saved game ID: $gameId");
      }
      if (code != null) {
        joinCode.value = code;
        print("[SessionActionController] 📖 Loaded saved join code: $code");
      }
      if (userId != null) {
        print("[SessionActionController] 📖 Loaded saved user ID: $userId");
      }
    } catch (e) {
      print("[SessionActionController] ⚠️ Error loading saved data: $e");
      _showErrorSnackbar('Error loading data', e.toString());
    }
  }

  // ==================== START SESSION ====================
  Future<bool> startSession(int sessionId) async {
    if (isSessionActive()) {
      _showErrorSnackbar('Cannot Start', 'The session is already active.');
      return false;
    }

    print("[SessionActionController] 🚀 Starting session with ID: $sessionId");
    try {
      isLoading.value = true;

      await SharedPrefServices.saveSessionId(sessionId);
      print("[SessionActionController] 💾 Session ID saved: $sessionId");

      final url = ApiEndpoints.getStartSessionUrl(sessionId);
      print("[SessionActionController] 📡 API URL: $url");

      final response = await http.patch(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      print("[SessionActionController] 📥 Response Status: ${response.statusCode}");
      print("[SessionActionController] 📥 Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        StartSessionModel startModel = StartSessionModel.fromJson(jsonData);

        _updateSessionState(startModel);

        if (startModel.createdById != null) {
          await SharedPrefServices.saveUserId(startModel.createdById!);
          print("[SessionActionController] 💾 User ID saved: ${startModel.createdById}");
        }

        // Fetch phase data
        await _fetchPhases(sessionId);

        currentPhaseId.value = phases.isNotEmpty ? (phases.first['phaseId'] ?? 1) : 1;

        if (startModel.joinCode != null && startModel.joinCode!.isNotEmpty) {
          await SharedPrefServices.setAuthToken(startModel.joinCode!);
          print("[SessionActionController] 💾 Join code saved: ${startModel.joinCode}");
        }
        if (startModel.gameFormatId != null) {
          await SharedPrefServices.saveGameId(startModel.gameFormatId!);
          print("[SessionActionController] 💾 Game ID saved: ${startModel.gameFormatId}");
        }

        print("[SessionActionController] ✅ Session Started Successfully!");
        Get.snackbar(
          '✅ Success',
          'Session started! Join Code: ${startModel.joinCode ?? "N/A"}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          icon: const Icon(Icons.check_circle, color: Colors.white),
        );

        await _refreshSessionsList();
        return true;
      } else {
        print("[SessionActionController] ❌ Failed with status: ${response.statusCode}");
        _showErrorSnackbar('Failed to start session', 'Status: ${response.statusCode}\n${response.body}');
        return false;
      }
    } catch (e) {
      print("[SessionActionController] ⚠️ Exception occurred: $e");
      _showErrorSnackbar('Error starting session', e.toString());
      return false;
    } finally {
      isLoading.value = false;
      print("[SessionActionController] 🔄 Loading state set to false");
    }
  }

  // ==================== PAUSE SESSION ====================
  Future<bool> pauseSession(int sessionId) async {
    if (!isSessionActive()) {
      _showErrorSnackbar('Cannot Pause', 'The session is not active.');
      return false;
    }

    print("[SessionActionController] ⏸️ Pausing session with ID: $sessionId");
    try {
      isLoading.value = true;

      await SharedPrefServices.saveSessionId(sessionId);
      print("[SessionActionController] 💾 Session ID saved: $sessionId");

      final url = ApiEndpoints.getPauseSessionUrl(sessionId);
      print("[SessionActionController] 📡 API URL: $url");

      final response = await http.patch(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      print("[SessionActionController] 📥 Response Status: ${response.statusCode}");
      print("[SessionActionController] 📥 Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        PauseSessionModel pauseModel = PauseSessionModel.fromJson(jsonData);

        _updateSessionState(pauseModel);

        print("[SessionActionController] ✅ Session Paused Successfully!");
        Get.snackbar(
          '⏸️ Paused',
          'Session paused. Elapsed: ${_formatTime(pauseModel.elapsedTime ?? 0)}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          icon: const Icon(Icons.pause_circle, color: Colors.white),
        );

        await _refreshSessionsList();
        return true;
      } else {
        print("[SessionActionController] ❌ Failed with status: ${response.statusCode}");
        _showErrorSnackbar('Failed to pause session', 'Status: ${response.statusCode}\n${response.body}');
        return false;
      }
    } catch (e) {
      print("[SessionActionController] ⚠️ Exception occurred: $e");
      _showErrorSnackbar('Error pausing session', e.toString());
      return false;
    } finally {
      isLoading.value = false;
      print("[SessionActionController] 🔄 Loading state set to false");
    }
  }

  // ==================== RESUME SESSION ====================
  Future<bool> resumeSession(int sessionId) async {
    if (!isSessionPaused()) {
      _showErrorSnackbar('Cannot Resume', 'The session is not paused.');
      return false;
    }

    print("[SessionActionController] ▶️ Resuming session with ID: $sessionId");
    try {
      isLoading.value = true;

      await SharedPrefServices.saveSessionId(sessionId);
      print("[SessionActionController] 💾 Session ID saved: $sessionId");

      final url = ApiEndpoints.getResumeSessionUrl(sessionId);
      print("[SessionActionController] 📡 API URL: $url");

      final response = await http.patch(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      print("[SessionActionController] 📥 Response Status: ${response.statusCode}");
      print("[SessionActionController] 📥 Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        ResumeSessionModel resumeModel = ResumeSessionModel.fromJson(jsonData);

        _updateSessionState(resumeModel);

        print("[SessionActionController] ✅ Session Resumed Successfully!");
        Get.snackbar(
          '▶️ Resumed',
          'Session resumed from ${_formatTime(resumeModel.elapsedTime ?? 0)}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          icon: const Icon(Icons.play_circle, color: Colors.white),
        );

        await _refreshSessionsList();
        return true;
      } else {
        print("[SessionActionController] ❌ Failed with status: ${response.statusCode}");
        _showErrorSnackbar('Failed to resume session', 'Status: ${response.statusCode}\n${response.body}');
        return false;
      }
    } catch (e) {
      print("[SessionActionController] ⚠️ Exception occurred: $e");
      _showErrorSnackbar('Error resuming session', e.toString());
      return false;
    } finally {
      isLoading.value = false;
      print("[SessionActionController] 🔄 Loading state set to false");
    }
  }

  // ==================== NEXT PHASE ====================
  Future<bool> nextPhase(int sessionId) async {
    if (!isSessionActive()) {
      _showErrorSnackbar('Cannot Advance Phase', 'The session is not active.');
      return false;
    }

    print("[SessionActionController] ⏭️ Advancing to next phase for session ID: $sessionId");
    try {
      isLoading.value = true;

      await SharedPrefServices.saveSessionId(sessionId);
      print("[SessionActionController] 💾 Session ID saved: $sessionId");

      final currentIndex = phases.indexWhere((p) => p['phaseId'] == currentPhaseId.value);
      if (currentIndex == -1 || currentIndex == phases.length - 1) {
        _showErrorSnackbar('No Next Phase', 'No more phases available.');
        return false;
      }

      final nextPhase = phases[currentIndex + 1];
      final url = ApiEndpoints.phaseSession; // Using /phase-session endpoint
      print("[SessionActionController] 📡 API URL: $url");

      final response = await http.patch(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'sessionId': sessionId,
          'phaseId': nextPhase['phaseId'],
        }),
      );

      print("[SessionActionController] 📥 Response Status: ${response.statusCode}");
      print("[SessionActionController] 📥 Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        phases[currentIndex + 1] = jsonData; // Update phase data
        currentPhaseId.value = jsonData['phaseId'] ?? currentPhaseId.value + 1;

        print("[SessionActionController] ✅ Next Phase Started Successfully: Phase ${currentPhaseId.value}");
        Get.snackbar(
          '⏭️ Next Phase',
          'Session advanced to Phase ${currentPhaseId.value}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          icon: const Icon(Icons.fast_forward, color: Colors.white),
        );

        await _refreshSessionsList();
        return true;
      } else {
        print("[SessionActionController] ❌ Failed with status: ${response.statusCode}");
        _showErrorSnackbar('Failed to advance phase', 'Status: ${response.statusCode}\n${response.body}');
        return false;
      }
    } catch (e) {
      print("[SessionActionController] ⚠️ Exception occurred: $e");
      _showErrorSnackbar('Error advancing phase', e.toString());
      return false;
    } finally {
      isLoading.value = false;
      print("[SessionActionController] 🔄 Loading state set to false");
    }
  }

  // ==================== FETCH PHASES ====================
  Future<void> _fetchPhases(int sessionId) async {
    try {
      final url = ApiEndpoints.getPhaseSessionUrl(sessionId);
      print("[SessionActionController] 📡 Fetching phases from: $url");

      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      print("[SessionActionController] 📥 Phases Response Status: ${response.statusCode}");
      print("[SessionActionController] 📥 Phases Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List;
        phases.assignAll(
          jsonData.cast<Map<String, dynamic>>()
            ..sort((a, b) => (a['phaseId'] ?? 0).compareTo(b['phaseId'] ?? 0)),
        );
        print("[SessionActionController] ✅ Phases fetched and sorted: ${phases.map((p) => p['phaseId'])}");
      } else {
        print("[SessionActionController] ❌ Failed to fetch phases: ${response.statusCode}");
        _showErrorSnackbar('Failed to fetch phases', 'Status: ${response.statusCode}');
      }
    } catch (e) {
      print("[SessionActionController] ⚠️ Error fetching phases: $e");
      _showErrorSnackbar('Error fetching phases', e.toString());
    }
  }

  // ==================== HELPER METHODS ====================

  void _updateSessionState(dynamic model) {
    currentSession.value = model is StartSessionModel ? model : currentSession.value;
    sessionStatus.value = model.status ?? 'UNKNOWN';
    elapsedTime.value = model.elapsedTime ?? 0;
    totalDuration.value = model.duration ?? 0;
    remainingTime.value = (model.duration ?? 0) - (model.elapsedTime ?? 0);
    joinCode.value = model.joinCode ?? '';
    joiningLink.value = model.joiningLink ?? '';
    gameFormatId.value = model.gameFormatId ?? 0;
  }

  Future<void> _refreshSessionsList() async {
    try {
      if (Get.isRegistered<ActiveAndSessionController>()) {
        final activeController = Get.find<ActiveAndSessionController>();
        await activeController.fetchScheduleAndActiveSessions();
        print("[SessionActionController] 🔄 Sessions list refreshed successfully");
      } else {
        print("[SessionActionController] ⚠️ ActiveAndSessionController not registered");
      }
    } catch (e) {
      print("[SessionActionController] ⚠️ Error refreshing sessions: $e");
    }
  }

  void _showErrorSnackbar(String title, String message) {
    final shortMessage = message.length > 100 ? '${message.substring(0, 100)}...' : message;
    Get.snackbar(
      '❌ $title',
      shortMessage,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes}m ${remainingSeconds}s';
  }

  bool isSessionActive() {
    return sessionStatus.value.toUpperCase() == 'ACTIVE';
  }

  bool isSessionPaused() {
    return sessionStatus.value.toUpperCase() == 'PAUSED';
  }

  String getFormattedElapsedTime() {
    return _formatTime(elapsedTime.value);
  }

  String getFormattedRemainingTime() {
    return _formatTime(remainingTime.value);
  }

  String getFormattedTotalDuration() {
    return _formatTime(totalDuration.value);
  }

  double getProgressPercentage() {
    if (totalDuration.value == 0) return 0.0;
    return (elapsedTime.value / totalDuration.value).clamp(0.0, 1.0);
  }

  @override
  void onClose() {
    print("[SessionActionController] 👋 Controller disposed");
    super.onClose();
  }
}