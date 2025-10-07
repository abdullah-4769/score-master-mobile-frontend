import 'dart:async';
import 'package:get/get.dart';
import 'package:scorer/api/api_controllers/question_for_sessions_controller.dart';
import 'package:scorer/api/api_controllers/player_q_submit_controller.dart';
import 'package:scorer/api/api_models/question_for_session_model.dart';
import 'package:scorer/shared_preferences/shared_preferences.dart';

import '../api/api_controllers/team_view_controller.dart';

class GameSelectController extends GetxController {
  var currentPhase = 0.obs;
  var currentQuestionIndex = 0.obs;
  var timeProgress = 0.0.obs;
  var remainingTime = "00:00".obs;
  var isPhaseActive = true.obs;
  var isCompleted = false.obs;
  var submittedQuestions = <int>{}.obs;

  // Store responses for all questions
  var questionResponses = <int, dynamic>{}.obs;
  var puzzleSequences = <int, List<int>>{}.obs;

  final QuestionForSessionsController questionController;
  final PlayerQSubmitController submitController = Get.find<PlayerQSubmitController>();

  int _totalTimeInSeconds = 0;
  int _elapsedTimeInSeconds = 0;
  Timer? _timer;
  bool _autoSubmitted = false;

  GameSelectController({required this.questionController});

