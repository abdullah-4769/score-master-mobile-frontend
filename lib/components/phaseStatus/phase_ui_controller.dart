import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../api/api_urls.dart';
import 'phase_ui_model.dart';

class PhaseController extends GetxController {
  var phases = <PhaseUIModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchPhases(int sessionId, int gameFormatId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final url = ApiEndpoints.questionsForSession(sessionId, gameFormatId);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List<PhaseUIModel> fetched = (data['phases'] as List)
            .map((json) => PhaseUIModel.fromJson(json))
            .toList();

        phases.value = fetched;

        if (phases.isNotEmpty) {
          phases[0].status = PhaseStatus.active;
        }
      } else {
        errorMessage.value = "Error: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = "Failed to load phases: $e";
    } finally {
      isLoading.value = false;
    }
  }

  void markPhaseCompleted(int phaseId) {
    int index = phases.indexWhere((p) => p.id == phaseId);
    if (index != -1) {
      phases[index].status = PhaseStatus.completed;

      if (index + 1 < phases.length) {
        phases[index + 1].status = PhaseStatus.active;
      }
      update();
    }
  }
}
