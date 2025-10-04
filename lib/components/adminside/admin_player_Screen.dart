import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/team_Alpha_Container.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/all_players_container.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/useable_textrow.dart';

import '../../api/api_controllers/players_controller.dart';

class AdminPlayerScreen extends StatelessWidget {
  const AdminPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminPlayerController controller = Get.put(AdminPlayerController());
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final activeInactiveBoxWidth = screenWidth * 0.28;
    final activeInactiveBoxHeight = screenHeight * 0.14;
    final topBoxSpacing = screenWidth * 0.03;
    final topPadding = screenWidth * 0.08;
    final verticalSpacing = screenHeight * 0.03;
    final sectionPadding = screenWidth * 0.08;
    final allPlayersContainerSpacing = screenHeight * 0.01;
    final teamDistributionBoxWidth = screenWidth * 0.9;
    final teamDistributionBoxHeight = screenHeight * 0.25; // Adjust height if more teams
    final buttonHeight = screenHeight * 0.06;

    return Stack(
      children: [
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.errorMessage.value.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          } else if (controller.teams.isEmpty) {
            return const Center(child: Text('No teams or players found.'));
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Top row: Active/Inactive boxes (now dynamic)
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.05,
                      right: topPadding,
                      left: topPadding * 0.4,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          Appimages.group,
                          width: screenWidth * 0.3,
                        ),
                        SizedBox(width: topBoxSpacing),
                        Expanded(
                          child: Container(
                            height: activeInactiveBoxHeight,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.greyColor, width: 1.7),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BoldText(
                                  text: "${controller.activePlayersCount.value}",
                                  selectionColor: AppColors.forwardColor,
                                  fontSize: screenWidth * 0.06,
                                ),
                                BoldText(
                                  textAlign: TextAlign.center,
                                  text: "active".tr,
                                  fontSize: screenWidth * 0.04,
                                  selectionColor: AppColors.blueColor,
                                ),
                                BoldText(
                                  textAlign: TextAlign.center,
                                  text: "players".tr,
                                  fontSize: screenWidth * 0.04,
                                  selectionColor: AppColors.blueColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: topBoxSpacing),
                        Expanded(
                          child: Container(
                            height: activeInactiveBoxHeight,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.greyColor, width: 1.7),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BoldText(
                                  text: "${controller.inactivePlayersCount.value}",
                                  selectionColor: AppColors.redColor,
                                  fontSize: screenWidth * 0.06,
                                ),
                                BoldText(
                                  textAlign: TextAlign.center,
                                  text: "inactive_players".tr,
                                  fontSize: screenWidth * 0.04,
                                  selectionColor: AppColors.blueColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: verticalSpacing),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sectionPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header: All Players + Filter
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BoldText(
                              text: "all_players".tr,
                              fontSize: screenWidth * 0.04,
                              selectionColor: AppColors.blueColor,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(Appimages.filter),
                                SizedBox(width: screenWidth * 0.015),
                                BoldText(
                                  text: "filter".tr,
                                  fontSize: screenWidth * 0.04,
                                  selectionColor: AppColors.blueColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: allPlayersContainerSpacing),

                        // Dynamic List: Render ALL teams (12 in your data)
                        // Each team shows: AllPlayersContainer (creator as "player") + CreateContainer (team nickname)
                        SizedBox(
                          height: screenHeight * 0.6, // Adjust height for scrollable list
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(), // Let parent SingleChildScrollView handle scrolling
                            itemCount: controller.teams.length,
                            separatorBuilder: (context, index) => SizedBox(height: allPlayersContainerSpacing * 2),
                            itemBuilder: (context, index) {
                              final team = controller.teams[index];
                              // Cycle colors for variety (or make dynamic based on teamId)
                              Color borderColor = _getColorForIndex(index);
                              Color textColor = borderColor;
                              Color containerColor = borderColor.withOpacity(0.1);

                              return Column(
                                children: [
                                  AllPlayersContainer(
                                    text: team.createdBy.name,
                                    text2: "Joined ${DateTime.parse(team.createdAt).toString().substring(11, 16)}",
                                    image: _getImageForIndex(index), // Cycle images
                                  ),
                                  SizedBox(height: allPlayersContainerSpacing),
                                  // Team Container
                                  Align(
                                    alignment:Alignment.centerLeft,
                                    child: CreateContainer(
                                      right: screenWidth * 0.08,
                                      width: screenWidth * 0.25,
                                      text: team.nickname,
                                      textColor: textColor,
                                      borderColor: borderColor,
                                      containerColor: containerColor,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                        // Team Distribution Box (now shows ALL teams dynamically)
                        SizedBox(height: allPlayersContainerSpacing * 2),
                        Container(
                          width: screenWidth * 0.9,
                          height: teamDistributionBoxHeight * (controller.teams.length > 3 ? 1.5 : 1), // Expand height if many teams
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.greyColor, width: 1.7),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenHeight * 0.02,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BoldText(
                                  text: "team_distribution".tr,
                                  selectionColor: AppColors.blueColor,
                                  fontSize: screenWidth * 0.04,
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                // Dynamic list of all teams
                                Expanded(
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: controller.teams.length,
                                    separatorBuilder: (context, index) => SizedBox(height: screenHeight * 0.01),
                                    itemBuilder: (context, index) {
                                      final team = controller.teams[index];
                                      return UseableTextrow(
                                        color: _getColorForIndex(index),
                                        text: team.nickname,
                                        text1: "${team.players.length} Players", // 0 for now
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: verticalSpacing),

                        // Buttons (unchanged)
                        LoginButton(
                          fontSize: 20,
                          text: "add_player".tr,
                          image: Appimages.personadd,
                          ishow: true,
                        ),
                        SizedBox(height: allPlayersContainerSpacing),
                        LoginButton(
                          fontSize: 20,
                          text: "view_responses".tr,
                          image: Appimages.eye,
                          color: AppColors.forwardColor,
                          ishow: true,
                        ),
                        SizedBox(height: allPlayersContainerSpacing),
                        LoginButton(
                          fontSize: 20,
                          text: "send_alert".tr,
                          image: Appimages.noti,
                          color: AppColors.redColor,
                          ishow: true,
                        ),
                        SizedBox(height: allPlayersContainerSpacing),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        }),
        // Positioned TeamAlphaContainer (unchanged)
        Positioned(
          right: 0,
          top: screenHeight * 0.2,
          child: TeamAlphaContainer(screenWidth: screenWidth, screenHeight: screenHeight),
        ),
      ],
    );
  }

  // Helper: Cycle colors for visual variety (adjust as needed)
  Color _getColorForIndex(int index) {
    final colors = [
      AppColors.forwardColor,
      AppColors.purpleColor,
      AppColors.orangeColor,
      AppColors.forwardColor2,
      AppColors.forwardColor3,
    ];
    return colors[index % colors.length];
  }

  // Helper: Cycle images for players (adjust paths as needed)
  String _getImageForIndex(int index) {
    final images = [Appimages.play3, Appimages.player2, Appimages.prince2];
    return images[index % images.length];
  }
}