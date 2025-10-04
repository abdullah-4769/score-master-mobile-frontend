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
import 'package:scorer/view/FacilitateFolder/aa.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/custom_sloder_row.dart';
import 'package:scorer/widgets/custom_stratgy_container.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/useable_container.dart';
import 'package:scorer/widgets/useable_textrow.dart';

class SubmitResponseScreen2 extends StatelessWidget {
  const SubmitResponseScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Use a base width to calculate a scaling factor.
    const double baseWidth = 375.0;
    //  final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;

    // A more direct way to get scaling factors
    final double baseHeight = 812.0;
    // final double baseWidth = 414.0;
    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;
    final double scaleFactor = screenWidth / baseWidth;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
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
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SvgPicture.asset(
                      Appimages.Crown,
                      height: 162 * scaleFactor,
                      width: 162 * scaleFactor,
                    ),
                    Positioned(
                      bottom: -10 * scaleFactor,
                      right: -20 * scaleFactor,
                      child: CreateContainer(
                        text: "5 Phases",
                        width: 84 * scaleFactor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30 * scaleFactor),
                BoldText(
                  text: "response_submitted".tr,
                  fontSize: 16 * scaleFactor,
                  selectionColor: AppColors.blueColor,
                ),
                SizedBox(height: 20 * scaleFactor),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30 * scaleFactor),
                  child: PlayerAnalyasis(scaleFactor: scaleFactor),
                ),
                SizedBox(height: 100 * scaleFactor),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30 * scaleFactor),
                  child: Container(
                    height: 215.h,
                    width: 336.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.greyColor,
                        width: 1.7 * scaleFactor,
                      ),
                      borderRadius: BorderRadius.circular(24 * scaleFactor),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 17 * scaleFactor,
                        right: 15 * scaleFactor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20 * scaleFactor),
                          BoldText(
                            text: "scoring_breakdown".tr,
                            selectionColor: AppColors.blueColor,
                            fontSize: 16.sp,
                          ),
                          SizedBox(height: 5 * scaleFactor),
                          CustomSloderRow(
                            // fontSize: (Get.locale?.languageCode == 'fr' || Get.locale?.languageCode == 'es')? 11:14,
                            fontSize: ResponsiveFont.getFontSizeCustom(
                              defaultSize: 14.sp,
                              smallSize: 11.sp,
                            ),
                            text: "clarity_specificity".tr,
                            text2: "22/25",
                          ),
                          SizedBox(height: 5 * scaleFactor),
                          CustomSloderRow(
                            // fontSize: (Get.locale?.languageCode == 'fr' || Get.locale?.languageCode == 'es')? 11:14,
                            fontSize: ResponsiveFont.getFontSizeCustom(
                              defaultSize: 14.sp,
                              smallSize: 11.sp,
                            ),
                            text: "strategic_thinking".tr,
                            text2: "22/25",
                          ),
                          SizedBox(height: 5 * scaleFactor),
                          CustomSloderRow(
                            // fontSize: (Get.locale?.languageCode == 'fr' || Get.locale?.languageCode == 'es')? 11:14,
                            fontSize: ResponsiveFont.getFontSizeCustom(
                              defaultSize: 14.sp,
                              smallSize: 11.sp,
                            ),
                            text: "feasibility".tr,
                            text2: "22/25",
                          ),
                          SizedBox(height: 5 * scaleFactor),
                          CustomSloderRow(
                            // fontSize: (Get.locale?.languageCode == 'fr' || Get.locale?.languageCode == 'es')? 11:14,
                            fontSize: ResponsiveFont.getFontSizeCustom(
                              defaultSize: 14.sp,
                              smallSize: 11.sp,
                            ),
                            text: "innovation".tr,
                            text2: "22/25",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 18 * scaleFactor),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13 * scaleFactor),
                  child: TipsContainer(
                    scaleFactor: scaleFactor,
                    widthScaleFactor: widthScaleFactor,
                  ),
                ),
                SizedBox(height: 18 * scaleFactor),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30 * scaleFactor),
                  child: Column(
                    children: [
                      CustomStratgyContainer(
                        // fontSize2:(Get.locale?.languageCode == 'fr' || Get.locale?.languageCode == 'es')? 10:14,
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
                        // fontSize2:(Get.locale?.languageCode == 'fr' || Get.locale?.languageCode == 'es')? 10:14,
                        fontSize2: ResponsiveFont.getFontSize(),

                        fontSize3: 10,
                        width3: 68 * scaleFactor,
                        iconContainer: AppColors.forwardColor,
                        icon: Icons.check,
                        text1: "phase2_strategy".tr,
                        text2: "Active • 30 min",
                        text3: "Completed",
                        smallContainer: AppColors.forwardColor,
                        largeConatiner: AppColors.forwardColor,
                        flex: 4,
                        flex1: 0,
                      ),
                      SizedBox(height: 10 * scaleFactor),
                      CustomStratgyContainer(
                        fontSize2: ResponsiveFont.getFontSize(),
                        // fontSize2:(Get.locale?.languageCode == 'fr' || Get.locale?.languageCode == 'es')? 10:14,
                        fontSize3: 10,
                        width3: 68 * scaleFactor,
                        iconContainer: AppColors.watchColor,
                        icon: Icons.watch_later,
                        text1: "phase3_implementation".tr,
                        text2: "Upcoming • 15 min",
                        text3: "Pending",
                        smallContainer: AppColors.watchColor,
                        largeConatiner: AppColors.greyColor,
                        flex: 4,
                        flex1: 0,
                      ),
                      SizedBox(height: 10 * scaleFactor),
                      CustomStratgyContainer(
                        // fontSize2:(Get.locale?.languageCode == 'fr' || Get.locale?.languageCode == 'es')? 10:14,
                        fontSize2: ResponsiveFont.getFontSize(),

                        fontSize3: 10,
                        width3: 68 * scaleFactor,
                        iconContainer: AppColors.watchColor,
                        icon: Icons.watch_later,
                        text1: "phase4_evaluation".tr,
                        text2: "Upcoming • 15 min",
                        text3: "Pending",
                        smallContainer: AppColors.watchColor,
                        largeConatiner: AppColors.greyColor,
                        flex: 4,
                        flex1: 0,
                      ),
                      SizedBox(height: 30 * scaleFactor),
                      LoginButton(
                        fontSize: 19.sp,

                        text: "move_to_phase_3".tr,
                        color: AppColors.forwardColor,
                        ishow: true,
                        image: Appimages.submit,
                        imageHeight: 32.h,
                        imageWidth: 32.w,
                      ),
                      SizedBox(height: 10 * scaleFactor),
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
                        // onTap: () => Get.toNamed(RouteName.submitResponseScreen2),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
