import 'package:get/get.dart';
import 'package:scorer/api/api_models/player_leaderboard_model.dart';
import 'package:scorer/api/api_services/player_leaderboard_service.dart';

class PlayerLeaderboardController extends GetxController {
  final PlayerLeaderboardService _service = PlayerLeaderboardService();

  var top3 = <PlayerRank>[].obs;
  var remaining = <PlayerRank>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    loadLeaderboard(1); // 👈 Replace 1 with actual sessionId if dynamic
  }

  Future<void> loadLeaderboard(int sessionId) async {
    print("🔹 [PlayerLeaderboardController] Loading leaderboard for sessionId: $sessionId");

    try {
      isLoading.value = true;
      final data = await _service.fetchLeaderboard(sessionId);

      if (data != null) {
        print("✅ [PlayerLeaderboardController] Leaderboard data received successfully.");
        print("   ├─ Top 3 Players Count: ${data.top3.length}");
        print("   └─ Remaining Players Count: ${data.remaining.length}");

        top3.assignAll(data.top3);
        remaining.assignAll(data.remaining);
      } else {
        print("⚠️ [PlayerLeaderboardController] No data returned from service.");
      }
    } catch (e) {
      print("❌ [PlayerLeaderboardController] Error loading leaderboard: $e");
    } finally {
      isLoading.value = false;
      print("🔸 [PlayerLeaderboardController] Loading complete.");
    }
  }
}
