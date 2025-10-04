// lib/view/FacilitateFolder/evaluate_response_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/audio_container.dart';
import 'package:scorer/components/feedback_container.dart';
import 'package:scorer/components/player_analysis.dart';
import 'package:scorer/components/team_Alpha_Container.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/custom_response_container.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';

import '../../api/api_controllers/evaluate_response.dart';
import '../../components/adminside/scoring_breakdown_container.dart';

class EvaluateResponseScreen extends StatelessWidget {
  final ScoreController scoreController = Get.put(ScoreController());

  EvaluateResponseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    const double baseHeight = 812.0;
    const double baseWidth = 414.0;
    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;

    // Get response data from arguments (from previous screen)
    final responseData = Get.arguments;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30 * widthScaleFactor,
                ),
                child: SingleChildScrollView(
                  child: Obx(() {
                    final score = scoreController.scoreResponse.value;
                    final isLoading = scoreController.isLoading.value;

                    return Column(
                      children: [
                        // Header
                        SizedBox(
                          height: 50,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  onTap: () => Get.back(),
                                  child: SvgPicture.asset(
                                    Appimages.arrowback,
                                    colorFilter: ColorFilter.mode(
                                      AppColors.forwardColor,
                                      BlendMode.srcIn,
                                    ),
                                    width: 24.w,
                                    height: 20.h,
                                  ),
                                ),
                              ),
                              Center(
                                child: BoldText(
                                  text: "evaluate_response".tr,
                                  selectionColor: AppColors.blueColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 27 * heightScaleFactor),

                        // Response Container
                        CustomResponseContainer(
                          ishow1: false,
                          containerHeight: 175 * heightScaleFactor,
                          color1: AppColors.forwardColor,
                          text1: "view_score".tr,
                          image: Appimages.eye,
                          text: "scored".tr,
                          ishow: true,
                          textColor: AppColors.whiteColor,
                          playerName: responseData?.player?.name,
                          questionText: responseData?.question?.text,
                          answer: responseData?.answerData?.sequence?.join(', '),
                          questionPoints: responseData?.question?.point,
                        ),

                        SizedBox(height: 12 * heightScaleFactor),
                        BoldText(
                          text: "relevance_threshold".tr,
                          fontSize: 16 * widthScaleFactor,
                          selectionColor: AppColors.forwardColor,
                        ),
                        SizedBox(height: 121 * heightScaleFactor),

                        // Show loading or data
                        if (isLoading)
                          SizedBox(
                            height: 200.h,
                            child: Center(child: CircularProgressIndicator()),
                          )
                        else if (scoreController.errorMessage.value.isNotEmpty)
                          Column(
                            children: [
                              Text(
                                scoreController.errorMessage.value,
                                style: TextStyle(color: AppColors.redColor),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: scoreController.refreshScore,
                                child: Text('Retry'),
                              ),
                            ],
                          )
                        else if (score != null) ...[
                            // Feedback Container
                            FeedbackContainer(
                              ishow: true,
                              finalScore: score.finalScore,
                              feedback: score.feedback,
                            ),
                            SizedBox(height: 12 * heightScaleFactor),

                            // Audio Container
                            AudioContainer(
                              feedbackText: score.feedback,
                            ),
                            SizedBox(height: 12 * heightScaleFactor),

                            // Player Analysis
                            PlayerAnalyasis(
                              scaleFactor: 0.9,
                              finalScore: score.finalScore,
                              relevanceScore: score.relevanceScore,
                              suggestion: score.suggestion,
                              qualityAssessment: score.qualityAssessment,
                              description: score.description,
                            ),
                            SizedBox(height: 64 * heightScaleFactor),

                            // Team Response Container
                            Container(
                              height: 700 * heightScaleFactor,
                              width: 330 * widthScaleFactor,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  24 * widthScaleFactor,
                                ),
                                border: Border.all(
                                  color: AppColors.greyColor,
                                  width: 1.5 * widthScaleFactor,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 17 * widthScaleFactor,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20 * heightScaleFactor),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        BoldText(
                                          text: "team_response".tr,
                                          fontSize: 16 * widthScaleFactor,
                                          selectionColor: AppColors.blueColor,
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              Appimages.timeout2,
                                              height: 19 * heightScaleFactor,
                                              width: 19 * widthScaleFactor,
                                            ),
                                            MainText(
                                              text: "2 min read",
                                              fontSize: 14 * widthScaleFactor,
                                              color: AppColors.teamColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20 * heightScaleFactor),
                                    MainText(
                                      text: responseData?.question?.scenario ??
                                          "Primary Objective: Our primary objective is to increase customer satisfaction by 25% through improved service delivery.",
                                      fontSize: 14 * widthScaleFactor,
                                      height: 1.2,
                                    ),
                                    SizedBox(height: 20 * heightScaleFactor),
                                    BoldText(
                                      text: "key_strategies".tr,
                                      fontSize: 16 * widthScaleFactor,
                                      selectionColor: AppColors.blueColor,
                                    ),
                                    SizedBox(height: 20 * heightScaleFactor),
                                    MainText(
                                      text: "feedback_system".tr,
                                      fontSize: 14 * widthScaleFactor,
                                      height: 1.2,
                                    ),
                                    SizedBox(height: 20 * heightScaleFactor),
                                    MainText(
                                      text: "reduce_response_time".tr,
                                      fontSize: 14 * widthScaleFactor,
                                      height: 1.2,
                                    ),
                                    SizedBox(height: 20 * heightScaleFactor),
                                    MainText(
                                      text: "enhance_self_service".tr,
                                      fontSize: 14 * widthScaleFactor,
                                      height: 1.2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 12 * heightScaleFactor),

                            // Scoring Breakdown - YEH FIX HO GAYA
                            ScoringBreakdownContainer(
                              widthScaleFactor: widthScaleFactor,
                              heightScaleFactor: heightScaleFactor,
                              charity: score.scoreBreakdown.charity,
                              strategicThinking:
                              score.scoreBreakdown.strategicThinking,
                              feasibility: score.scoreBreakdown.feasibility,
                              innovation: score.scoreBreakdown.innovation,
                            ),
                            SizedBox(height: 26 * heightScaleFactor),

                            // Buttons
                            LoginButton(
                              onTap: () {
                                Get.snackbar(
                                  'Success',
                                  'AI Score Accepted: ${score.finalScore}',
                                  backgroundColor: AppColors.forwardColor,
                                  colorText: AppColors.whiteColor,
                                );
                                Get.back();
                              },
                              text: "accept_ai_score".tr,
                              fontSize: 18,
                              color: AppColors.forwardColor,
                              image: Appimages.ai2,
                              ishow: true,
                              imageHeight: 38 * heightScaleFactor,
                              imageWidth: 32 * widthScaleFactor,
                            ),
                            SizedBox(height: 15 * heightScaleFactor),
                            LoginButton(
                              onTap: () {
                                // Manual override logic
                              },
                              fontSize: 18,
                              text: "manual_overwrite".tr,
                              ishow: true,
                              imageHeight: 32 * heightScaleFactor,
                              imageWidth: 32 * widthScaleFactor,
                              icon: Icons.edit,
                            ),
                          ] else
                            Center(
                              child: Text('No score data available'),
                            ),

                        SizedBox(height: 23 * heightScaleFactor),
                      ],
                    );
                  }),
                ),
              ),

              // Team Alpha Container
              Positioned(
                right: 0,
                top: screenHeight * 0.2,
                child: TeamAlphaContainer(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}