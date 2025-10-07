import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/player_analysis.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/components/tips_Container.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/login_button.dart';
import '../../api/api_controllers/player_score_controller.dart';
import '../../api/api_controllers/question_for_sessions_controller.dart';
import '../../components/phases_strategy_column.dart';
import '../../controllers/game_select_controller.dart';
import '../../widgets/player_side_widget/scoring_breakdown_widget.dart';
import '../FacilitateFolder/aa.dart';

class SubmitResponseScreen2 extends StatelessWidget {
  SubmitResponseScreen2({super.key});


  // ✅ Initialize the Question controller first
  final questionController = Get.put(QuestionForSessionsController());
//
  // ✅ Then inject it into GameSelectController
  final GameSelectController gamecontroller =
  Get.put(GameSelectController(questionController: Get.find<QuestionForSessionsController>()));

  final PlayerScoreController controller = Get.put(PlayerScoreController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final screenHeight = MediaQuery.of(context).size.height;
    const double baseHeight = 812.0;

    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;
    final double scaleFactor = screenWidth / baseWidth;

    // ✅ Load API data once
    controller.loadPlayerScores(playerId: 1, questionId: 1);

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 🟩 Header Row
                Padding(
                  padding: EdgeInsets.only(
                    left: 30 * scaleFactor,
                    right: 10 * scaleFactor,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        Appimages.player2,
                        height: 63 * scaleFactor,
                        width: 50 * scaleFactor,
                      ),
                      Expanded(
                        child: Center(
                          child: BoldText(
                            text: "team_alpha".tr,
                            fontSize: 22 * scaleFactor,
                          ),
                        ),
                      ),
                      Image.asset(
                        Appimages.house1,
                        height: 63 * scaleFactor,
                        width: 80 * scaleFactor,
                      ),
                    ],
                  ),
                ),

                // 🟩 Crown Image
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SvgPicture.asset(
                      Appimages.Crown,
                      height: 162 * scaleFactor,
                      width: 162 * scaleFactor,
                    ),
                  ],
                ),

                SizedBox(height: 30 * scaleFactor),

                // 🟩 Title
                BoldText(
                  text: "response_submitted".tr,
                  fontSize: 16 * scaleFactor,
                  selectionColor: AppColors.blueColor,
                ),

                SizedBox(height: 20 * scaleFactor),

                // 🟩 Player Analysis
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30 * scaleFactor),
                  child: PlayerAnalyasis(
                    scaleFactor: 1.0,
                    questionId: 1,
                  ),
                ),

                SizedBox(height: 100 * scaleFactor),

                // 🟩 Dynamic Scoring Breakdown
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(
                        controller.errorMessage.value,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16 * scaleFactor),
                    child: ScoringBreakdownWidget(
                      scoreData: controller.analysisData,
                      scaleFactor: scaleFactor,
                    ),
                  );
                }),

                SizedBox(height: 18 * scaleFactor),

                // 🟩 Tips Container
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13 * scaleFactor),
                  child: TipsContainer(
                    scaleFactor: scaleFactor,
                    widthScaleFactor: widthScaleFactor,
                  ),
                ),

                SizedBox(height: 18 * scaleFactor),

                // 🟩 Phase Strategy Column
                PhaseStrategyColumn(
                  widthScaleFactor: widthScaleFactor,
                  heightScaleFactor: heightScaleFactor,
                  controller: gamecontroller,
                  questionController: questionController,
                ),

                SizedBox(height: 30 * scaleFactor),

                // 🟩 Buttons
                LoginButton(
                  fontSize: 19.sp,
                  onTap: () =>
                      Get.toNamed(RouteName.playerLeaderboardScreen),
                  text: "live_leaderboard".tr,
                  ishow: true,
                  image: Appimages.tropy1,
                  imageHeight: 32.h,
                  imageWidth: 32.w,
                ),

                SizedBox(height: 10 * scaleFactor),

                LoginButton(
                  fontSize: 19.sp,
                  text: "export_pdf".tr,
                  ishow: true,
                  color: AppColors.redColor,
                  image: Appimages.export,
                  imageHeight: 32.h,
                  imageWidth: 32.w,
                ),

                SizedBox(height: 40 * scaleFactor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
















// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:scorer/components/player_analysis.dart';
// import 'package:scorer/components/responsive_fonts.dart';
// import 'package:scorer/components/tips_Container.dart';
// import 'package:scorer/constants/appcolors.dart';
// import 'package:scorer/constants/appimages.dart';
// import 'package:scorer/constants/routename.dart';
// import 'package:scorer/widgets/bold_text.dart';
// import 'package:scorer/widgets/custom_stratgy_container.dart';
// import 'package:scorer/widgets/login_button.dart';
//
// import '../../api/api_controllers/player_score_controller.dart';
// import '../../widgets/player_side_widget/scoring_breakdown_widget.dart';
// import '../FacilitateFolder/aa.dart';
//
// class SubmitResponseScreen2 extends StatelessWidget {
//   const SubmitResponseScreen2({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     const double baseWidth = 375.0;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final double baseHeight = 812.0;
//
//     final double heightScaleFactor = screenHeight / baseHeight;
//     final double widthScaleFactor = screenWidth / baseWidth;
//     final double scaleFactor = screenWidth / baseWidth;
//
//     // ✅ Initialize controller
//     final PlayerScoreController controller = Get.put(PlayerScoreController());
//
//     // ✅ Load API data once
//     controller.loadPlayerScores(playerId: 1, questionId: 1);
//
//     return Scaffold(
//       body: GradientBackground(
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(
//                     left: 30 * scaleFactor,
//                     right: 10 * scaleFactor,
//                   ),
//                   child: Row(
//                     children: [
//                       Image.asset(
//                         Appimages.player2,
//                         height: 63 * scaleFactor,
//                         width: 50 * scaleFactor,
//                       ),
//                       Expanded(
//                         child: Center(
//                           child: BoldText(
//                             text: "team_alpha".tr,
//                             fontSize: 22 * scaleFactor,
//                           ),
//                         ),
//                       ),
//                       Image.asset(
//                         Appimages.house1,
//                         height: 63 * scaleFactor,
//                         width: 80 * scaleFactor,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     SvgPicture.asset(
//                       Appimages.Crown,
//                       height: 162 * scaleFactor,
//                       width: 162 * scaleFactor,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 30 * scaleFactor),
//                 BoldText(
//                   text: "response_submitted".tr,
//                   fontSize: 16 * scaleFactor,
//                   selectionColor: AppColors.blueColor,
//                 ),
//                 SizedBox(height: 20 * scaleFactor),
//
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 30 * scaleFactor),
//                   child: PlayerAnalyasis(
//                     scaleFactor: 1.0,
//                     questionId: 1,
//                   ),
//                 ),
//
//                 SizedBox(height: 100 * scaleFactor),
//
//                 // ✅ Replaced static score box with dynamic controller
//                 Obx(() {
//                   if (controller.isLoading.value) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   if (controller.errorMessage.isNotEmpty) {
//                     return Center(
//                       child: Text(
//                         controller.errorMessage.value,
//                         style: const TextStyle(color: Colors.red),
//                       ),
//                     );
//                   }
//
//                   return Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16 * scaleFactor),
//                     child: ScoringBreakdownWidget(
//                       scoreData: controller.analysisData,
//                       scaleFactor: scaleFactor,
//                     ),
//                   );
//                 }),
//
//                 SizedBox(height: 18 * scaleFactor),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 13 * scaleFactor),
//                   child: TipsContainer(
//                     scaleFactor: scaleFactor,
//                     widthScaleFactor: widthScaleFactor,
//                   ),
//                 ),
//                 SizedBox(height: 18 * scaleFactor),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 30 * scaleFactor),
//                   child: Column(
//                     children: [
//                       CustomStratgyContainer(
//                         fontSize2: ResponsiveFont.getFontSize(),
//                         fontSize3: 10,
//                         width3: 68 * scaleFactor,
//                         iconContainer: AppColors.forwardColor,
//                         icon: Icons.check,
//                         text1: "phase1_strategy".tr,
//                         text2: "Completed • 20 min",
//                         text3: "completed".tr,
//                         smallContainer: AppColors.forwardColor,
//                         largeConatiner: AppColors.forwardColor,
//                         flex: 4,
//                         flex1: 0,
//                       ),
//                       SizedBox(height: 10 * scaleFactor),
//                       CustomStratgyContainer(
//                         fontSize2: ResponsiveFont.getFontSize(),
//                         fontSize3: 10,
//                         width3: 68 * scaleFactor,
//                         iconContainer: AppColors.forwardColor,
//                         icon: Icons.check,
//                         text1: "phase2_strategy".tr,
//                         text2: "Active • 30 min",
//                         text3: "Completed",
//                         smallContainer: AppColors.forwardColor,
//                         largeConatiner: AppColors.forwardColor,
//                         flex: 4,
//                         flex1: 0,
//                       ),
//                       SizedBox(height: 10 * scaleFactor),
//                       CustomStratgyContainer(
//                         fontSize2: ResponsiveFont.getFontSize(),
//                         fontSize3: 10,
//                         width3: 68 * scaleFactor,
//                         iconContainer: AppColors.watchColor,
//                         icon: Icons.watch_later,
//                         text1: "phase3_implementation".tr,
//                         text2: "Upcoming • 15 min",
//                         text3: "Pending",
//                         smallContainer: AppColors.watchColor,
//                         largeConatiner: AppColors.greyColor,
//                         flex: 4,
//                         flex1: 0,
//                       ),
//                       SizedBox(height: 10 * scaleFactor),
//                       CustomStratgyContainer(
//                         fontSize2: ResponsiveFont.getFontSize(),
//                         fontSize3: 10,
//                         width3: 68 * scaleFactor,
//                         iconContainer: AppColors.watchColor,
//                         icon: Icons.watch_later,
//                         text1: "phase4_evaluation".tr,
//                         text2: "Upcoming • 15 min",
//                         text3: "Pending",
//                         smallContainer: AppColors.watchColor,
//                         largeConatiner: AppColors.greyColor,
//                         flex: 4,
//                         flex1: 0,
//                       ),
//                       SizedBox(height: 30 * scaleFactor),
//                       // LoginButton(
//                       //   fontSize: 19.sp,
//                       //   text: "move_to_phase_3".tr,
//                       //   color: AppColors.forwardColor,
//                       //   ishow: true,
//                       //   image: Appimages.submit,
//                       //   imageHeight: 32.h,
//                       //   imageWidth: 32.w,
//                       // ),
//                       // SizedBox(height: 10 * scaleFactor),
//                       LoginButton(
//                         fontSize: 19.sp,
//                         onTap: () =>
//                             Get.toNamed(RouteName.playerLeaderboardScreen),
//                         text: "live_leaderboard".tr,
//                         ishow: true,
//                         image: Appimages.tropy1,
//                         imageHeight: 32.h,
//                         imageWidth: 32.w,
//                       ),
//                       SizedBox(height: 10 * scaleFactor),
//                       LoginButton(
//                         fontSize: 19.sp,
//                         text: "export_pdf".tr,
//                         ishow: true,
//                         color: AppColors.redColor,
//                         image: Appimages.export,
//                         imageHeight: 32.h,
//                         imageWidth: 32.w,
//                       ),
//                       SizedBox(height: 40 * scaleFactor),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
