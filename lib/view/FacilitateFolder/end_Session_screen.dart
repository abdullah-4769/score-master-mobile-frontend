import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/custom_session_container.dart';
import 'package:scorer/components/custom_time_row.dart';
import 'package:scorer/components/phase_breakdown_container.dart';
import 'package:scorer/components/players_Row.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/players_container.dart';
import 'package:scorer/widgets/useable_container.dart';

import '../../api/api_controllers/analysis_controller.dart';

class EndSessionScreen extends StatelessWidget {
  const EndSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(EndSessionController());

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
          child: Obx(() {
            // Show loading indicator
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.blueColor,
                ),
              );
            }

            // Show error message
            if (controller.hasError.value) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 60, color: Colors.red),
                    SizedBox(height: 16),
                    Text(
                      'Error loading data',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: controller.refreshData,
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: controller.refreshData,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 30 * widthScaleFactor,
                            top: 20 * heightScaleFactor,
                            right: 30 * widthScaleFactor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BoldText(
                                text: "Eranove Odyssey – Team A",
                                selectionColor: AppColors.blueColor,
                                fontSize: 16 * widthScaleFactor,
                              ),
                              UseableContainer(
                                text: "completed".tr,
                                color: AppColors.forwardColor,
                                width: 85.w,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15 * heightScaleFactor),
                          child: Image.asset(
                            Appimages.house1,
                            height: 85 * heightScaleFactor,
                            width: 100 * widthScaleFactor,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30 * widthScaleFactor,
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 74 * heightScaleFactor,
                            width: 337 * widthScaleFactor,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.greyColor,
                                width: 1.7 * widthScaleFactor,
                              ),
                              borderRadius: BorderRadius.circular(
                                24 * widthScaleFactor,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 17 * widthScaleFactor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  BoldText(text: "export_by".tr, fontSize: 20.sp),
                                  Row(
                                    children: [
                                      BoldText(text: "phase".tr, fontSize: 20.sp),
                                      SizedBox(width: 7 * widthScaleFactor),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: AppColors.forwardColor,
                                        size: 24 * widthScaleFactor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 13 * heightScaleFactor),
                          LoginButton(
                            fontSize: 20.sp,
                            text: "export_pdf".tr,
                            ishow: true,
                            image: Appimages.export,
                            color: AppColors.selectLangugaeColor,
                          ),
                          SizedBox(height: 20 * heightScaleFactor),
                          SvgPicture.asset(
                            Appimages.Crown,
                            height: 60 * heightScaleFactor,
                            width: 60 * widthScaleFactor,
                          ),
                          SizedBox(height: 21 * heightScaleFactor),
                          BoldText(
                            text: "Eranove Odyssey – Team A",
                            fontSize: 16 * widthScaleFactor,
                            selectionColor: AppColors.blueColor,
                          ),
                          SizedBox(height: 5 * heightScaleFactor),
                          MainText(
                            text: "session_completed".tr,
                            fontSize: 14 * widthScaleFactor,
                          ),
                          SizedBox(height: 21 * heightScaleFactor),

                          // Session Overview - Dynamic Data
                          _buildSessionOverview(
                            controller,
                            heightScaleFactor,
                            widthScaleFactor,
                          ),

                          SizedBox(height: 33 * heightScaleFactor),
                          SvgPicture.asset(
                            Appimages.tropy,
                            height: 60 * heightScaleFactor,
                            width: 60 * widthScaleFactor,
                          ),
                          SizedBox(height: 20 * heightScaleFactor),
                          MainText(
                            text: "rewards_unlocked".tr,
                            fontSize: 16 * widthScaleFactor,
                            fontFamily: "gotham",
                          ),
                          SizedBox(height: 16 * heightScaleFactor),

                          // Badges - Dynamic Data
                          if (controller.badges != null && controller.badges!.isNotEmpty)
                            ...controller.badges!.map((badge) => Column(
                              children: [
                                BoldText(
                                  text: badge,
                                  fontSize: 16 * widthScaleFactor,
                                  selectionColor: AppColors.blueColor,
                                ),
                                SizedBox(height: 12 * heightScaleFactor),
                              ],
                            )).toList(),

                          Image.asset(
                            Appimages.badge,
                            height: 147 * heightScaleFactor,
                            width: 158 * widthScaleFactor,
                          ),
                          SizedBox(height: 10 * heightScaleFactor),
                          BoldText(
                            text: "badge".tr,
                            fontSize: 16 * widthScaleFactor,
                            selectionColor: AppColors.blueColor,
                          ),
                          SizedBox(height: 30 * heightScaleFactor),

                          // Session Stats - Dynamic Data
                          _buildSessionStats(
                            controller,
                            heightScaleFactor,
                            widthScaleFactor,
                          ),

                          SizedBox(height: 100 * heightScaleFactor),
                          PlayersRow(isTeamSelected: false),
                          SizedBox(height: 25 * heightScaleFactor),

                          // Player Rankings - Dynamic Data
                          _buildPlayerRankings(
                            controller,
                            heightScaleFactor,
                            widthScaleFactor,
                          ),

                          SizedBox(height: 30 * heightScaleFactor),
                          CreateContainer(
                            fontsize2: ResponsiveFont.getFontSizeCustom(
                              defaultSize: 13 * widthScaleFactor,
                              smallSize: 9 * widthScaleFactor,
                            ),
                            text: "view_full_ranking".tr,
                            width: 148 * widthScaleFactor,
                          ),
                          SizedBox(height: 20 * heightScaleFactor),

                          // Phase Breakdown - Dynamic Data
                          _buildPhaseBreakdown(
                            controller,
                            widthScaleFactor,
                            heightScaleFactor,
                          ),

                          SizedBox(height: 41 * heightScaleFactor),
                          LoginButton(
                            onTap: () {
                              Get.toNamed(RouteName.createNewSessionScreen);
                            },
                            text: "create_new_session".tr,
                            ishow: true,
                            fontSize: 19.sp,
                            color: AppColors.redColor,
                            icon: Icons.add,
                            imageHeight: 35.h,
                            imageWidth: 35.w,
                          ),
                          SizedBox(height: 13 * heightScaleFactor),
                          LoginButton(
                            fontSize: 19.sp,
                            text: "share_results".tr,
                            color: AppColors.forwardColor,
                            image: Appimages.move,
                            ishow: true,
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // Build Session Overview Widget
  Widget _buildSessionOverview(
      EndSessionController controller,
      double heightScaleFactor,
      double widthScaleFactor,
      ) {
    final overview = controller.sessionOverview;
    if (overview == null) return SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 80,
          width: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Color(0xffDFDFDF))
          ),
          child: Center(
            child: _buildStatItem(
              "${controller.formatDuration(overview.timeDuration)}",
              "Duration",
              widthScaleFactor,
            ),
          ),
        ),
        Container(
          height: 80,
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Color(0xffDFDFDF))
          ),
          child: Center(
            child: _buildStatItem(
              "${overview.activePlayers ?? 0}",
              "Players",
              widthScaleFactor,
            ),
          ),
        ),
        Container(
          height: 80,
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Color(0xffDFDFDF))
          ),
          child: Center(
            child: _buildStatItem(
              "${overview.totalPhases ?? 0}",
              "Phases",
              widthScaleFactor,
            ),
          ),
        ),

      ],
    );
  }

  Widget _buildStatItem(String value, String label, double scale) {
    return Column(
      children: [
        BoldText(
          text: value,
          fontSize: 20 * scale,
          selectionColor: AppColors.blueColor,
        ),
        SizedBox(height: 4),
        MainText(
          text: label,
          fontSize: 12 * scale,
        ),
      ],
    );
  }

  // Build Session Stats Widget
  Widget _buildSessionStats(
      EndSessionController controller,
      double heightScaleFactor,
      double widthScaleFactor,
      ) {
    final stats = controller.sessionStats;
    if (stats == null) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(20 * widthScaleFactor),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyColor),
        borderRadius: BorderRadius.circular(24 * widthScaleFactor),
      ),
      child: Column(
        children: [
          BoldText(
            text: "Session Statistics",
            fontSize: 16 * widthScaleFactor,
            selectionColor: AppColors.blueColor,
          ),
          SizedBox(height: 16 * heightScaleFactor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatColumn(
                "Avg Score",
                "${stats.averageScore ?? 0}",
                widthScaleFactor,
              ),
              _buildStatColumn(
                "Completion",
                "${stats.completionRate ?? 0}%",
                widthScaleFactor,
              ),
            ],
          ),
          if (stats.topPerformer != null) ...[
            SizedBox(height: 16 * heightScaleFactor),
            Divider(color: AppColors.greyColor),
            SizedBox(height: 8 * heightScaleFactor),
            MainText(
              text: "Top Performer",
              fontSize: 12 * widthScaleFactor,
            ),
            SizedBox(height: 4),
            BoldText(
              text: "${stats.topPerformer!.name}",
              fontSize: 16 * widthScaleFactor,
              selectionColor: AppColors.blueColor,
            ),
            MainText(
              text: "${stats.topPerformer!.points} pts",
              fontSize: 14 * widthScaleFactor,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value, double scale) {
    return Column(
      children: [
        MainText(text: label, fontSize: 12 * scale),
        SizedBox(height: 4),
        BoldText(
          text: value,
          fontSize: 18 * scale,
          selectionColor: AppColors.blueColor,
        ),
      ],
    );
  }

  // Build Player Rankings Widget
  Widget _buildPlayerRankings(
      EndSessionController controller,
      double heightScaleFactor,
      double widthScaleFactor,
      ) {
    final rankings = controller.playerRanking;
    if (rankings == null || rankings.isEmpty) return SizedBox.shrink();

    // Define colors for top 3
    final rankColors = [
      AppColors.yellowColor,   // 1st
      AppColors.greyColor,     // 2nd
      AppColors.orangeColor,   // 3rd
    ];

    final rankIcons = [
      Icons.keyboard_arrow_up_outlined,
      Icons.keyboard_arrow_down_outlined,
      Icons.keyboard_arrow_down_outlined,
    ];

    final iconColors = [
      AppColors.arrowColor,
      AppColors.brownColor,
      AppColors.brownColor,
    ];

    return Column(
      children: rankings.take(3).toList().asMap().entries.map((entry) {
        final index = entry.key;
        final player = entry.value;

        return Padding(
          padding: EdgeInsets.only(bottom: 10 * heightScaleFactor),
          child: PlayersContainers(
            text1: "${player.rank}",
            text2: player.playerName ?? "Unknown",
            image: Appimages.facil2, // You can map different images per player
            icon: rankIcons[index % 3],
            iconColor: iconColors[index % 3],
            text4: "${player.totalPoints} pts",
            ishow: true,
            containerColor: rankColors[index % 3],
            leftPadding: 20 * widthScaleFactor,
          ),
        );
      }).toList(),
    );
  }

  // Build Phase Breakdown Widget
  Widget _buildPhaseBreakdown(
      EndSessionController controller,
      double widthScaleFactor,
      double heightScaleFactor,
      ) {
    final phases = controller.phasesBreakdown;
    if (phases == null || phases.isEmpty) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(20 * widthScaleFactor),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyColor),
        borderRadius: BorderRadius.circular(24 * widthScaleFactor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BoldText(
            text: "Phase Breakdown",
            fontSize: 16 * widthScaleFactor,
            selectionColor: AppColors.blueColor,
          ),
          SizedBox(height: 16 * heightScaleFactor),
          ...phases.map((phase) => Padding(
            padding: EdgeInsets.only(bottom: 12 * heightScaleFactor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoldText(
                      text: phase.phaseName ?? "Phase",
                      fontSize: 14 * widthScaleFactor,
                      selectionColor: AppColors.blueColor,
                    ),
                    MainText(
                      text: controller.formatDuration(phase.timeDuration),
                      fontSize: 12 * widthScaleFactor,
                    ),
                  ],
                ),
                BoldText(
                  text: "${phase.totalPoints} pts",
                  fontSize: 14 * widthScaleFactor,
                  selectionColor: AppColors.forwardColor,
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }
}