import 'dart:convert'; // for jsonDecode
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scorer/api/api_urls.dart';
import '../api_models/analysis_model.dart';

class EndSessionController extends GetxController {
  // Observable variables
  final isLoading = false.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  // Data observables
  Rx<AnalysisModel?> analysisData = Rx<AnalysisModel?>(null);

  // Getters for easy access
  SessionOverview? get sessionOverview => analysisData.value?.sessionOverview;
  List? get badges => analysisData.value?.badges;
  SessionStats? get sessionStats => analysisData.value?.sessionStats;
  List? get playerRanking => analysisData.value?.playerRanking;
  List? get phasesBreakdown => analysisData.value?.phasesBreakdown;

  @override
  void onInit() {
    super.onInit();
    print("🔄 EndSessionController initialized. Fetching session analysis...");
    fetchSessionAnalysis();
  }

  // Fetch session analysis data - GET API
  Future fetchSessionAnalysis() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      print("📡 Sending GET request to: ${ApiEndpoints.analysis}");

      final response = await http.get(
        Uri.parse(ApiEndpoints.analysis),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization': 'Bearer YOUR_TOKEN', // if needed
        },
      );

      print("📥 Response received [${response.statusCode}]");

      if (response.statusCode == 200) {
        final bodyString = response.body;
        print("✅ Raw Response Body: $bodyString");

        final data = jsonDecode(bodyString);
        print("📝 Decoded JSON: $data");

        analysisData.value = AnalysisModel.fromJson(data);
        print("🎯 Parsed AnalysisModel: ${analysisData.value}");
      } else {
        print("❌ Failed with status: ${response.statusCode}");
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      print('🚨 Error while fetching session analysis: $e');
    } finally {
      isLoading.value = false;
      print("⏹️ fetchSessionAnalysis completed.");
    }
  }

  // Helper method to format time duration
  String formatDuration(int? minutes) {
    if (minutes == null) return '0 min';
    if (minutes < 60) return '$minutes min';

    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return mins > 0 ? '${hours}h ${mins}min' : '${hours}h';
  }

  // Helper method to get rank suffix
  String getRankSuffix(int rank) {
    if (rank == 1) return 'st';
    if (rank == 2) return 'nd';
    if (rank == 3) return 'rd';
    return 'th';
  }

  // Refresh data
  Future refreshData() async {
    print("🔄 Refreshing session analysis...");
    await fetchSessionAnalysis();
  }
}
