import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../api_models/add_phase_model.dart';

class AddPhaseController extends GetxController {
  // Form Controllers
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final orderController = TextEditingController();
  final timeDurationController = TextEditingController();
  final requiredScoreController = TextEditingController();

  // Observable variables
  var gameFormatId = Rxn<int>();
  var scoringType = Rxn<String>();
  var challengeTypes = <String>[].obs;
  var difficulty = Rxn<String>();
  var badge = Rxn<String>();
  var isLoading = false.obs;

  // Dropdown options
  final scoringTypeOptions = ['Points', 'Time', 'Accuracy', 'Completion'].obs;
  final difficultyOptions = ['Easy', 'Medium', 'Hard', 'Expert'].obs;
  final challengeTypeOptions = [
    'Quiz',
    'Puzzle',
    'Memory',
    'Logic',
    'Speed',
    'Strategy'
  ].obs;

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    // Initialize any default values here if needed
  }

  @override
  void onClose() {
    // Dispose controllers
    nameController.dispose();
    descriptionController.dispose();
    orderController.dispose();
    timeDurationController.dispose();
    requiredScoreController.dispose();
    super.onClose();
  }

  // Methods for handling challenge types
  void addChallengeType(String type) {
    if (!challengeTypes.contains(type)) {
      challengeTypes.add(type);
    }
  }

  void removeChallengeType(String type) {
    challengeTypes.remove(type);
  }

  void toggleChallengeType(String type) {
    if (challengeTypes.contains(type)) {
      challengeTypes.remove(type);
    } else {
      challengeTypes.add(type);
    }
  }

  // Setters for dropdown values
  void setGameFormatId(int? id) => gameFormatId.value = id;
  void setScoringType(String? type) => scoringType.value = type;
  void setDifficulty(String? level) => difficulty.value = level;
  void setBadge(String? badgeType) => badge.value = badgeType;

  // Validation methods
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }
    if (value.length < 10) {
      return 'Description must be at least 10 characters';
    }
    return null;
  }

  String? validateOrder(String? value) {
    if (value == null || value.isEmpty) {
      return 'Order is required';
    }
    final order = int.tryParse(value);
    if (order == null || order < 1) {
      return 'Order must be a positive number';
    }
    return null;
  }

  String? validateTimeDuration(String? value) {
    if (value == null || value.isEmpty) {
      return 'Time duration is required';
    }
    final duration = int.tryParse(value);
    if (duration == null || duration < 1) {
      return 'Time duration must be a positive number';
    }
    return null;
  }

  String? validateRequiredScore(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required score is required';
    }
    final score = int.tryParse(value);
    if (score == null || score < 0) {
      return 'Required score must be a non-negative number';
    }
    return null;
  }

  // Create AddPhaseModel from current form data
  AddPhaseModel createPhaseModel() {
    return AddPhaseModel(
      gameFormatId: gameFormatId.value,
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      order: int.tryParse(orderController.text),
      scoringType: scoringType.value,
      timeDuration: int.tryParse(timeDurationController.text),
      challengeTypes: challengeTypes.toList(),
      difficulty: difficulty.value,
      badge: badge.value,
      requiredScore: int.tryParse(requiredScoreController.text),
    );
  }

  // Populate form with existing phase data
  void populateForm(AddPhaseModel phase) {
    gameFormatId.value = phase.gameFormatId;
    nameController.text = phase.name ?? '';
    descriptionController.text = phase.description ?? '';
    orderController.text = phase.order?.toString() ?? '';
    scoringType.value = phase.scoringType;
    timeDurationController.text = phase.timeDuration?.toString() ?? '';
    challengeTypes.value = phase.challengeTypes ?? [];
    difficulty.value = phase.difficulty;
    badge.value = phase.badge;
    requiredScoreController.text = phase.requiredScore?.toString() ?? '';
  }

  void clearForm() {
    nameController.clear();
    descriptionController.clear();
    orderController.clear();
    timeDurationController.clear();
    requiredScoreController.clear();
    gameFormatId.value = null;
    scoringType.value = null;
    challengeTypes.clear();
    difficulty.value = null;
    badge.value = null;
  }

  // Validate form and submit
  Future<void> submitPhase() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      try {
        // Additional validation for dropdowns
        if (gameFormatId.value == null) {
          Get.snackbar('Error', 'Please select a game format');
          return;
        }

        if (scoringType.value == null) {
          Get.snackbar('Error', 'Please select a scoring type');
          return;
        }

        if (difficulty.value == null) {
          Get.snackbar('Error', 'Please select a difficulty level');
          return;
        }

        if (challengeTypes.isEmpty) {
          Get.snackbar('Error', 'Please select at least one challenge type');
          return;
        }

        final phaseModel = createPhaseModel();

        // Here you would typically call your API service
        // await apiService.addPhase(phaseModel);

        // Simulate API call
        await Future.delayed(Duration(seconds: 2));

        Get.snackbar(
          'Success',
          'Phase added successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Clear form after successful submission
        clearForm();

        // Navigate back or to next screen
        // Get.back();

      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to add phase: ${e.toString()}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  // Method to validate all dropdowns
  bool validateDropdowns() {
    return gameFormatId.value != null &&
        scoringType.value != null &&
        difficulty.value != null &&
        challengeTypes.isNotEmpty;
  }
}