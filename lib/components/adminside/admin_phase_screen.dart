import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:scorer/components/adminside/admin_Session_container.dart';
import 'package:scorer/components/adminside/admin_realtime_monitoring_container.dart';
import 'package:scorer/components/adminside/admin_team_progress.dart';
import 'package:scorer/components/phases_container.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/components/stages_row.dart';
import 'package:scorer/components/team_Alpha_Container.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/controllers/stage_controllers.dart';
import 'package:scorer/view/FacilitateFolder/view_responses_Screen.dart';
import 'package:scorer/view/playerfolder/submit_response_Screen2.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/custom_stratgy_container.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/pause_container.dart';
import 'package:scorer/widgets/useable_textrow.dart';
import '../../api/api_controllers/add_phase_controller.dart';
import '../../api/api_controllers/game_format_phase.dart';

class AdminPhaseScreen extends StatelessWidget {
  final StageController controller = Get.put(StageController());
  final AddPhaseController addPhaseController = Get.put(AddPhaseController());
  final GameFormatPhaseController gameFormatController = Get.put(GameFormatPhaseController());

  AdminPhaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalSpacing = screenHeight * 0.02;
    final horizontalPadding = screenWidth * 0.05;
    final contentWidth = screenWidth * 0.9;
    const double baseWidth = 414.0;
    final double widthScaleFactor = screenWidth / baseWidth;

