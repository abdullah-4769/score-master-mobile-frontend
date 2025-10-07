import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api_models/show_all_game_model.dart';
import '../api_urls.dart'; // ✅ Already imported

class GamesController extends GetxController {
  var games = <GameModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllGames();
  }

  Future<void> fetchAllGames() async {
    if (isLoading.value) return;

    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';

    final url = ApiEndpoints.gameModelS; // ✅ Using ApiEndpoints
    print("🌍 Fetching all games from → $url");

    http.Response? response;

    try {
      response = await http.get(Uri.parse(url));

      print("📥 FetchAllGames Response → ${response.statusCode}");
      print("📥 Body Preview (first 500 chars): ${response.body.substring(0, response.body.length > 500 ? 500 : response.body.length)}...");
      print("📥 Full Body Length: ${response.body.length}");

      if (response.statusCode == 200) {
        final responseBody = response.body.trim();

        if (responseBody.isEmpty || responseBody == '[]') {
          print("📝 No games found");
          games.clear();
          return;
        }

        final List<dynamic> data = jsonDecode(responseBody);
        if (data.isEmpty) {
          print("📝 Empty games array");
          games.clear();
          return;
        }

        print("📊 Raw API Data Count: ${data.length} items");

        final parsedGames = data.map((json) {
          final game = GameModel.fromJson(json);
          print("🟢 Parsed Game → ${game.displayName} | Mode: ${game.mode} | Phases: ${game.totalPhases}");
          return game;
        }).where((game) {
          final keep = !game.isEmpty && game.totalPhases > 0;
          if (!keep) {
            print("🔴 Filtered out game: ${game.displayName}");
          }
          return keep;
        }).toList();

        games.assignAll(parsedGames);
        print("✅ Total Games Loaded: ${games.length}");
      } else if (response.statusCode == 404) {
        print("📝 No games endpoint found (404)");
        games.clear();
        hasError.value = true;
        errorMessage.value = 'Games not found';
      } else {
        print("❌ Failed to fetch games → ${response.statusCode}: ${response.body}");
        hasError.value = true;
        errorMessage.value = 'Failed to load games: ${response.statusCode}';
        Get.snackbar('Error', 'Failed to fetch games: ${response.statusCode}');
      }
    } catch (e) {
      print("❌ Exception in fetchAllGames → $e");
      print("❌ Full Response Body on Error: ${response?.body ?? 'No response'}");
      hasError.value = true;
      errorMessage.value = 'Network error occurred';
      Get.snackbar('Error', 'Error fetching games: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshGames() async {
    print("🔄 Refreshing games list");
    await fetchAllGames();
  }

  List<GameModel> getActiveGames() => games.where((game) => game.isActive).toList();
  List<GameModel> getInactiveGames() => games.where((game) => !game.isActive).toList();
  List<GameModel> getTeamGames() => games.where((game) => game.mode == 'team').toList();
  List<GameModel> getSoloGames() => games.where((game) => game.mode == 'solo').toList();
  List<GameModel> getGamesByScoringType(String scoringType) =>
      games.where((game) => game.scoringType == scoringType).toList();

  int get totalGames => games.length;
  int get activeGamesCount => getActiveGames().length;
  int get inactiveGamesCount => getInactiveGames().length;

  List<GameModel> searchGames(String query) {
    if (query.trim().isEmpty) return games.toList();
    final lowerQuery = query.toLowerCase();
    return games.where((game) {
      return game.name.toLowerCase().contains(lowerQuery) ||
          game.description.toLowerCase().contains(lowerQuery) ||
          game.mode.toLowerCase().contains(lowerQuery) ||
          game.scoringType.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  List<GameModel> getSampleGames({int count = 3}) {
    if (games.isEmpty) return [];
    final shuffled = List<GameModel>.from(games)..shuffle();
    return shuffled.take(count).toList();
  }
}
