import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scorer/api/api_urls.dart';
import 'dart:convert';

import '../api_models/stat_user_managemnt.dart';

class StatsUserManagementController extends GetxController {
var isLoading = true.obs;
var statsUserManagement = StatsUserManagementModel().obs;
var errorMessage = ''.obs;

@override
void onInit() {
print("[StatsUserManagementController] onInit called");
fetchStatsUserManagement();
super.onInit();
}

Future<void> fetchStatsUserManagement() async {
try {
print("[StatsUserManagementController] Fetching stats...");
isLoading(true);

final response = await http.get(Uri.parse(ApiEndpoints.userManagementStat));
print("[StatsUserManagementController] Response status: ${response.statusCode}");
print("[StatsUserManagementController] Raw response body: ${response.body}");

if (response.statusCode == 200) {
final jsonData = json.decode(response.body);
print("[StatsUserManagementController] Parsed JSON: $jsonData");

statsUserManagement.value = StatsUserManagementModel.fromJson(jsonData);
print("[StatsUserManagementController] Parsed Model: ${statsUserManagement.value}");

errorMessage.value = '';
} else {
errorMessage.value = 'Failed to load data: ${response.statusCode}';
print("[StatsUserManagementController] Error: ${errorMessage.value}");
}
} catch (e, stackTrace) {
errorMessage.value = 'Error: $e';
print("[StatsUserManagementController] Exception: $e");
print("[StatsUserManagementController] StackTrace: $stackTrace");
} finally {
isLoading(false);
print("[StatsUserManagementController] Loading finished.");
}
}
}
