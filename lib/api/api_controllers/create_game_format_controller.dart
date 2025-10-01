import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../api_models/AiChallenge_session.dart';
import '../api_models/additional_setting_model.dart';
import '../api_models/create_game_format_model.dart';
import '../api_urls.dart';

class CreateGameFormatController extends GetxController {
  // Form controllers
  final sessionNameController = TextEditingController();
  final durationController = TextEditingController();

  // Observable variables
  var gameFormatId = Rxn<int>();
  var minPlayers = 5.obs;
  var maxPlayers = 10.obs;
  var badgeNames = <String>[].obs;
  var requireAllTrue = false.obs;
  var aiScoring = true.obs;
  var allowLaterJoin = false.obs;
  var sendInvitation = false.obs;
  var recordSession = false.obs;
  var isLoadingImmediate = false.obs;
  var isLoadingScheduled = false.obs;
  var startedAt = Rxn<DateTime>();
  var userId = 2.obs; // Default userId

  @override
  void onInit() {
    super.onInit();
    // Fetch initial additional settings when controller is initialized
    fetchAdditionalSettings();
  }

  // Validation methods
  String? validateSessionName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Session name is required';
    }
    if (value.length < 3) {
      return 'Session name must be at least 3 characters';
    }
    return null;
  }

  String? validatePlayers(String? value) {
    if (value == null || value.isEmpty) {
      return 'Player count is required';
    }
    final count = int.tryParse(value);
    if (count == null || count < 1) {
      return 'Player count must be a positive number';
    }
    return null;
  }

  String? validateDuration(String? value) {
    if (value == null || value.isEmpty) {
      return 'Duration is required';
    }
    final duration = int.tryParse(value);
    if (duration == null || duration <= 0) {
      return 'Duration must be a positive number';
    }
    return null;
  }

  String? validateStartedAt(DateTime? value) {
    if (value == null) {
      return 'Start time is required';
    }
    if (value.isBefore(DateTime.now())) {
      return 'Start time must be in the future';
    }
    return null;
  }

  // Setters
  void setGameFormatId(int? id) {
    log("Setting gameFormatId = $id", name: 'UnifiedSessionController');
    gameFormatId.value = id;
  }

  void setPlayerRange(int min, int max) {
    log("Setting player range: min=$min, max=$max", name: 'UnifiedSessionController');
    minPlayers.value = min;
    maxPlayers.value = max;
  }

  void addBadgeName(String badge) {
    log("Adding badge: $badge", name: 'UnifiedSessionController');
    if (!badgeNames.contains(badge)) {
      badgeNames.add(badge);
    }
  }

  void removeBadgeName(String badge) {
    log("Removing badge: $badge", name: 'UnifiedSessionController');
    badgeNames.remove(badge);
  }

  void setAiScoring(bool value) {
    log("Setting AI Scoring = $value", name: 'UnifiedSessionController');
    aiScoring.value = value;
  }

  void setAllowLaterJoin(bool value) {
    log("Setting AllowLaterJoin = $value", name: 'UnifiedSessionController');
    allowLaterJoin.value = value;
    saveAdditionalSettings();
  }

  void setSendInvitation(bool value) {
    log("Setting SendInvitation = $value", name: 'UnifiedSessionController');
    sendInvitation.value = value;
    saveAdditionalSettings();
  }

  void setRecordSession(bool value) {
    log("Setting RecordSession = $value", name: 'UnifiedSessionController');
    recordSession.value = value;
    saveAdditionalSettings();
  }

  void setStartedAt(DateTime? dateTime) {
    log("Setting StartedAt = $dateTime", name: 'UnifiedSessionController');
    startedAt.value = dateTime;
  }

  // Fetch additional settings from API
  Future<void> fetchAdditionalSettings() async {
    try {
      log("========== FETCHING ADDITIONAL SETTINGS ==========", name: 'UnifiedSessionController');
      log("Request: GET ${ApiEndpoints.additionalSetting}", name: 'UnifiedSessionController');
      log("Headers: {'Content-Type': 'application/json'}", name: 'UnifiedSessionController');

      final startTime = DateTime.now();
      final response = await http.get(
        Uri.parse(ApiEndpoints.additionalSetting),
        headers: {'Content-Type': 'application/json'},
      );
      final duration = DateTime.now().difference(startTime).inMilliseconds;

      log("Response Status: ${response.statusCode}", name: 'UnifiedSessionController');
      log("Response Body: ${response.body}", name: 'UnifiedSessionController');
      log("Response Time: ${duration}ms", name: 'UnifiedSessionController');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log("Parsed Response Data: $data", name: 'UnifiedSessionController');
        final settings = AdditionalSettingModel.fromJson(data);
        gameFormatId.value = settings.gameFormatId ?? 1;
        minPlayers.value = settings.minPlayers ?? 5;
        maxPlayers.value = settings.maxPlayers ?? 10;
        badgeNames.value = settings.badgeNames ?? ['gold', 'silver'];
        requireAllTrue.value = settings.requireAllTrue ?? false;
        aiScoring.value = settings.aiScoring ?? true;
        allowLaterJoin.value = settings.allowLaterJoin ?? false;
        sendInvitation.value = settings.sendInvitation ?? false;
        recordSession.value = settings.recordSession ?? false;
        log("Updated Settings: gameFormatId=${settings.gameFormatId}, minPlayers=${settings.minPlayers}, "
            "maxPlayers=${settings.maxPlayers}, badgeNames=${settings.badgeNames}, "
            "requireAllTrue=${settings.requireAllTrue}, aiScoring=${settings.aiScoring}, "
            "allowLaterJoin=${settings.allowLaterJoin}, sendInvitation=${settings.sendInvitation}, "
            "recordSession=${settings.recordSession}", name: 'UnifiedSessionController');
        log("✅ Additional settings fetched successfully", name: 'UnifiedSessionController');
      } else {
        log("❌ Failed to fetch additional settings: ${response.statusCode} - ${response.body}",
            name: 'UnifiedSessionController');
        Get.snackbar(
          'Error',
          'Failed to fetch additional settings: ${response.statusCode}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e, stackTrace) {
      log("❌ Error fetching additional settings: $e", name: 'UnifiedSessionController');
      log("Stack Trace: $stackTrace", name: 'UnifiedSessionController');
      Get.snackbar(
        'Error',
        'An error occurred while fetching settings: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Save additional settings to API
  Future<void> saveAdditionalSettings() async {
    try {
      final settings = AdditionalSettingModel(
        gameFormatId: gameFormatId.value,
        minPlayers: minPlayers.value,
        maxPlayers: maxPlayers.value,
        badgeNames: badgeNames.toList(),
        requireAllTrue: requireAllTrue.value,
        aiScoring: aiScoring.value,
        allowLaterJoin: allowLaterJoin.value,
        sendInvitation: sendInvitation.value,
        recordSession: recordSession.value,
      );

      log("========== SAVING ADDITIONAL SETTINGS ==========", name: 'UnifiedSessionController');
      log("Request: POST ${ApiEndpoints.additionalSetting}", name: 'UnifiedSessionController');
      log("Headers: {'Content-Type': 'application/json'}", name: 'UnifiedSessionController');
      log("Request Body: ${jsonEncode(settings.toJson())}", name: 'UnifiedSessionController');

      final startTime = DateTime.now();
      final response = await http.post(
        Uri.parse(ApiEndpoints.additionalSetting),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(settings.toJson()),
      );
      final duration = DateTime.now().difference(startTime).inMilliseconds;

      log("Response Status: ${response.statusCode}", name: 'UnifiedSessionController');
      log("Response Body: ${response.body}", name: 'UnifiedSessionController');
      log("Response Time: ${duration}ms", name: 'UnifiedSessionController');

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("✅ Additional settings saved successfully", name: 'UnifiedSessionController');
        Get.snackbar(
          'Success',
          'Additional settings saved successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        log("❌ Failed to save additional settings: ${response.statusCode} - ${response.body}",
            name: 'UnifiedSessionController');
        Get.snackbar(
          'Error',
          'Failed to save additional settings: ${response.statusCode}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e, stackTrace) {
      log("❌ Error saving additional settings: $e", name: 'UnifiedSessionController');
      log("Stack Trace: $stackTrace", name: 'UnifiedSessionController');
      Get.snackbar(
        'Error',
        'An error occurred while saving settings: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Create CreateGameFormatModel
  CreateGameFormatModel createGameFormatModel() {
    final model = CreateGameFormatModel(
      gameFormatId: gameFormatId.value,
      minPlayers: minPlayers.value,
      maxPlayers: maxPlayers.value,
      badgeNames: badgeNames.toList(),
      requireAllTrue: requireAllTrue.value,
      aiScoring: aiScoring.value,
      allowLaterJoin: allowLaterJoin.value,
      sendInvitation: sendInvitation.value,
      recordSession: recordSession.value,
    );
    log("Created CreateGameFormatModel: ${jsonEncode(model.toJson())}", name: 'UnifiedSessionController');
    return model;
  }

  // Create AiChallengeSession
  AiChallengeSession createAiChallengeSession() {
    final durationMinutes = int.tryParse(durationController.text) ?? 10;
    final session = AiChallengeSession(
      gameFormatId: gameFormatId.value,
      duration: durationMinutes * 60, // Convert minutes to seconds
      userId: userId.value,
      description: sessionNameController.text.isNotEmpty
          ? sessionNameController.text
          : 'AI Challenge Session',
      startedAt: startedAt.value?.toUtc().toIso8601String(),
    );
    log("Created AiChallengeSession: ${jsonEncode(session.toJson())}", name: 'UnifiedSessionController');
    return session;
  }

  // Main method to create or schedule session
  Future<void> createSession({bool scheduleForLater = false}) async {
    log("========== STARTING SESSION ${scheduleForLater ? 'SCHEDULING' : 'CREATION'} ==========",
        name: 'UnifiedSessionController');
    log("scheduleForLater=$scheduleForLater", name: 'UnifiedSessionController');

    // Basic validation
    if (sessionNameController.text.isEmpty || gameFormatId.value == null) {
      log("❌ Basic validation failed: sessionName=${sessionNameController.text}, gameFormatId=${gameFormatId.value}",
          name: 'UnifiedSessionController');
      Get.snackbar(
        'Error',
        'Session name and game format are required',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Additional validation for scheduling
    if (scheduleForLater) {
      if (startedAt.value == null) {
        log("❌ Start time validation failed: startedAt is null", name: 'UnifiedSessionController');
        Get.snackbar(
          'Error',
          'Start time is required for scheduling',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      if (startedAt.value!.isBefore(DateTime.now())) {
        log("❌ Start time validation failed: startedAt=${startedAt.value} is in the past",
            name: 'UnifiedSessionController');
        Get.snackbar(
          'Error',
          'Start time must be in the future',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      if (durationController.text.isEmpty) {
        log("❌ Duration validation failed: duration is empty", name: 'UnifiedSessionController');
        Get.snackbar(
          'Error',
          'Duration is required for scheduling',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
    }

    // Set appropriate loading state
    if (scheduleForLater) {
      isLoadingScheduled.value = true;
    } else {
      isLoadingImmediate.value = true;
    }

    try {
      // Save additional settings before creating/scheduling session
      await saveAdditionalSettings();

      if (scheduleForLater) {
        // Call /sessions/post/method for scheduling
        log("\n========== CALLING AiChallengeSession ENDPOINT ==========", name: 'UnifiedSessionController');
        log("Request: POST ${ApiEndpoints.postSessionMethod}", name: 'UnifiedSessionController');
        log("Headers: {'Content-Type': 'application/json'}", name: 'UnifiedSessionController');
        final aiChallengeModel = createAiChallengeSession();
        log("Request Body: ${jsonEncode(aiChallengeModel.toJson())}", name: 'UnifiedSessionController');

        final startTime = DateTime.now();
        final response = await http.post(
          Uri.parse(ApiEndpoints.postSessionMethod),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(aiChallengeModel.toJson()),
        );
        final duration = DateTime.now().difference(startTime).inMilliseconds;

        log("Response Status: ${response.statusCode}", name: 'UnifiedSessionController');
        log("Response Body: ${response.body}", name: 'UnifiedSessionController');
        log("Response Time: ${duration}ms", name: 'UnifiedSessionController');

        if (response.statusCode != 200 && response.statusCode != 201) {
          log("❌ Failed to schedule session: ${response.statusCode} - ${response.body}",
              name: 'UnifiedSessionController');
          throw Exception('Failed to schedule session: ${response.statusCode} - ${response.body}');
        }

        log("✅ AiChallengeSession - SUCCESS", name: 'UnifiedSessionController');
        Get.snackbar(
          'Success',
          'Session scheduled successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        // Call /admin/player-capability for immediate start
        log("\n========== CALLING CreateGameFormatModel ENDPOINT ==========", name: 'UnifiedSessionController');
        log("Request: POST ${ApiEndpoints.createNewSessionFormat}", name: 'UnifiedSessionController');
        log("Headers: {'Content-Type': 'application/json'}", name: 'UnifiedSessionController');
        final gameFormatModel = createGameFormatModel();
        log("Request Body: ${jsonEncode(gameFormatModel.toJson())}", name: 'UnifiedSessionController');

        final startTime = DateTime.now();
        final response = await http.post(
          Uri.parse(ApiEndpoints.createNewSessionFormat),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(gameFormatModel.toJson()),
        );
        final duration = DateTime.now().difference(startTime).inMilliseconds;

        log("Response Status: ${response.statusCode}", name: 'UnifiedSessionController');
        log("Response Body: ${response.body}", name: 'UnifiedSessionController');
        log("Response Time: ${duration}ms", name: 'UnifiedSessionController');

        if (response.statusCode != 200 && response.statusCode != 201) {
          log("❌ Failed to create session: ${response.statusCode} - ${response.body}",
              name: 'UnifiedSessionController');
          throw Exception('Failed to create session: ${response.statusCode} - ${response.body}');
        }

        log("✅ CreateGameFormatModel - SUCCESS", name: 'UnifiedSessionController');
        Get.snackbar(
          'Success',
          'Session created successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }

      // Clear form
      clearForm();

      // Navigate back
      Get.back();

    } catch (e, stackTrace) {
      log("❌ ERROR: $e", name: 'UnifiedSessionController');
      log("Stack Trace: $stackTrace", name: 'UnifiedSessionController');
      Get.snackbar(
        'Error',
        'Failed to ${scheduleForLater ? 'schedule' : 'create'} session: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 5),
      );
    } finally {
      if (scheduleForLater) {
        isLoadingScheduled.value = false;
      } else {
        isLoadingImmediate.value = false;
      }
      log("========== SESSION ${scheduleForLater ? 'SCHEDULING' : 'CREATION'} FINISHED ==========\n",
          name: 'UnifiedSessionController');
    }
  }

  // Clear form data
  void clearForm() {
    log("Clearing form data...", name: 'UnifiedSessionController');
    sessionNameController.clear();
    durationController.clear();
    gameFormatId.value = null;
    badgeNames.clear();
    minPlayers.value = 5;
    maxPlayers.value = 10;
    startedAt.value = null;
  }

  @override
  void onClose() {
    log("Disposing UnifiedSessionController", name: 'UnifiedSessionController');
    sessionNameController.dispose();
    durationController.dispose();
    super.onClose();
  }
}