// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
//
// import '../../components/complete_session_row.dart';
// import '../../constants/appcolors.dart';
// import '../bold_text.dart';
// import '../custom_stratgy_container.dart';
// import '../main_text.dart';
// import '../pause_container.dart';
// import '../useable_container.dart';
//
//
// class PhasedProgress extends StatelessWidget {
//   final double widthScaleFactor;
//   final double heightScaleFactor;
//   final double screenWidth;
//
//
//
//
//   final String phaseText;
//   final String phaseLabel;
//   final double percentCompleted;
//   final String remainingTime;
//   final String stageText;
//   final String stageStatusText;
//   final bool isStageCompleted;
//
//   final int clickCount;
//
//   final VoidCallback onPause;
//   final VoidCallback onNextPhase;
//   final VoidCallback onBack;
//
//   const PhasedProgress({
//     Key? key,
//     required this.widthScaleFactor,
//     required this.heightScaleFactor,
//     required this.screenWidth,
//     required this.phaseText,
//     required this.phaseLabel,
//     required this.percentCompleted,
//     required this.remainingTime,
//     required this.stageText,
//     required this.stageStatusText,
//     required this.isStageCompleted,
//     required this.clickCount,
//     required this.onPause,
//     required this.onNextPhase,
//     required this.onBack,
//   }) : super(key: key);
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 390 * heightScaleFactor,
//       width: 376 * widthScaleFactor,
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: AppColors.greyColor,
//           width: 1.5,
//         ),
//         borderRadius: BorderRadius.circular(24 * widthScaleFactor),
//       ),
//       child: Padding(
//         padding: EdgeInsets.only(
//           top: 17 * heightScaleFactor,
//           right: 21 * widthScaleFactor,
//           left: 20 * widthScaleFactor,
//         ),
//         child: Column(
//           children: [
//             _buildPhaseHeader(),
//             SizedBox(height: 20 * heightScaleFactor),
//             MainText(
//               text: "team_collab_phase".tr,
//               fontSize: 14 * heightScaleFactor,
//             ),
//             SizedBox(height: 15 * heightScaleFactor),
//             CompleteSessionRow(widthScaleFactor: widthScaleFactor, controller: controller), // pass your controller
//             SizedBox(height: 16 * heightScaleFactor),
//             CustomStratgyContainer(
//               flex1: isStageCompleted ? 0 : 1,
//               flex: isStageCompleted ? 4 : 3,
//               borderColor:
//               isStageCompleted ? AppColors.forwardColor : AppColors.selectLangugaeColor,
//               iconContainer:
//               isStageCompleted ? AppColors.forwardColor : AppColors.selectLangugaeColor,
//               icon: Icons.play_arrow_sharp,
//               text1: stageText,
//               text2: stageStatusText,
//               text3: "active".tr,
//               smallContainer:
//               isStageCompleted ? AppColors.forwardColor : AppColors.selectLangugaeColor,
//               largeConatiner:
//               isStageCompleted ? AppColors.forwardColor : AppColors.selectLangugaeColor,
//             ),
//             SizedBox(height: 20 * heightScaleFactor),
//             _buildActionButtons(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPhaseHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             BoldText(
//               text: "current_phase".tr,
//               fontSize: 16 * heightScaleFactor,
//               selectionColor: AppColors.blueColor,
//             ),
//             SizedBox(height: 5 * heightScaleFactor),
//             Row(
//               children: [
//                 UseableContainer(
//                   width: 70,
//                   height: 25,
//                   text: phaseText,
//                   color: AppColors.orangeColor,
//                   fontSize: 10 * heightScaleFactor,
//                 ),
//                 SizedBox(width: 10 * widthScaleFactor),
//                 MainText(
//                   text: phaseLabel,
//                   fontSize: 14 * widthScaleFactor,
//                 ),
//               ],
//             ),
//           ],
//         ),
//         CircularPercentIndicator(
//           radius: 40.0 * widthScaleFactor,
//           lineWidth: 4.0 * widthScaleFactor,
//           percent: percentCompleted,
//           animation: true,
//           animationDuration: 500,
//           circularStrokeCap: CircularStrokeCap.round,
//           backgroundColor: Colors.transparent,
//           progressColor: AppColors.forwardColor,
//           center: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               BoldText(
//                 text: remainingTime,
//                 fontSize: screenWidth * 0.04,
//                 selectionColor: AppColors.blueColor,
//               ),
//               MainText(
//                 text: "remaining".tr,
//                 fontSize: screenWidth * 0.02,
//                 height: 1,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildActionButtons() {
//     bool showBack = clickCount >= 2;
//     return Center(
//       child: showBack
//           ? PauseContainer(
//         width: double.infinity,
//         onTap: onBack,
//         text: "back".tr,
//         color: AppColors.selectLangugaeColor,
//         height: 35 * heightScaleFactor,
//       )
//           : Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: PauseContainer(
//               onTap: onPause,
//               text: "pause".tr,
//               color: AppColors.selectLangugaeColor,
//               height: 35 * heightScaleFactor,
//             ),
//           ),
//           SizedBox(width: 20 * widthScaleFactor),
//           Expanded(
//             child: PauseContainer(
//               onTap: onNextPhase,
//               text: "next_phase".tr,
//               icon: Icons.fast_forward,
//               color: isStageCompleted ? AppColors.forwardColor : AppColors.assignColor,
//               height: 35 * heightScaleFactor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
