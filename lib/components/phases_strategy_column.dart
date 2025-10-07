import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/controllers/game_select_controller.dart';
import 'package:scorer/widgets/custom_stratgy_container.dart';
import 'package:scorer/api/api_controllers/question_for_sessions_controller.dart';

class PhaseStrategyColumn extends StatelessWidget {
  final double widthScaleFactor;
  final double heightScaleFactor;
  final GameSelectController controller;
  final QuestionForSessionsController questionController;

  const PhaseStrategyColumn({
    super.key,
    required this.widthScaleFactor,
    required this.heightScaleFactor,
    required this.controller,
    required this.questionController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (questionController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (questionController.errorMessage.value.isNotEmpty) {
        return Center(child: Text(questionController.errorMessage.value));
      }
      final phases = questionController.questionData.value?.phases ?? [];
      if (phases.isEmpty) {
        return Center(child: Text("no_phases_available".tr));
      }

      return Column(
        children: List.generate(phases.length, (index) {
          final phase = phases[index];
          final phaseNumber = index + 1;
          final phaseTimeMin = (phase.timeDuration / 60).ceil();
          final isCurrentPhase = index == controller.currentPhase.value;
          final isPhaseComplete = controller.submittedQuestions.length == phase.questions.length &&
              index == controller.currentPhase.value;
          final isPastPhase = index < controller.currentPhase.value;

          Color iconContainerColor;
          IconData icon;
          String text2;
          String text3;
          Color smallContainerColor;
          Color largeContainerColor;
          int flex;
          int flex1;

          if (isPastPhase || isPhaseComplete) {
            // Completed
            iconContainerColor = AppColors.forwardColor;
            icon = Icons.check;
            text2 = "Completed • $phaseTimeMin min";
            text3 = "completed".tr;
            smallContainerColor = AppColors.forwardColor;
            largeContainerColor = AppColors.forwardColor;
            flex = 3;
            flex1 = 0;
          } else if (isCurrentPhase) {
            // Active
            iconContainerColor = AppColors.selectLangugaeColor;
            icon = Icons.play_arrow_sharp;
            text2 = "Active • ${controller.remainingTime.value}";
            text3 = "active".tr;
            smallContainerColor = AppColors.selectLangugaeColor;
            largeContainerColor = AppColors.selectLangugaeColor;
            final progress = (controller.submittedQuestions.length / phase.questions.length).clamp(0.0, 1.0);
            flex = (progress * 3).ceil().clamp(0, 3);
            flex1 = 3 - flex;
          } else {
            // Pending
            iconContainerColor = AppColors.watchColor;
            icon = Icons.watch_later;
            text2 = "Upcoming • $phaseTimeMin min";
            text3 = "pending".tr;
            smallContainerColor = AppColors.watchColor;
            largeContainerColor = AppColors.greyColor;
            flex = 0;
            flex1 = 3;
          }

          return Column(
            children: [
              CustomStratgyContainer(
                fontSize2: ResponsiveFont.getFontSizeCustom(
                  defaultSize: 14 * widthScaleFactor,
                  smallSize: 10 * widthScaleFactor,
                ),
                iconContainer: iconContainerColor,
                icon: icon,
                text1: "Phase $phaseNumber: ${phase.name.tr}",
                text2: text2,
                text3: text3,
                smallContainer: smallContainerColor,
                largeConatiner: largeContainerColor,
                flex: flex,
                flex1: flex1,
                width3: 80,
              ),
              SizedBox(height: 10 * heightScaleFactor),
            ],
          );
        }),
      );
    });
  }
}










// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:scorer/components/responsive_fonts.dart';
// import 'package:scorer/constants/appcolors.dart';
// import 'package:scorer/controllers/game_select_controller.dart';
// import 'package:scorer/widgets/custom_stratgy_container.dart';
// import 'package:scorer/api/api_controllers/question_for_sessions_controller.dart';
//
// class PhaseStrategyColumn extends StatelessWidget {
//   final double widthScaleFactor;
//   final double heightScaleFactor;
//   final GameSelectController controller;
//   final QuestionForSessionsController questionController; // Pass as parameter
//
//   const PhaseStrategyColumn({
//     super.key,
//     required this.widthScaleFactor,
//     required this.heightScaleFactor,
//     required this.controller,
//     required this.questionController, // Add to constructor
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (questionController.isLoading.value) {
//         return const Center(child: CircularProgressIndicator());
//       }
//       if (questionController.errorMessage.value.isNotEmpty) {
//         return Center(child: Text(questionController.errorMessage.value));
//       }
//       final phases = questionController.questionData.value?.phases ?? [];
//       if (phases.isEmpty) {
//         return  Center(child: Text("no_phases_available".tr));
//       }
//
//       return Column(
//         children: List.generate(phases.length, (index) {
//           final phase = phases[index];
//           final phaseNumber = index + 1;
//           final phaseTimeMin = (phase.timeDuration / 60).ceil();
//           Color iconContainerColor;
//           IconData icon;
//           String text2;
//           String text3;
//           Color smallContainerColor;
//           Color largeContainerColor;
//           int flex;
//           int flex1;
//
//           if (index < controller.currentPhase.value) {
//             // Completed
//             iconContainerColor = AppColors.forwardColor;
//             icon = Icons.check;
//             text2 = "Completed • $phaseTimeMin min";
//             text3 = "completed".tr;
//             smallContainerColor = AppColors.forwardColor;
//             largeContainerColor = AppColors.forwardColor;
//             flex = 3;
//             flex1 = 0;
//           } else if (index == controller.currentPhase.value) {
//             // Active
//             iconContainerColor = AppColors.selectLangugaeColor;
//             icon = Icons.play_arrow_sharp;
//             text2 = "Active • ${controller.remainingTime.value}";
//             text3 = "active".tr;
//             smallContainerColor = AppColors.selectLangugaeColor;
//             largeContainerColor = AppColors.selectLangugaeColor;
//             flex = (controller.timeProgress.value * 3).ceil().clamp(0, 3);
//             flex1 = 3 - flex;
//           } else {
//             // Pending
//             iconContainerColor = AppColors.watchColor;
//             icon = Icons.watch_later;
//             text2 = "Upcoming • $phaseTimeMin min";
//             text3 = "pending".tr;
//             smallContainerColor = AppColors.watchColor;
//             largeContainerColor = AppColors.greyColor;
//             flex = 0;
//             flex1 = 3;
//           }
//
//           return Column(
//             children: [
//               CustomStratgyContainer(
//                 fontSize2: ResponsiveFont.getFontSizeCustom(
//                   defaultSize: 14 * widthScaleFactor,
//                   smallSize: 10 * widthScaleFactor,
//                 ),
//                 iconContainer: iconContainerColor,
//                 icon: icon,
//                 text1: "Phase $phaseNumber: ${phase.name.tr}",
//                 text2: text2,
//                 text3: text3,
//                 smallContainer: smallContainerColor,
//                 largeConatiner: largeContainerColor,
//                 flex: flex,
//                 flex1: flex1,
//                 width3: 80,
//               ),
//               SizedBox(height: 10 * heightScaleFactor),
//             ],
//           );
//         }),
//       );
//     });
//   }
// }
//