    return Stack(
      children: [
        Obx(() {
          if (gameFormatController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (gameFormatController.errorMessage.value.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(gameFormatController.errorMessage.value),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => gameFormatController.refreshPhases(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => gameFormatController.refreshPhases(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: verticalSpacing * 2),
                  CreateContainer(
                    text: "current_phase".tr,
                    width: screenWidth * 0.3,
                  ),
                  SizedBox(height: verticalSpacing),

                  // Current Phase Timer
                  Obx(() {
                    final currentPhase = gameFormatController.currentPhase;
                    final timeRemaining = currentPhase != null
                        ? gameFormatController.getRemainingTime(currentPhase.timeDuration ?? 0)
                        : "00:00";
                    final percent = currentPhase != null && currentPhase.timeDuration != null
                        ? (gameFormatController.remainingSeconds.value / (currentPhase.timeDuration! * 60)).clamp(0.0, 1.0)
                        : 0.0;

                    return Center(
                      child: CircularPercentIndicator(
                        radius: ResponsiveFont.getFontSizeCustom(
                          defaultSize: 60 * widthScaleFactor,
                          smallSize: 55 * widthScaleFactor,
                        ),
                        lineWidth: 5.0,
                        percent: percent,
                        animation: true,
                        animationDuration: 1000,
                        animateFromLastPercent: true,
                        circularStrokeCap: CircularStrokeCap.round,
                        backgroundColor: Colors.transparent,
                        progressColor: AppColors.forwardColor,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BoldText(
                              text: timeRemaining,
                              fontSize: ResponsiveFont.getFontSizeCustom(
                                defaultSize: 20,
                                smallSize: 18,
                              ),
                              selectionColor: AppColors.blueColor,
                            ),
                            MainText(
                              text: "remaining".tr,
                              fontSize: ResponsiveFont.getFontSizeCustom(
                                defaultSize: 14,
                                smallSize: 12,
                              ),
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: verticalSpacing),

                  PhaseContainer(
                    horizontalPadding: horizontalPadding,
                    contentWidth: contentWidth,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  ),
                  Icon(
                    Icons.arrow_downward_sharp,
                    color: AppColors.forwardColor,
                    size: screenWidth * 0.08,
                  ),
                  SizedBox(height: verticalSpacing),

                  StagesRow(),
                  SizedBox(height: verticalSpacing),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: screenHeight * 0.008,
                                width: contentWidth * 0.5,
                                decoration: BoxDecoration(
                                  color: AppColors.selectLangugaeColor,
                                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                                ),
                              ),
                            ),
                            Container(
                              height: screenHeight * 0.008,
                              width: contentWidth * 0.4,
                              decoration: BoxDecoration(
                                color: AppColors.greyColor,
                                borderRadius: BorderRadius.circular(screenWidth * 0.05),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Obx(() {
                          final currentPhase = gameFormatController.currentPhase;
                          final timeRemaining = currentPhase != null
                              ? gameFormatController.getRemainingTime(currentPhase.timeDuration ?? 0)
                              : "00:00";

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BoldText(
                                text: timeRemaining,
                                fontSize: screenWidth * 0.06,
                                selectionColor: AppColors.blueColor,
                              ),
                              MainText(
                                text: "remaining".tr,
                                fontSize: screenWidth * 0.04,
                              ),
                            ],
                          );
                        }),

                        SizedBox(height: verticalSpacing),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: PauseContainer(
                                onTap: () => gameFormatController.previousPhase(),
                                text: "back".tr,
                              ),
                            ),
                            SizedBox(width: horizontalPadding),
                            Expanded(
                              child: PauseContainer(
                                onTap: () => gameFormatController.nextPhase(),
                                text: "next_stage".tr,
                                icon: Icons.fast_forward,
                                color: AppColors.assignColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: verticalSpacing),

                        AdminTeamProgress(
                          contentWidth: contentWidth,
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          verticalSpacing: verticalSpacing,
                        ),
                        SizedBox(height: verticalSpacing),

                        AdminRealtimeMonitoringContainer(
                          contentWidth: contentWidth,
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          verticalSpacing: verticalSpacing,
                        ),
                        SizedBox(height: verticalSpacing),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BoldText(
                              text: "all_phases".tr,
                              fontSize: 16,
                              selectionColor: AppColors.blueColor,
                            ),
                            Obx(() => BoldText(
                              text: "${gameFormatController.totalPhasesCount} Phases",
                              fontSize: 14,
                              selectionColor: AppColors.greyColor,
                            )),
                          ],
                        ),
                        SizedBox(height: 25),

                        // Dynamic Phases List
                        Obx(() {
                          final phases = gameFormatController.allPhases;

                          if (phases.isEmpty) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Text("No phases available"),
                              ),
                            );
                          }

                          return Column(
                            children: phases.asMap().entries.map((entry) {
                              final index = entry.key;
                              final phase = entry.value;

                              return Column(
                                children: [
                                  CustomStratgyContainer(
                                    fontSize2: ResponsiveFont.getFontSize(),
                                    width3: 80,
                                    iconContainer: gameFormatController.getPhaseStatusColor(index),
                                    icon: gameFormatController.getPhaseStatusIcon(index),
                                    text1: phase.name ?? "Phase ${phase.order}",
                                    text2: "${phase.description ?? ''} • ${phase.timeDuration} min",
                                    text3: gameFormatController.getPhaseStatus(index),
                                    smallContainer: gameFormatController.getPhaseStatusColor(index),
                                    largeConatiner: index <= gameFormatController.currentPhaseIndex.value
                                        ? gameFormatController.getPhaseStatusColor(index)
                                        : AppColors.greyColor,
                                    flex: index > gameFormatController.currentPhaseIndex.value ? 4 : 3,
                                    flex1: 0,
                                  ),
                                  if (index < phases.length - 1) const SizedBox(height: 10),
                                ],
                              );
                            }).toList(),
                          );
                        }),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Session Timeline
                  Obx(() {
                    final totalDuration = gameFormatController.totalTimeDuration;
                    final elapsedSeconds = gameFormatController.allPhases
                        .asMap()
                        .entries
                        .where((entry) => entry.key < gameFormatController.currentPhaseIndex.value)
                        .fold(0, (sum, entry) => sum + (entry.value.timeDuration ?? 0) * 60) +
                        (gameFormatController.currentPhase?.timeDuration ?? 0) * 60 -
                        gameFormatController.remainingSeconds.value;
                    final progress = totalDuration > 0 ? (elapsedSeconds / (totalDuration * 60)).clamp(0.0, 1.0) : 0.0;
                    final sessionStart = DateTime.now().subtract(Duration(seconds: elapsedSeconds));
                    final currentTime = DateTime.now();
                    final estimatedEnd = sessionStart.add(Duration(minutes: totalDuration));

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: Container(
                        width: contentWidth,
                        height: screenHeight * 0.31,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.greyColor,
                            width: 1.5 * widthScaleFactor,
                          ),
                          borderRadius: BorderRadius.circular(24 * widthScaleFactor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20 * widthScaleFactor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 31 * (screenHeight / 812.0)),
                              BoldText(
                                text: "Session Timeline",
                                fontSize: 16 * widthScaleFactor,
                                selectionColor: AppColors.blueColor,
                              ),
                              SizedBox(height: 20 * (screenHeight / 812.0)),
                              UseableTextrow(
                                color: AppColors.forwardColor,
                                text: "Session Start: ${sessionStart.hour}:${sessionStart.minute.toString().padLeft(2, '0')} ${sessionStart.hour >= 12 ? 'PM' : 'AM'}",
                              ),
                              UseableTextrow(
                                color: AppColors.forwardColor2,
                                text: "Current Time: ${currentTime.hour}:${currentTime.minute.toString().padLeft(2, '0')} ${currentTime.hour >= 12 ? 'PM' : 'AM'}",
                              ),
                              UseableTextrow(
                                color: AppColors.forwardColor3,
                                text: "Estimated End: ${estimatedEnd.hour}:${estimatedEnd.minute.toString().padLeft(2, '0')} ${estimatedEnd.hour >= 12 ? 'PM' : 'AM'}",
                              ),
                              SizedBox(height: 20 * (screenHeight / 812.0)),
                              Row(
                                children: [
                                  Expanded(
                                    flex: (progress * 10).round().clamp(1, 10),
                                    child: Container(
                                      height: 5 * (screenHeight / 812.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20 * widthScaleFactor),
                                        color: AppColors.forwardColor,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: ((1 - progress) * 10).round().clamp(1, 10),
                                    child: Container(
                                      height: 5 * (screenHeight / 812.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20 * widthScaleFactor),
                                        color: AppColors.greyColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10 * (screenHeight / 812.0)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MainText(
                                    text: "${(progress * 100).toStringAsFixed(0)}% Complete",
                                    fontSize: screenWidth * 0.035,
                                  ),
                                  BoldText(
                                    text: "${((totalDuration * 60 - elapsedSeconds) / 60).toStringAsFixed(0)} minutes remaining",
                                    fontSize: screenWidth * 0.035,
                                    selectionColor: AppColors.blueColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),

                  SizedBox(height: verticalSpacing),

                  Center(
                    child: LoginButton(
                      fontSize: 20,
                      text: "view_responses".tr,
                      color: AppColors.forwardColor,
                      ishow: true,
                      image: Appimages.eye,
                      onTap: () {
                        try {
                          Get.to(ViewResponsesScreen());
                          // Get.toNamed('/responses');
                        } catch (e) {
                          Get.snackbar(
                            'Error',
                            'Responses screen not found. Please check route configuration.',
                            snackPosition: SnackPosition.TOP,
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: verticalSpacing * 2),
                ],
              ),
            ),
          );
        }),

        Positioned(
          right: 0,
          top: screenHeight * 0.2,
          child: TeamAlphaContainer(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ),
      ],
    );
  }
}