  @override
  void onInit() {
    super.onInit();
    _initializeController();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _initializeController() {
    ever(questionController.questionData, (data) {
      if (data != null) {
        print("✅ Questions loaded in GameSelectController: ${data.phases.length} phases");
        data.phases.asMap().forEach((index, phase) {
          print("Phase ${index + 1}: ${phase.name} - ${phase.questions.length} questions");
          phase.questions.asMap().forEach((qIndex, question) {
            print("  Q${qIndex + 1}: ${question.questionText} (${question.type})");
          });
        });
        _resetCurrentPhaseState();
        startTimer();
        _showPhaseStartMessage();
      }
    });
  }

  void _resetCurrentPhaseState() {
    currentQuestionIndex.value = 0;
    submittedQuestions.clear();
    _autoSubmitted = false;
    isPhaseActive.value = true;
  }

  void startTimer() {
    final phase = getCurrentPhase();
    if (phase != null) {
      _totalTimeInSeconds = phase.timeDuration;
      _elapsedTimeInSeconds = 0;
      timeProgress.value = 0.0;
      isPhaseActive.value = true;
      updateRemainingTime();

      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_elapsedTimeInSeconds < _totalTimeInSeconds && isPhaseActive.value) {
          _elapsedTimeInSeconds++;
          timeProgress.value = _elapsedTimeInSeconds / _totalTimeInSeconds;
          updateRemainingTime();
        } else if (_elapsedTimeInSeconds >= _totalTimeInSeconds && !_autoSubmitted) {
          _autoSubmitted = true;
          timer.cancel();
          isPhaseActive.value = false;
          _autoSubmitPhaseQuestions();
        }
      });
    }
  }

  void _stopTimer() {
    _timer?.cancel();
    isPhaseActive.value = false;
  }

  void updateRemainingTime() {
    int remainingSeconds = _totalTimeInSeconds - _elapsedTimeInSeconds;
    if (remainingSeconds < 0) remainingSeconds = 0;
    int minutes = remainingSeconds ~/ 60;
    int seconds = remainingSeconds % 60;
    remainingTime.value = "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  // Phase Management
  Phase? getCurrentPhase() {
    return questionController.questionData.value?.phases[currentPhase.value];
  }

  List<Question> getCurrentPhaseQuestions() {
    final phase = getCurrentPhase();
    if (phase == null) return [];

    // Sort questions by order
    return List<Question>.from(phase.questions)
      ..sort((a, b) => a.order.compareTo(b.order));
  }

  Question? getCurrentQuestion() {
    final questions = getCurrentPhaseQuestions();
    if (currentQuestionIndex.value < questions.length) {
      return questions[currentQuestionIndex.value];
    }
    return null;
  }

  bool isLastPhase() {
    final totalPhases = questionController.questionData.value?.phases.length ?? 0;
    return currentPhase.value >= totalPhases - 1;
  }

  bool isCurrentPhaseComplete() {
    final questions = getCurrentPhaseQuestions();
    return submittedQuestions.length == questions.length;
  }

  bool canSubmitQuestion() {
    // Don't allow submission if phase is complete
    if (isCurrentPhaseComplete()) return false;

    final currentQuestion = getCurrentQuestion();
    if (currentQuestion == null) return false;

    // For MCQ and Puzzle, check if there's a response
    if (currentQuestion.type.toUpperCase() == 'MCQ') {
      return questionResponses.containsKey(currentQuestion.id);
    } else if (currentQuestion.type.toUpperCase() == 'PUZZLE') {
      final sequence = puzzleSequences[currentQuestion.id];
      return sequence != null && sequence.isNotEmpty;
    }

    // For OpenEnded and Simulation, always allow submission (even empty)
    return true;
  }

  // Question Response Management
  void selectMcqOption(int questionId, int optionIndex) {
    if (!isPhaseActive.value) return;
    questionResponses[questionId] = optionIndex;
    print("✅ Selected MCQ option $optionIndex for question $questionId");
  }

  int? getSelectedMcqOption(int questionId) {
    return questionResponses[questionId] as int?;
  }

  void toggleSequenceSelection(int questionId, int optionIndex) {
    if (!isPhaseActive.value) return;

    if (!puzzleSequences.containsKey(questionId)) {
      puzzleSequences[questionId] = [];
    }

    final sequence = puzzleSequences[questionId]!;
    if (sequence.contains(optionIndex)) {
      sequence.remove(optionIndex);
    } else {
      sequence.add(optionIndex);
    }
    puzzleSequences.refresh();
    questionResponses[questionId] = List<int>.from(sequence);
    print("✅ Updated puzzle sequence for question $questionId: $sequence");
  }

  List<int> getPuzzleSequence(int questionId) {
    return puzzleSequences[questionId] ?? [];
  }

  void clearPuzzleSequence(int questionId) {
    puzzleSequences[questionId] = [];
    questionResponses.remove(questionId);
    puzzleSequences.refresh();
  }

  void saveTextResponse(int questionId, String text) {
    if (!isPhaseActive.value) return;
    questionResponses[questionId] = text;
  }

  String? getTextResponse(int questionId) {
    return questionResponses[questionId] as String?;
  }

  // Question Submission
  Future<void> submitCurrentQuestion() async {
    final currentQuestion = getCurrentQuestion();
    if (currentQuestion == null) return;

    print("🔄 Submitting question: ${currentQuestion.id} - ${currentQuestion.type}");

    try {
      final playerId = await SharedPrefServices.getUserId() ?? 0;
      final sessionId = questionController.questionData.value?.sessionId ?? 1;
      final phase = getCurrentPhase();
      final phaseId = phase?.id ?? 0;

      // Get facilitator ID
      final teamController = Get.find<TeamViewController>();
      final facilitatorId = teamController.teamView.value?.gameFormat.facilitators.isNotEmpty == true
          ? teamController.teamView.value!.gameFormat.facilitators[0].id
          : 1;

      // Prepare answer data based on question type
      Map<String, dynamic> answerData = {};
      final response = questionResponses[currentQuestion.id];

      switch (currentQuestion.type.toUpperCase()) {
        case 'MCQ':
          answerData = {"selectedOption": response ?? -1};
          break;
        case 'PUZZLE':
          answerData = {"sequence": response ?? []};
          break;
        case 'OPENENDED':
        case 'OPEN_ENDED':
        case 'SIMULATION':
          answerData = {"textResponse": response ?? ""};
          break;
        default:
          answerData = {"response": response ?? ""};
      }

      print("📤 Submitting answer data: $answerData");

      // Submit answer
      await submitController.submitPlayerAnswer(
        playerId: playerId,
        facilitatorId: facilitatorId,
        sessionId: sessionId,
        phaseId: phaseId,
        questionId: currentQuestion.id,
        answerData: answerData,
      );

      if (submitController.successMessage.isNotEmpty) {
        // Mark question as submitted
        submittedQuestions.add(currentQuestion.id);

        // Check if this was the last question
        final isLastQuestion = currentQuestionIndex.value == getCurrentPhaseQuestions().length - 1;

        if (isLastQuestion) {
          // Last question submitted - stop timer and show completion message
          _stopTimer();
          Get.snackbar(
            'Phase ${currentPhase.value + 1} Complete! 🎉',
            'All questions submitted! Move to next phase when ready.',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 4),
          );
        } else {
          // Move to next question
          _moveToNextQuestion();
          final nextQuestion = getCurrentQuestion();
          Get.snackbar(
            'Question Submitted ✅',
            'Get ready for next ${nextQuestion?.type.toUpperCase() ?? 'question'}',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
          );
        }
      } else {
        Get.snackbar(
          'Submission Failed',
          submitController.errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      print("❌ Error submitting question: $e");
      Get.snackbar(
        'Submission Error',
        'Failed to submit question. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void _moveToNextQuestion() {
    final questions = getCurrentPhaseQuestions();

    if (currentQuestionIndex.value < questions.length - 1) {
      // Move to next question in current phase
      currentQuestionIndex.value++;
      print("➡️ Moving to next question: ${currentQuestionIndex.value + 1}/${questions.length}");
    } else {
      // All questions in phase completed
      print("✅ Phase ${currentPhase.value + 1} completed!");
    }
  }

  void _autoSubmitPhaseQuestions() async {
    final phase = getCurrentPhase();
    if (phase == null) return;

    print("⏰ Time up! Auto-submitting unanswered questions...");

    Get.snackbar(
      'Time\'s Up! ⏰',
      'Phase ${currentPhase.value + 1} time completed. Auto-submitting answers...',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );

    // Submit all unanswered questions
    for (final question in getCurrentPhaseQuestions()) {
      if (!submittedQuestions.contains(question.id)) {
        final playerId = await SharedPrefServices.getUserId() ?? 0;
        final sessionId = questionController.questionData.value?.sessionId ?? 1;

        final teamController = Get.find<TeamViewController>();
        final facilitatorId = teamController.teamView.value?.gameFormat.facilitators.isNotEmpty == true
            ? teamController.teamView.value!.gameFormat.facilitators[0].id
            : 1;

        Map<String, dynamic> answerData = {};
        final response = questionResponses[question.id];

        switch (question.type.toUpperCase()) {
          case 'MCQ':
            answerData = {"selectedOption": response ?? -1};
            break;
          case 'PUZZLE':
            answerData = {"sequence": response ?? []};
            break;
          case 'OPENENDED':
          case 'OPEN_ENDED':
          case 'SIMULATION':
            answerData = {"textResponse": response ?? ""};
            break;
          default:
            answerData = {"response": response ?? ""};
        }

        await submitController.submitPlayerAnswer(
          playerId: playerId,
          facilitatorId: facilitatorId,
          sessionId: sessionId,
          phaseId: phase.id,
          questionId: question.id,
          answerData: answerData,
        );

        submittedQuestions.add(question.id);
        print("✅ Auto-submitted question ${question.id}");
      }
    }

    Get.snackbar(
      'Phase ${currentPhase.value + 1} Completed!',
      'All answers auto-submitted. You can proceed to next phase.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 4),
    );
  }

  void moveToNextPhase() {
    final totalPhases = questionController.questionData.value?.phases.length ?? 0;
    if (currentPhase.value < totalPhases - 1) {
      Get.snackbar(
        'Moving to Next Phase 🚀',
        'Phase ${currentPhase.value + 1} completed! Starting Phase ${currentPhase.value + 2}...',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );

      currentPhase.value++;
      _resetCurrentPhaseState();
      startTimer();
      _showPhaseStartMessage();

    } else {
      isCompleted.value = true;
      Get.snackbar(
        'Session Completed! 🎉',
        'Congratulations! All phases completed successfully!',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    }
  }

  // Get challenge types for current phase
  List<String> getCurrentChallengeTypes() {
    final phase = getCurrentPhase();
    if (phase == null) return [];

    // Extract unique question types from current phase
    final types = phase.questions.map((q) => q.type.toUpperCase()).toSet().toList();
    print("🎯 Current phase challenge types: $types");
    return types;
  }

  // Get questions by challenge type
  List<Question> getQuestionsByChallengeType(String challengeType) {
    final phase = getCurrentPhase();
    if (phase == null) return [];

    return phase.questions
        .where((q) => q.type.toUpperCase() == challengeType.toUpperCase())
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));
  }

  // New method for phase start message
  void _showPhaseStartMessage() {
    final currentPhaseNum = currentPhase.value + 1;
    final phase = getCurrentPhase();

    if (phase != null) {
      Get.snackbar(
        'Phase $currentPhaseNum Started',
        '${phase.name} - ${phase.questions.length} questions • ${(phase.timeDuration ~/ 60)} min',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
      );
    }
  }
}