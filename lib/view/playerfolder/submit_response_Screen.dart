import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/components/adminside/admin_team_progress.dart';
import 'package:scorer/components/playerside/leader_stack_container.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/custom_stratgy_container.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/useable_textrow.dart';

class SubmitResponseScreen extends StatelessWidget {
  const SubmitResponseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    const double baseWidth = 375.0;
    final double scaleFactor = screenWidth / baseWidth;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
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
                    SizedBox(height: 10 * scaleFactor),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Image.asset(
                          Appimages.ok,
                          height: 310 * scaleFactor,
                          width: 310 * scaleFactor,
                        ),
                        Positioned(
                          bottom: 70 * scaleFactor,
                          right: 40 * scaleFactor,
                          child: CreateContainer(
                            text: "5 Phases",
                            width: 84 * scaleFactor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10 * scaleFactor),
                    BoldText(
                      text: "response_submitted".tr,
                      fontSize: 16 * scaleFactor,
                      selectionColor: AppColors.blueColor,
                    ),
                    Center(
                      child: MainText(
                        height: 1.2,
                        text: "team_decision_recorded".tr,
                        fontSize: 14 * scaleFactor,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20 * scaleFactor),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30 * scaleFactor,
                      ),
                      child: Container(
                        width: 338 * scaleFactor,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.greyColor,
                            width: 1.5 * scaleFactor,
                          ),
                          borderRadius: BorderRadius.circular(24 * scaleFactor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20 * scaleFactor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 30 * scaleFactor),
                              BoldText(
                                text: "your_submission".tr,
                                selectionColor: AppColors.blueColor,
                                fontSize: 16 * scaleFactor,
                              ),
                              SizedBox(height: 15 * scaleFactor),
                              MainText(
                                height: 1.5,
                                text: "mountain_resort".tr,
                                fontSize: 13 * scaleFactor,
                              ),
                              SizedBox(height: 15 * scaleFactor),
                              BoldText(
                                text: "reasoning".tr,
                                selectionColor: AppColors.redColor,
                                fontSize: 16 * scaleFactor,
                              ),
                              SizedBox(height: 10 * scaleFactor),
                              MainText(
                                text: "mountain_resort_reason".tr,

                                fontSize: 13 * scaleFactor,
                                height: 1.5,
                              ),
                              SizedBox(height: 20 * scaleFactor),
                              UseableTextrow(
                                color: AppColors.forwardColor,
                                text: "submitted_at".tr,
                              ),
                              SizedBox(height: 20 * scaleFactor),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20 * scaleFactor),

                    AdminTeamProgress(
                      contentWidth: screenWidth * 0.9,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      verticalSpacing: screenHeight * 0.02,
                    ),
                    SizedBox(height: 20 * scaleFactor),
                    Image.asset(
                      Appimages.timeout3,
                      height: 100 * scaleFactor,
                      width: 100 * scaleFactor,
                    ),
                    BoldText(
                      text: "waiting_for_team".tr,
                      fontSize: 16 * scaleFactor,
                      selectionColor: AppColors.blueColor,
                    ),
                    SizedBox(height: 10 * scaleFactor),

                    Center(
                      child: MainText(
                        height: 1.2,
                        text: "waiting_for_member".tr,
                        fontSize: 14 * scaleFactor,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10 * scaleFactor),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 8 * scaleFactor,
                          width: 8 * scaleFactor,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.forwardColor,
                          ),
                        ),
                        SizedBox(width: 8 * scaleFactor),
                        Container(
                          height: 8 * scaleFactor,
                          width: 8 * scaleFactor,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.forwardColor2,
                          ),
                        ),
                        SizedBox(width: 8 * scaleFactor),
                        Container(
                          height: 8 * scaleFactor,
                          width: 8 * scaleFactor,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.forwardColor3,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20 * scaleFactor),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30 * scaleFactor,
                      ),
                      child: Column(
                        children: [
                          CustomStratgyContainer(
                            fontSize2: ResponsiveFont.getFontSize(),

                            fontSize3: 10,
                            width3: 68 * scaleFactor,
                            iconContainer: AppColors.forwardColor,
                            icon: Icons.check,
                            text1: "phase1_strategy".tr,
                            text2: "Completed • 20 min",
                            text3: "completed".tr,
                            smallContainer: AppColors.forwardColor,
                            largeConatiner: AppColors.forwardColor,
                            flex: 4,
                            flex1: 0,
                          ),
                          SizedBox(height: 10 * scaleFactor),
                          CustomStratgyContainer(
                            fontSize2: ResponsiveFont.getFontSize(),
                            fontSize3: 10,
                            width3: 68 * scaleFactor,
                            iconContainer: AppColors.forwardColor,
                            icon: Icons.check,
                            text1: "phase2_strategy".tr,
                            text2: "Active • 30 min",
                            text3: "completed".tr,
                            smallContainer: AppColors.forwardColor,
                            largeConatiner: AppColors.forwardColor,
                            flex: 4,
                            flex1: 0,
                          ),
                          SizedBox(height: 10 * scaleFactor),
                          CustomStratgyContainer(
                            fontSize2: ResponsiveFont.getFontSize(),
                            fontSize3: 10,
                            width3: 68 * scaleFactor,
                            iconContainer: AppColors.watchColor,
                            icon: Icons.watch_later,
                            text1: "phase3_implementation".tr,
                            text2: "Upcoming • 15 min",
                            text3: "pending".tr,
                            smallContainer: AppColors.watchColor,
                            largeConatiner: AppColors.greyColor,
                            flex: 4,
                            flex1: 0,
                          ),
                          SizedBox(height: 10 * scaleFactor),
                          CustomStratgyContainer(
                            fontSize2: ResponsiveFont.getFontSize(),
                            fontSize3: 10,
                            width3: 68 * scaleFactor,

                            iconContainer: AppColors.watchColor,
                            icon: Icons.watch_later,
                            text1: "phase4_evaluation".tr,
                            text2: "Upcoming • 15 min",
                            text3: "pending".tr,
                            smallContainer: AppColors.watchColor,
                            largeConatiner: AppColors.greyColor,
                            flex: 4,
                            flex1: 0,
                          ),
                          SizedBox(height: 30 * scaleFactor),
                          LoginButton(
                            onTap: () =>
                                Get.toNamed(RouteName.submitResponseScreen2),
                            fontSize: 20,
                            text: "review_ai_score".tr,
                            color: AppColors.forwardColor,
                            ishow: true,
                            image: Appimages.ai2,
                            imageHeight: 32 * scaleFactor,
                            imageWidth: 32 * scaleFactor,
                          ),
                          SizedBox(height: 40 * scaleFactor),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                top: screenHeight * 0.35,
                child: LeaderStackContainer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
