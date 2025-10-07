import 'package:get/get.dart';
import 'package:scorer/api/api_models/team_leaderboard_model.dart';
import 'package:scorer/api/api_services/team_leaderboard_service.dart';

class TeamLeaderboardController extends GetxController {
  final TeamLeaderboardService _service = TeamLeaderboardService();

  var top3 = <TeamRank>[].obs;
  var remaining = <TeamRank>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    loadLeaderboard(1); // 👈 Replace 1 with actual sessionId if dynamic
  }

  Future<void> loadLeaderboard(int sessionId) async {
    print("🔹 [TeamLeaderboardController] Loading leaderboard for sessionId: $sessionId");

    try {
      isLoading.value = true;

      final data = await _service.fetchLeaderboard(sessionId);

      if (data != null) {
        print("✅ [TeamLeaderboardController] Leaderboard data fetched successfully.");
        print("   ├─ Top 3 Teams Count: ${data.top3.length}");
        print("   └─ Remaining Teams Count: ${data.remaining.length}");

        top3.assignAll(data.top3);
        remaining.assignAll(data.remaining);
      } else {
        print("⚠️ [TeamLeaderboardController] No data returned from service.");
      }
    } catch (e) {
      print("❌ [TeamLeaderboardController] Error loading leaderboard: $e");
    } finally {
      isLoading.value = false;
      print("🔸 [TeamLeaderboardController] Loading complete.");
    }
  }
}
