import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/useable_container.dart';
import '../../shared_preferences/shared_preferences.dart';
import '../api/api_controllers/player_score_controller.dart';

class PlayerAnalyasis extends StatelessWidget {
  final double scaleFactor;
  final int questionId;

  PlayerAnalyasis({
    super.key,
    required this.scaleFactor,
    required this.questionId,
  }) {
    final controller = Get.put(PlayerScoreController());
    // Load data after initialization
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // final playerId = await SharedPrefServices.getUserId();
      // if (playerId != null) {
      //   controller.loadPlayerScores(playerId: playerId, questionId: questionId);
      // }
      controller.loadPlayerScores(playerId: 1, questionId: questionId); // Hardcode playerId: 1 for testing
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlayerScoreController>();
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      }

      final data = controller.scores.isNotEmpty ? controller.scores[0] : null;
      if (data == null) {
        return const Center(child: Text("No analysis data found."));
      }

      return Container(
        height: 510 * scaleFactor,
        width: 330 * scaleFactor,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.greyColor,
            width: 1.5 * scaleFactor,
          ),
          borderRadius: BorderRadius.circular(24 * scaleFactor),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15 * scaleFactor),
              child: Column(
                children: [
                  SizedBox(height: 27 * scaleFactor),
                  BoldText(
                    text: "ai_analysis_suggestion".tr,
                    fontSize: 16 * scaleFactor,
                    selectionColor: AppColors.blueColor,
                  ),
                  SizedBox(height: 28 * scaleFactor),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        right: -10 * scaleFactor,
                        top: -10 * scaleFactor,
                        child: SvgPicture.asset(Appimages.arrowdown),
                      ),
                      Container(child: Image.asset(Appimages.ai2)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BoldText(
                        text: "relevance_score".tr,
                        fontSize: 16 * scaleFactor,
                        selectionColor: AppColors.blueColor,
                      ),
                      UseableContainer(
                        text: data.relevanceScore?.toString() ?? "N/A",
                        fontFamily: "giory",
                        fontSize: 14 * scaleFactor,
                        width: 37 * scaleFactor,
                        height: 28 * scaleFactor,
                        color: AppColors.orangeColor,
                      ),
                    ],
                  ),
                  MainText(
                    text: data.suggestion ?? "No suggestion available",
                    fontSize: 14 * scaleFactor,
                    height: 1.3,
                  ),
                  SizedBox(height: 10 * scaleFactor),
                  Divider(color: AppColors.greyColor, thickness: 1 * scaleFactor),
                  SizedBox(height: 20 * scaleFactor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BoldText(
                        text: "quality_assessment".tr,
                        fontSize: 16 * scaleFactor,
                        selectionColor: AppColors.blueColor,
                      ),
                      UseableContainer(
                        text: data.qualityAssessment ?? "N/A",
                        fontSize: 12 * scaleFactor,
                        width: 60 * scaleFactor,
                        height: 28 * scaleFactor,
                        color: AppColors.forwardColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 10 * scaleFactor),
                  MainText(
                    text: data.description ?? "No description available",
                    fontSize: 14 * scaleFactor,
                    height: 1.3,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: -70 * scaleFactor,
              left: 70 * scaleFactor,
              child: Container(
                height: 181 * scaleFactor,
                width: 181 * scaleFactor,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColors.forwardColor, Colors.grey.shade200],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.all(3 * scaleFactor),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 202, 202, 202),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BoldText(
                        text: "${data.finalScore ?? 0}/100",
                        fontSize: 30.sp,
                        selectionColor: AppColors.createBorderColor,
                      ),
                      SizedBox(height: 4 * scaleFactor),
                      BoldText(
                        text: "final_score".tr,
                        fontSize: 16.sp,
                        selectionColor: AppColors.blueColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}



















// // lib/components/player_analysis.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:scorer/constants/appcolors.dart';
// import 'package:scorer/constants/appimages.dart';
// import 'package:scorer/widgets/bold_text.dart';
// import 'package:scorer/widgets/main_text.dart';
// import 'package:scorer/widgets/useable_container.dart';
// import '../../shared_preferences/shared_preferences.dart';
// import '../api/api_controllers/player_score_controller.dart';
//
//
// class PlayerAnalyasis extends StatefulWidget {
//   const PlayerAnalyasis({
//     super.key,
//     required this.scaleFactor,
//     required this.questionId,
//   });
//
//   final double scaleFactor;
//   final int questionId;
//
//   @override
//   State<PlayerAnalyasis> createState() => _PlayerAnalyasisState();
// }
//
// class _PlayerAnalyasisState extends State<PlayerAnalyasis> {
//   final controller = Get.put(PlayerScoreController());
//   bool _hasLoaded = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadAnalysis();
//   }
//
//   void _loadAnalysis() async {
//     final playerId = await SharedPrefServices.getUserId();
//     if (playerId != null && !_hasLoaded) {
//       controller.loadPlayerScores(
//         playerId: playerId,
//         questionId: widget.questionId,
//       );
//       _hasLoaded = true;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return const Center(child: CircularProgressIndicator());
//       }
//
//       if (controller.errorMessage.isNotEmpty) {
//         return Center(child: Text(controller.errorMessage.value));
//       }
//
//       final data = controller.analysisData;
//       if (data == null) {
//         return const Center(child: Text("No analysis data found."));
//       }
//
//       // ✅ no UI change — same as yours
//       return Container(
//         height: 510 * widget.scaleFactor,
//         width: 330 * widget.scaleFactor,
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: AppColors.greyColor,
//             width: 1.5 * widget.scaleFactor,
//           ),
//           borderRadius: BorderRadius.circular(24 * widget.scaleFactor),
//         ),
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15 * widget.scaleFactor),
//               child: Column(
//                 children: [
//                   SizedBox(height: 27 * widget.scaleFactor),
//                   BoldText(
//                     text: "ai_analysis_suggestion".tr,
//                     fontSize: 16 * widget.scaleFactor,
//                     selectionColor: AppColors.blueColor,
//                   ),
//                   SizedBox(height: 28 * widget.scaleFactor),
//                   Stack(
//                     clipBehavior: Clip.none,
//                     children: [
//                       Positioned(
//                         right: -10 * widget.scaleFactor,
//                         top: -10 * widget.scaleFactor,
//                         child: SvgPicture.asset(Appimages.arrowdown),
//                       ),
//                       Container(child: Image.asset(Appimages.ai2)),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       BoldText(
//                         text: "relevance_score".tr,
//                         fontSize: 16 * widget.scaleFactor,
//                         selectionColor: AppColors.blueColor,
//                       ),
//                       UseableContainer(
//                         text: data.relevanceScore.toString(),
//                         fontFamily: "giory",
//                         fontSize: 14 * widget.scaleFactor,
//                         width: 37 * widget.scaleFactor,
//                         height: 28 * widget.scaleFactor,
//                         color: AppColors.orangeColor,
//                       ),
//                     ],
//                   ),
//                   MainText(
//                     text: data.suggestion,
//                     fontSize: 14 * widget.scaleFactor,
//                     height: 1.3,
//                   ),
//                   SizedBox(height: 10 * widget.scaleFactor),
//                   Divider(color: AppColors.greyColor, thickness: 1 * widget.scaleFactor),
//                   SizedBox(height: 20 * widget.scaleFactor),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       BoldText(
//                         text: "quality_assessment".tr,
//                         fontSize: 16 * widget.scaleFactor,
//                         selectionColor: AppColors.blueColor,
//                       ),
//                       UseableContainer(
//                         text: data.qualityAssessment,
//                         fontSize: 12 * widget.scaleFactor,
//                         width: 60 * widget.scaleFactor,
//                         height: 28 * widget.scaleFactor,
//                         color: AppColors.forwardColor,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10 * widget.scaleFactor),
//                   MainText(
//                     text: data.description,
//                     fontSize: 14 * widget.scaleFactor,
//                     height: 1.3,
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               bottom: -70 * widget.scaleFactor,
//               left: 70 * widget.scaleFactor,
//               child: Container(
//                 height: 181 * widget.scaleFactor,
//                 width: 181 * widget.scaleFactor,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: LinearGradient(
//                     colors: [AppColors.forwardColor, Colors.grey.shade200],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                 ),
//                 child: Container(
//                   margin: EdgeInsets.all(3 * widget.scaleFactor),
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color.fromARGB(255, 202, 202, 202),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       BoldText(
//                         text: "${data.finalScore}/100",
//                         fontSize: 30.sp,
//                         selectionColor: AppColors.createBorderColor,
//                       ),
//                       SizedBox(height: 4 * widget.scaleFactor),
//                       BoldText(
//                         text: "final_score".tr,
//                         fontSize: 16.sp,
//                         selectionColor: AppColors.blueColor,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }



