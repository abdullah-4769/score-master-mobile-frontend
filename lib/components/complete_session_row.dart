


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/controllers/game_select_controller.dart';
import 'package:scorer/widgets/main_text.dart';

import '../api/api_controllers/question_for_sessions_controller.dart';

class CompleteSessionRow extends StatelessWidget {
  const CompleteSessionRow({
    super.key,
    required this.widthScaleFactor,
    required this.controller,
  });

  final double widthScaleFactor;
  final GameSelectController controller;

  @override
  Widget build(BuildContext context) {
    final QuestionForSessionsController questionController = Get.find<QuestionForSessionsController>();

    return Obx(() {
      if (questionController.isLoading.value) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppColors.forwardColor,
              strokeWidth: 4 * widthScaleFactor,
            ),
          ],
        );
      }

      final totalPhases = questionController.questionData.value?.phases.length ?? 1;
      final currentPhase = controller.currentPhase.value;

      // For current phase display, we only show the current phase indicator
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10 * widthScaleFactor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 25 * widthScaleFactor,
              width: 25 * widthScaleFactor,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.forwardColor,
              ),
              child: Center(
                child: BoldText(
                  text: "${currentPhase + 1}",
                  color: AppColors.whiteColor,
                  fontSize: 12 * widthScaleFactor,
                ),
              ),
            ),
            SizedBox(width: 10 * widthScaleFactor),
            MainText(
              text: "Phase ${currentPhase + 1} of $totalPhases",
              fontSize: 14 * widthScaleFactor,
              color: AppColors.blueColor,
            ),
          ],
        ),
      );
    });
  }
}

// Helper BoldText widget since it's referenced but not imported
class BoldText extends StatelessWidget {
  final String text;
  final Color? color;
  final double fontSize;

  const BoldText({
    super.key,
    required this.text,
    this.color,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:scorer/constants/appcolors.dart';
// import 'package:scorer/controllers/game_select_controller.dart';
// import 'package:scorer/widgets/main_text.dart';
//
// import '../api/api_controllers/question_for_sessions_controller.dart';
//
// class CompleteSessionRow extends StatelessWidget {
//   const CompleteSessionRow({
//     super.key,
//     required this.widthScaleFactor,
//     required this.controller,
//   });
//
//   final double widthScaleFactor;
//   final GameSelectController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     final QuestionForSessionsController questionController = Get.find<QuestionForSessionsController>();
//
//     return Obx(() {
//       // Check if loading or no data
//       if (questionController.isLoading.value) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(
//               color: AppColors.forwardColor,
//               strokeWidth: 4 * widthScaleFactor,
//             ),
//           ],
//         );
//       }
//
//       // Get the total number of phases from the API
//       final totalPhases = questionController.questionData.value?.phases.length ?? 1; // Fallback to 1 phase
//       final currentPhase = controller.currentPhase.value; // 0-based index
//
//       // Determine the range of phases to display
//       int startPhase;
//       int endPhase;
//
//       if (totalPhases <= 3) {
//         // Show all phases if 3 or fewer
//         startPhase = 0;
//         endPhase = totalPhases - 1;
//       } else {
//         // Show 3 phases, centered around currentPhase when possible
//         if (currentPhase == 0) {
//           startPhase = 0;
//           endPhase = 2;
//         } else if (currentPhase >= totalPhases - 1) {
//           startPhase = totalPhases - 3;
//           endPhase = totalPhases - 1;
//         } else {
//           startPhase = currentPhase - 1;
//           endPhase = currentPhase + 1;
//         }
//         // Ensure bounds
//         startPhase = startPhase.clamp(0, totalPhases - 1);
//         endPhase = endPhase.clamp(0, totalPhases - 1);
//       }
//
//       // Generate widgets for phases
//       List<Widget> phaseWidgets = [];
//       for (int i = startPhase; i <= endPhase; i++) {
//         // Circle for each phase
//         phaseWidgets.add(
//           Container(
//             height: 20 * widthScaleFactor,
//             width: 20 * widthScaleFactor,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: controller.currentPhase.value >= i
//                   ? AppColors.forwardColor
//                   : (i == controller.currentPhase.value ? AppColors.orangeColor : AppColors.greyColor),
//             ),
//             child: Center(
//               child: controller.currentPhase.value >= i
//                   ? Icon(
//                 Icons.check,
//                 size: 17 * widthScaleFactor,
//                 color: AppColors.whiteColor,
//               )
//                   : MainText(
//                 text: "${i + 1}", // 1-based phase number
//                 color: AppColors.whiteColor,
//                 fontSize: 11 * widthScaleFactor,
//               ),
//             ),
//           ),
//         );
//
//         // Add line between circles, except after the last circle
//         if (i < endPhase) {
//           phaseWidgets.add(
//             SizedBox(width: 7 * widthScaleFactor),
//           );
//           phaseWidgets.add(
//             Container(
//               width: 120 * widthScaleFactor,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: controller.currentPhase.value > i ? AppColors.forwardColor : AppColors.greyColor,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//             ),
//           );
//           phaseWidgets.add(
//             SizedBox(width: 7 * widthScaleFactor),
//           );
//         }
//       }
//
//       // Calculate total width to prevent overflow
//       final totalWidth = (endPhase - startPhase + 1) * (20 * widthScaleFactor) + // Circles
//           (endPhase - startPhase) * (120 * widthScaleFactor + 14 * widthScaleFactor) + // Lines + spacing
//           2 * (24 * widthScaleFactor + 10 * widthScaleFactor); // Arrows + spacing
//       final screenWidth = MediaQuery.of(context).size.width;
//       final scaleFactor = totalWidth > screenWidth * 0.9 ? (screenWidth * 0.9) / totalWidth : 1.0;
//
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Previous arrow
//           GestureDetector(
//             onTap: startPhase > 0
//                 ? () {
//               controller.currentPhase.value = startPhase - 1;
//             }
//                 : null,
//             child: Icon(
//               Icons.arrow_left,
//               size: 24 * widthScaleFactor * scaleFactor,
//               color: startPhase > 0 ? AppColors.forwardColor : AppColors.greyColor,
//             ),
//           ),
//           SizedBox(width: 10 * widthScaleFactor * scaleFactor),
//           // Phase indicators with scaling
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: phaseWidgets
//                 .map((widget) => widget is SizedBox
//                 ? SizedBox(width: (widget.width ?? 0) * scaleFactor)
//                 : Transform.scale(
//               scale: scaleFactor,
//               child: widget,
//             ))
//                 .toList(),
//           ),
//           SizedBox(width: 10 * widthScaleFactor * scaleFactor),
//           // Next arrow
//           GestureDetector(
//             onTap: endPhase < totalPhases - 1
//                 ? () {
//               controller.currentPhase.value = endPhase + 1;
//             }
//                 : null,
//             child: Icon(
//               Icons.arrow_right,
//               size: 24 * widthScaleFactor * scaleFactor,
//               color: endPhase < totalPhases - 1 ? AppColors.forwardColor : AppColors.greyColor,
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }