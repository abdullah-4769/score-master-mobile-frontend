// lib/view/FacilitateFolder/view_responses_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/components/team_Alpha_Container.dart';
import 'package:scorer/components/view_response_stack_container.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/controllers/stage_controllers.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/custom_response_container.dart';
import 'package:scorer/widgets/custom_stratgy_container.dart';
import '../../api/api_controllers/view_response_controller.dart';

class ViewResponsesScreen extends StatelessWidget {
  final StageController stageController = Get.put(StageController());
  final ViewResponsesController responsesController = Get.put(ViewResponsesController());

  ViewResponsesScreen({super.key});

  final List<String> tabs = ["all".tr, "pending".tr, "scored".tr];

  @override
  Widget build(BuildContext context) {
    bool isSpanish = Get.locale?.languageCode == 'es';

    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    const double baseHeight = 812.0;
    const double baseWidth = 414.0;
    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Header: Back button + Title
                      SizedBox(
                        height: 50.h,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                onTap: () => Get.back(),
                                child: SvgPicture.asset(
                                  Appimages.arrowback,
                                  colorFilter: const ColorFilter.mode(
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
                                text: "stage2_responses".tr,
                                fontSize: ResponsiveFont.getFontSizeCustom(
                                  defaultSize: 22 * widthScaleFactor,
                                  smallSize: 20 * widthScaleFactor,
                                ),
                                selectionColor: AppColors.blueColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 27.h),

                      // Primary Objective Strategy Container
                      CustomStratgyContainer(
                        isshow: true,
                        mainHeight: 1.3,
                        fontSize: ResponsiveFont.getFontSizeCustom(
                          defaultSize: 14 * widthScaleFactor,
                          smallSize: 12 * widthScaleFactor,
                        ),
                        containerHeight: 180.h,
                        width3: 54.w,
                        spaceHeight2: 20.h,
                        spaceHeight: 14.h,
                        extra: "primary_objective".tr,
                        width1: 150.w,
                        width2: 126.w,
                        iconContainer: AppColors.selectLangugaeColor,
                        icon: Icons.play_arrow_rounded,
                        text1: "phase2_strategy".tr,
                        fontSize2: ResponsiveFont.getFontSizeCustom(
                          defaultSize: 14 * widthScaleFactor,
                          smallSize: 10 * widthScaleFactor,
                        ),
                        text2: 'Completed • 20 min',
                        text3: 'active'.tr,
                        smallContainer: AppColors.selectLangugaeColor,
                        largeConatiner: AppColors.selectLangugaeColor,
                      ),

                      SizedBox(height: 31.h),
                      CreateContainer(text: "stage2_scoring".tr, width: 134.w),
                      SizedBox(height: 31.h),

                      // Dynamic Scored/Pending Counts Row
                      Obx(() => Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 51.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.greyColor,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BoldText(
                                    text: "${responsesController.scoredCount}",
                                    selectionColor: AppColors.redColor,
                                    fontSize: 24.sp,
                                  ),
                                  SizedBox(width: 11.w),
                                  BoldText(
                                    text: "scored".tr,
                                    selectionColor: AppColors.blueColor,
                                    fontSize: 16.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: Container(
                              height: 51.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.greyColor,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BoldText(
                                    text: "${responsesController.pendingCount}",
                                    selectionColor: AppColors.redColor,
                                    fontSize: 24.sp,
                                  ),
                                  SizedBox(width: 11.w),
                                  BoldText(
                                    text: "pending".tr,
                                    selectionColor: AppColors.blueColor,
                                    fontSize: 16.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),

                      SizedBox(height: 20.h),

                      // Tab Selector
                      Obx(() {
                        double totalWidth = screenWidth - 60.w;
                        double tabWidth = totalWidth / tabs.length;
                        double left = stageController.selectedIndex.value * tabWidth;
                        return ViewResponseStackContainer(
                          totalWidth: totalWidth,
                          left: left,
                          tabWidth: tabWidth,
                          tabs: tabs,
                          controller: stageController,
                        );
                      }),

                      SizedBox(height: 13.h),

                      // Dynamic Responses List
                      Obx(() {
                        if (responsesController.isLoading.value) {
                          return SizedBox(
                            height: 200.h,
                            child: const Center(child: CircularProgressIndicator()),
                          );
                        } else if (responsesController.errorMessage.value.isNotEmpty) {
                          return SizedBox(
                            height: 100.h,
                            child: Center(
                              child: Column(
                                children: [
                                  Text(responsesController.errorMessage.value),
                                  ElevatedButton(
                                    onPressed: responsesController.fetchResponses,
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        final filteredResponses = responsesController.filteredResponses;
                        if (filteredResponses.isEmpty) {
                          return SizedBox(
                            height: 200.h,
                            child: Center(
                              child: Text(
                                stageController.selectedIndex.value == 0
                                    ? "no_responses".tr
                                    : stageController.selectedIndex.value == 1
                                    ? "no_pending_responses".tr
                                    : "no_scored_responses".tr,
                              ),
                            ),
                          );
                        }
                        return SizedBox(
                          height: 400.h,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredResponses.length,
                            separatorBuilder: (context, index) => SizedBox(height: 13.h),
                            itemBuilder: (context, index) {
                              final response = filteredResponses[index];
                              final isScored = response.score != null;
                              final color1 = isScored ? AppColors.forwardColor : AppColors.greyColor;
                              final textColor = isScored ? AppColors.whiteColor : null;

                              return CustomResponseContainer(
                                color1: color1,
                                textColor: textColor,
                                text: isScored ? "scored".tr : "pending".tr,
                                ishow: true,
                                ishow1: true,
                                playerName: response.player.name,
                                questionText: response.question.text,
                                answer: response.answerData.sequence.join(', '),
                                score: response.score,
                                isScored: isScored,
                                onEvaluateTap: () => Get.toNamed(
                                    RouteName.evaluateResponseScreen2,
                                    arguments: response),
                                onViewScoreTap: () => Get.toNamed(
                                    RouteName.viewScoreScreen,
                                    arguments: response),
                                showEvaluate: !isScored,
                                showViewScore: isScored,
                                text1: isScored ? "view_score".tr : "evaluate".tr,
                                image: isScored ? Appimages.eye : Appimages.star,
                              );
                            },
                          ),
                        );
                      }),

                      SizedBox(height: 30.h),

                      // All Phases Section
                      BoldText(
                        text: "all_phases".tr,
                        fontSize: 16.sp,
                        selectionColor: AppColors.blueColor,
                      ),
                      CustomStratgyContainer(
                        spaceHeight2: 20.h,
                        spaceHeight: 14.h,
                        fontSize2: ResponsiveFont.getFontSizeCustom(
                          defaultSize: 14 * widthScaleFactor,
                          smallSize: 10 * widthScaleFactor,
                        ),
                        iconContainer: AppColors.forwardColor,
                        icon: Icons.check,
                        width1: 277.w,
                        text1: "phase1_strategy".tr,
                        text2: "Completed • 20 min",
                        text3: "completed".tr,
                        smallContainer: AppColors.forwardColor,
                        largeConatiner: AppColors.forwardColor2,
                        fontSize3: 10.sp,
                        width3: 70.w,
                      ),
                      SizedBox(height: 10.h),
                      CustomStratgyContainer(
                        mainHeight: 1.3,
                        fontSize: 14.sp,
                        fontSize3: 10.sp,
                        width3: 70.w,
                        spaceHeight2: 20.h,
                        spaceHeight: 14.h,
                        width1: 207.w,
                        width2: 70.w,
                        fontSize2: ResponsiveFont.getFontSizeCustom(
                          defaultSize: 14 * widthScaleFactor,
                          smallSize: 9 * widthScaleFactor,
                        ),
                        iconContainer: AppColors.selectLangugaeColor,
                        icon: Icons.play_arrow_rounded,
                        text1: "phase2_strategy".tr,
                        text2: "Active • 30 min",
                        text3: "active".tr,
                        smallContainer: AppColors.selectLangugaeColor,
                        largeConatiner: AppColors.selectLangugaeColor,
                      ),
                      SizedBox(height: 10.h),
                      CustomStratgyContainer(
                        fontSize3: 10.sp,
                        width3: 70.w,
                        spaceHeight2: 20.h,
                        spaceHeight: 14.h,
                        width1: 207.w,
                        width2: 70.w,
                        iconContainer: AppColors.watchColor,
                        fontSize2: ResponsiveFont.getFontSizeCustom(
                          defaultSize: 14 * widthScaleFactor,
                          smallSize: 10 * widthScaleFactor,
                        ),
                        icon: Icons.watch_later,
                        text1: "phase3_implementation".tr,
                        text2: "Upcoming • 25 min",
                        text3: "pending".tr,
                        smallContainer: AppColors.watchColor,
                        largeConatiner: AppColors.greyColor,
                      ),
                      SizedBox(height: 10.h),
                      CustomStratgyContainer(
                        fontSize3: 10.sp,
                        width3: 70.w,
                        spaceHeight2: 20.h,
                        spaceHeight: 14.h,
                        width1: 207.w,
                        width2: 70.w,
                        iconContainer: AppColors.watchColor,
                        fontSize2: ResponsiveFont.getFontSizeCustom(
                          defaultSize: 14 * widthScaleFactor,
                          smallSize: 10 * widthScaleFactor,
                        ),
                        icon: Icons.watch_later,
                        text1: "phase4_evaluation".tr,
                        text2: "Upcoming • 15 min",
                        text3: "pending".tr,
                        smallContainer: AppColors.watchColor,
                        largeConatiner: AppColors.greyColor,
                      ),
                      SizedBox(height: 25.h),
                    ],
                  ),
                ),
              ),

              // Positioned TeamAlphaContainer
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