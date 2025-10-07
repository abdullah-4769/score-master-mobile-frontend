import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/account_info_column.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/custom_dashboard_container.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/useable_container.dart';
import '../../api/api_controllers/stat_user_management.dart';
import '../FacilitateFolder/aa.dart';

class UserFacilitateDetailedScree extends StatelessWidget {
  const UserFacilitateDetailedScree({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StatsUserManagementController());

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
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.errorMessage.isNotEmpty) {
              return Center(child: Text(controller.errorMessage.value));
            }

            final data = controller.statsUserManagement.value;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20 * widthScaleFactor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20 * heightScaleFactor),

                    // Header Section
                    SizedBox(
                      height: 135 * heightScaleFactor,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            left: 0,
                            top: 20 * heightScaleFactor,
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
                            child: Image.asset(
                              Appimages.facil2,
                              width: 101 * widthScaleFactor,
                              height: 135 * heightScaleFactor,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // User Info
                    BoldText(
                      text: data.playerInfo?.name ?? "Unknown",
                      fontSize: 18 * widthScaleFactor,
                      selectionColor: AppColors.blueColor,
                    ),
                    MainText(
                      text: data.playerInfo?.email ?? "No email",
                      fontSize: 14 * widthScaleFactor,
                    ),

                    // Last login row
                    SizedBox(height: 10 * heightScaleFactor),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MainText(
                          text: "Last login: ",
                          fontSize: 14 * widthScaleFactor,
                          color: AppColors.redColor,
                        ),
                        MainText(
                          text: data.user?.createdAt?.split("T").first ?? "N/A",
                          fontSize: 14 * widthScaleFactor,
                          color: AppColors.redColor,
                        ),
                      ],
                    ),

                    UseableContainer(
                      text: "Active",
                      color: AppColors.forwardColor,
                      height: 22 * heightScaleFactor,
                    ),

                    SizedBox(height: 24 * heightScaleFactor),

                    // Stats Cards Row
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12 * widthScaleFactor,
                      ),
                      child: Row(
                        children: [
                          buildStatCard(
                            label: "Total Sessions",
                            value: "${data.sessionStats?.totalSessions ?? 0}",
                            color: AppColors.redColor,
                            widthScaleFactor: widthScaleFactor,
                            heightScaleFactor: heightScaleFactor,
                            screenWidth: screenWidth,
                          ),
                          SizedBox(width: 10 * widthScaleFactor),
                          buildStatCard(
                            label: "Players Managed",
                            value: "${data.recentSessions?.length ?? 0}",
                            color: AppColors.forwardColor,
                            widthScaleFactor: widthScaleFactor,
                            heightScaleFactor: heightScaleFactor,
                            screenWidth: screenWidth,
                          ),
                          SizedBox(width: 10 * widthScaleFactor),
                          buildStatCard(
                            label: "Avg Score",
                            value: "${data.sessionStats?.avgScore ?? 0}%",
                            color: AppColors.orangeColor,
                            widthScaleFactor: widthScaleFactor,
                            heightScaleFactor: heightScaleFactor,
                            screenWidth: screenWidth,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 33 * heightScaleFactor),

                    // Account Info Section
                    Obx(
                      () => AccountInfoClumn(
                        widthScaleFactor: widthScaleFactor,
                        heightScaleFactor: heightScaleFactor,
                        email: controller.statsUserManagement.value.user?.email,
                        phone: controller.statsUserManagement.value.user?.phone,
                        joinDate:
                            controller
                                    .statsUserManagement
                                    .value
                                    .user
                                    ?.createdAt !=
                                null
                            ? controller
                                  .statsUserManagement
                                  .value
                                  .user!
                                  .createdAt!
                                  .split("T")[0] // only date
                            : null,
                        levelText: "Level 3",
                      ),
                    ),

                    SizedBox(height: 20 * heightScaleFactor),

                    // Recent Sessions
                    BoldText(
                      text: "Recent Sessions",
                      selectionColor: AppColors.blueColor,
                      fontSize: 16 * widthScaleFactor,
                    ),
                    SizedBox(height: 20 * heightScaleFactor),

                    if (data.recentSessions != null &&
                        data.recentSessions!.isNotEmpty)
                      Column(
                        children: data.recentSessions!.map((session) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: 12 * heightScaleFactor,
                            ),
                            child: CustomDashboardContainer(
                              mainWidth: 376 * widthScaleFactor,
                              right: 10 * widthScaleFactor,
                              mainHeight: 228 * heightScaleFactor,
                              color2: AppColors.forwardColor,
                              color1: AppColors.orangeColor,
                              heading: session.sessionName ?? "No Name",
                              text1: "Phases: ${session.totalPhases ?? 0}",
                              height: 5 * heightScaleFactor,
                              text2: session.status ?? "N/A",
                              text6: "Rank: ${session.rank?.toString() ?? '-'}",
                              smallImage: Appimages.Crown,
                              description: session.sessionDescription ?? "",
                              icon1: Icons.play_arrow,
                              text5: "${session.totalPlayers ?? 0} Players",
                              isshow: true,
                            ),
                          );
                        }).toList(),
                      )
                    else
                      Center(
                        child: MainText(
                          text: "No sessions found",
                          fontSize: 14 * widthScaleFactor,
                        ),
                      ),

                    SizedBox(height: 20 * heightScaleFactor),

                    // Buttons
                    LoginButton(
                      text: "Delete Facilitator",
                      ishow: true,
                      image: Appimages.delete,
                      fontSize: 20,
                      color: AppColors.redColor,
                    ),
                    SizedBox(height: 20 * heightScaleFactor),
                    LoginButton(
                      text: "Edit Facilitator",
                      ishow: true,
                      icon: Icons.edit,
                      fontSize: 20,
                      color: AppColors.forwardColor,
                    ),
                    SizedBox(height: 42 * heightScaleFactor),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // Reusable Stat Card Builder
  Widget buildStatCard({
    required String label,
    required String value,
    required Color color,
    required double widthScaleFactor,
    required double heightScaleFactor,
    required double screenWidth,
  }) {
    return Expanded(
      child: Container(
        height: 116 * heightScaleFactor,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.greyColor,
            width: 1.7 * widthScaleFactor,
          ),
          borderRadius: BorderRadius.circular(24 * widthScaleFactor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BoldText(
              text: value,
              selectionColor: color,
              fontSize: 0.06 * screenWidth,
            ),
            BoldText(
              textAlign: TextAlign.center,
              text: label,
              fontSize: 0.04 * screenWidth,
              selectionColor: AppColors.blueColor,
            ),
          ],
        ),
      ),
    );
  }
}
