import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api_models/create_game_model.dart';
import '../api_models/phase_model.dart';
import 'facilitator_controller.dart';
import '../api_urls.dart';

class CreateGameController extends GetxController {
  var name = ''.obs;
  var description = ''.obs;
  var mode = 'team'.obs;
  var totalPhases = 0.obs;
  var timeDuration = 0.obs;
  var createdById = 1.obs;
  var facilitatorIds = <int>[].obs;

  // ✅ Hold phases from API
  var phases = <PhaseModel>[].obs;

  final FacilitatorsController facilitatorsController = Get.find<FacilitatorsController>();

  @override
  void onInit() {
    super.onInit();
    facilitatorIds.assignAll(facilitatorsController.selectedIds);
    ever(facilitatorsController.selectedIds, (_) {
      facilitatorIds.assignAll(facilitatorsController.selectedIds);
    });
  }

  CreateGameModel toCreateGameModel() {
    return CreateGameModel(
      name: name.value,
      description: description.value,
      mode: mode.value,
      totalPhases: totalPhases.value,
      timeDuration: timeDuration.value,
      createdById: createdById.value,
      facilitatorIds: facilitatorIds.toList(),
    );
  }

  Future<void> createGameFormat() async {
    final url = Uri.parse(ApiEndpoints.createGame);
    final createGameModel = toCreateGameModel();
    final body = jsonEncode(createGameModel.toJson());

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        final gameId = responseData['id'];
        print("✅ Game created with ID: $gameId");

        // After creating → fetch phases
        await fetchPhases(gameId);

        Get.snackbar('Success', 'Game created successfully');
      } else {
        Get.snackbar('Error', 'Failed to create game: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  Future<void> fetchPhases(int gameId) async {
    final url = Uri.parse("http://localhost:4000/admin/phases/game/$gameId");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        phases.assignAll(data.map((json) => PhaseModel.fromJson(json)).toList());
        print("✅ Phases fetched: ${phases.length}");
      } else {
        Get.snackbar('Error', 'Failed to fetch phases: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error fetching phases: $e');
    }
  }
}
