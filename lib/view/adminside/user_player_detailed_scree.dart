import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/account_info_column.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/custom_dashboard_container.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';
import '../../api/api_controllers/stat_user_management.dart';
import '../../widgets/useable_container.dart';
import '../FacilitateFolder/aa.dart';

class UserPlayerDetailedScree extends StatelessWidget {
  const UserPlayerDetailedScree({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    const double baseHeight = 812.0;
    const double baseWidth = 414.0;
    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;

    // Initialize the controller
    final StatsUserManagementController controller = Get.put(StatsUserManagementController());

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : controller.errorMessage.value.isNotEmpty
              ? Center(child: Text(controller.errorMessage.value))
              : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * widthScaleFactor),
              child: Column(
                children: [
                  SizedBox(height: 20 * heightScaleFactor),
                  SizedBox(
                    height: 135 * heightScaleFactor,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 0,
                          top: 20 * heightScaleFactor,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
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
                          child: Image.asset(
                            Appimages.player2,
                            width: 101 * widthScaleFactor,
                            height: 135 * heightScaleFactor,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BoldText(
                    text: controller.statsUserManagement.value.playerInfo?.name ?? 'Unknown',
                    fontSize: 16 * widthScaleFactor,
                    selectionColor: AppColors.blueColor,
                  ),
                  MainText(
                    text: controller.statsUserManagement.value.playerInfo?.email ?? 'No email',
                    fontSize: 14 * widthScaleFactor,
                    height: 1.4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MainText(
                        text: "last_login".tr,
                        fontSize: 14 * widthScaleFactor,
                        color: AppColors.redColor,
                      ),
                      SizedBox(width: 3 * widthScaleFactor),
                      Container(
                        width: 9 * widthScaleFactor,
                        height: 9 * widthScaleFactor,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.redColor,
                        ),
                      ),
                      SizedBox(width: 3 * widthScaleFactor),
                      MainText(
                        text: controller.statsUserManagement.value.user?.createdAt?.split('T')[0] ?? 'Unknown',
                        fontSize: 14 * widthScaleFactor,
                        color: AppColors.redColor,
                      ),
                    ],
                  ),
                  UseableContainer(
                    text: "active".tr,
                    fontSize: 11,
                    color: AppColors.forwardColor,
                    height: 22 * heightScaleFactor,
                  ),
                  SizedBox(height: 24 * heightScaleFactor),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12 * widthScaleFactor),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: 105,
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
                                  text: controller.statsUserManagement.value.sessionStats?.totalSessions.toString() ?? '0',
                                  selectionColor: AppColors.redColor,
                                  fontSize: 0.06 * screenWidth,
                                ),
                                BoldText(
                                  textAlign: TextAlign.center,
                                  text: "sessions_led".tr,
                                  fontSize: 0.04 * screenWidth,
                                  selectionColor: AppColors.blueColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10 * widthScaleFactor),
                        Expanded(
                          child: Container(
                            width: 105,
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
                                  text: controller.statsUserManagement.value.recentSessions?.length.toString() ?? '0',
                                  selectionColor: AppColors.forwardColor,
                                  fontSize: 0.06 * screenWidth,
                                ),
                                BoldText(
                                  textAlign: TextAlign.center,
                                  text: "manage_players".tr,
                                  fontSize: 0.04 * screenWidth,
                                  selectionColor: AppColors.blueColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 105,
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
                                  text: "${controller.statsUserManagement.value.sessionStats?.avgScore ?? 0}%",
                                  selectionColor: AppColors.redColor,
                                  fontSize: 0.06 * screenWidth,
                                ),
                                BoldText(
                                  textAlign: TextAlign.center,
                                  text: "success_rate".tr,
                                  fontSize: 0.04 * screenWidth,
                                  selectionColor: AppColors.blueColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 33 * heightScaleFactor),
                Obx(() => AccountInfoClumn(
                  widthScaleFactor: widthScaleFactor,
                  heightScaleFactor: heightScaleFactor,
                  email: controller.statsUserManagement.value.user?.email,
                  phone: controller.statsUserManagement.value.user?.phone,
                  joinDate: controller.statsUserManagement.value.user?.createdAt != null
                      ? controller.statsUserManagement.value.user!.createdAt!.split("T")[0] // only date
                      : null,
                  levelText: "Level 3",
                )),
                  SizedBox(height: 20 * heightScaleFactor),
                  BoldText(
                    text: "recent_sessions".tr,
                    selectionColor: AppColors.blueColor,
                    fontSize: 16 * widthScaleFactor,
                  ),
                  SizedBox(height: 20 * heightScaleFactor),
                  // Display recent sessions dynamically
                  if (controller.statsUserManagement.value.recentSessions != null)
                    ...controller.statsUserManagement.value.recentSessions!.map((session) => Column(
                      children: [
                        CustomDashboardContainer(
                          mainWidth: 376 * widthScaleFactor,
                          right: 10 * widthScaleFactor,
                          mainHeight: 228 * heightScaleFactor,
                          color2: AppColors.forwardColor,
                          color1: AppColors.orangeColor,
                          heading: session.sessionName ?? 'Unnamed Session',
                          text1: session.status != null ? "Phase ${session.totalPhases}" : 'No Phase',
                          height: 5 * heightScaleFactor,
                          text2: session.status ?? "Unknown",
                          text6: "${session.rank} Position",
                          smallImage: Appimages.Crown,
                          description: session.sessionDescription ?? 'No description',
                          icon1: Icons.play_arrow,
                          text5: "${session.totalPlayers} Players",
                          isshow: true,
                        ),
                        SizedBox(height: 12 * heightScaleFactor),
                      ],
                    )).toList(),
                  SizedBox(height: 20 * heightScaleFactor),
                  LoginButton(
                    text: "delete_player".tr,
                    ishow: true,
                    image: Appimages.delete,
                    fontSize: 20,
                    color: AppColors.redColor,
                    // onPressed: () {
                    //   // Implement delete player logic
                    // },
                  ),
                  SizedBox(height: 20 * heightScaleFactor),
                  LoginButton(
                    text: "edit_player".tr,
                    ishow: true,
                    icon: Icons.edit,
                    fontSize: 20,
                    color: AppColors.forwardColor,
                    // onPressed: () {
                    //   // Implement edit player logic
                    // },
                  ),
                  SizedBox(height: 42 * heightScaleFactor),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}