// // lib/api/api_controllers/view_responses_controller.dart
// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../../controllers/stage_controllers.dart';
// import '../api_models/view_response_model.dart';
// import '../api_urls.dart';
//
// class ViewResponsesController extends GetxController {
//   var questionResponses = <QuestionResponse>[].obs;
//   var isLoading = true.obs;
//   var errorMessage = ''.obs;
//
//   // Getter for scored count
//   RxInt get scoredCount => RxInt(questionResponses
//       .expand((qr) => qr.answers)
//       .where((answer) => answer.score != null)
//       .length);
//
//   // Getter for pending count
//   RxInt get pendingCount => RxInt(questionResponses
//       .expand((qr) => qr.answers)
//       .where((answer) => answer.score == null)
//       .length);
//
//   // Getter for filtered responses based on selected tab
//   List<Answer> get filteredResponses {
//     final stageController = Get.find<StageController>();
//     final allAnswers = questionResponses.expand((qr) => qr.answers).toList();
//     switch (stageController.selectedIndex.value) {
//       case 0: // All
//         return allAnswers;
//       case 1: // Pending
//         return allAnswers.where((answer) => answer.score == null).toList();
//       case 2: // Scored
//         return allAnswers.where((answer) => answer.score != null).toList();
//       default:
//         return allAnswers;
//     }
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchResponses();
//   }
//
//   Future<void> fetchResponses() async {
//     try {
//       isLoading(true);
//       errorMessage.value = '';
//       final response = await http.get(Uri.parse(ApiEndpoints.viewResponse));
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         questionResponses.value = data.map((json) => QuestionResponse.fromJson(json)).toList();
//       } else {
//         errorMessage.value = 'Failed to load responses: ${response.statusCode}';
//       }
//     } catch (e) {
//       errorMessage.value = 'Error: $e';
//     } finally {
//       isLoading(false);
//     }
//   }
// }
// lib/api/api_controllers/view_responses_controller.dart
// lib/api/api_controllers/view_responses_controller.dart
// lib/api/api_controllers/view_responses_controller.dart
// lib/api/api_controllers/view_responses_controller.dart
// lib/api/api_controllers/view_response_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../controllers/stage_controllers.dart';
import '../api_models/view_response_model.dart';
import '../api_urls.dart';

class ViewResponsesController extends GetxController {
  var questionResponses = <QuestionResponse>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  // Fixed: Return int instead of RxInt
  int get scoredCount => questionResponses
      .expand((qr) => qr.answers)
      .where((answer) => answer.score != null)
      .length;

  // Fixed: Return int instead of RxInt
  int get pendingCount => questionResponses
      .expand((qr) => qr.answers)
      .where((answer) => answer.score == null)
      .length;

  // Getter for filtered responses based on selected tab
  List<Answer> get filteredResponses {
    final stageController = Get.find<StageController>();
    final allAnswers = questionResponses.expand((qr) => qr.answers).toList();

    switch (stageController.selectedIndex.value) {
      case 0: // All
        return allAnswers;
      case 1: // Pending
        return allAnswers.where((answer) => answer.score == null).toList();
      case 2: // Scored
        return allAnswers.where((answer) => answer.score != null).toList();
      default:
        return allAnswers;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchResponses();
  }

  Future<void> fetchResponses() async {
    try {
      isLoading(true);
      errorMessage.value = '';

      final response = await http.get(Uri.parse(ApiEndpoints.viewResponse));
      print("API Raw Body: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);

        if (decoded == null) {
          questionResponses.clear();
        } else if (decoded is List) {
          questionResponses.value =
              decoded.map((json) => QuestionResponse.fromJson(json)).toList();
        } else if (decoded is Map<String, dynamic>) {
          questionResponses.value = [QuestionResponse.fromJson(decoded)];
        } else {
          errorMessage.value = "Unexpected response format";
        }

        print('Parsed responses: ${questionResponses.length}');
      } else {
        errorMessage.value = 'Failed to load responses: ${response.statusCode}';
        print('API Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
      print('Exception: $e');
    } finally {
      isLoading(false);
    }
  }

  // Method to refresh data after scoring
  void refreshData() {
    fetchResponses();
  }
}