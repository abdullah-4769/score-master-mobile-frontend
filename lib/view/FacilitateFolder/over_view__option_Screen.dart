

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scorer/components/facil_over_view_stack_container.dart';
import 'package:scorer/components/leader_boeard_screen.dart';
import 'package:scorer/components/over_view_Screen.dart';
import 'package:scorer/components/phases_Screen.dart';
import 'package:scorer/components/players_Screen.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/controllers/overview_controller.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/useable_container.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';
import 'package:scorer/api/api_controllers/session_controller.dart';
import 'dart:developer' as developer;

class OverViewOptionScreen extends StatelessWidget {
  final controller = Get.put(OverviewController());
  OverViewOptionScreen({super.key});

  final List<String> tabs = [
    "tab_overview".tr,
    "tab_phases".tr,
    "tab_players".tr,
    "tab_leaderboard".tr,
  ];

  final List<Widget> screens = [
    OverViewScreen(),
    PhasesScreen(),
    PlayersScreen(),
    LeaderBoardScreen(),
  ];

  double getTabWidth(String text, double fontSize, BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    const double baseHeight = 812.0;
    const double baseWidth = 414.0;
    final double heightScaleFactor = screenSize.height / baseHeight;
    final double widthScaleFactor = screenSize.width / baseWidth;

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: fontSize * heightScaleFactor),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.width + (20 * widthScaleFactor);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    const double baseHeight = 812.0;
    const double baseWidth = 414.0;
    final double heightScaleFactor = screenSize.height / baseHeight;
    final double widthScaleFactor = screenSize.width / baseWidth;

    // Initialize SessionController
    final SessionController sessionController = Get.put(SessionController());
    developer.log('[LOG] SessionController initialized', name: 'OverViewOptionScreen');
    sessionController.fetchSession(1).then((_) {
      developer.log('[LOG] Session fetched: ${sessionController.session.value?.teamTitle}', name: 'OverViewOptionScreen');
    }).catchError((err) {
      developer.log('[ERROR] Failed to fetch session: $err', name: 'OverViewOptionScreen');
    });

    int tabCount = tabs.length;
    double containerWidth = screenSize.width;
    double tabWidth = containerWidth / tabCount;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// 🧩 Session Info Section
                Obx(() {
                  if (sessionController.isLoading.value) {
                    return Padding(
                      padding: EdgeInsets.all(20 * widthScaleFactor),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.forwardColor,
                        ),
                      ),
                    );
                  }

                  final session = sessionController.session.value;
                  if (session == null) {
                    return Padding(
                      padding: EdgeInsets.all(20 * widthScaleFactor),
                      child: BoldText(
                        text: "Failed to load session",
                        selectionColor: AppColors.blueColor,
                        fontSize: 16 * heightScaleFactor,
                      ),
                    );
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 30 * widthScaleFactor,
                          top: 40 * heightScaleFactor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BoldText(
                              text: session.teamTitle,
                              selectionColor: AppColors.blueColor,
                              fontSize: 16 * heightScaleFactor,
                            ),
                            SizedBox(height: 8 * heightScaleFactor),
                            Row(
                              children: [
                                UseableContainer(
                                  width: 70.w,
                                  text: session.activePhase?.name ?? "Phase Unknown",
                                  color: AppColors.orangeColor,
                                  fontSize: 10.sp,
                                ),
                                SizedBox(width: 8 * widthScaleFactor),
                                UseableContainer(
                                  width: 70.w,
                                  text: session.status ?? "unknown".tr,
                                  color: AppColors.forwardColor,
                                  fontSize: 10.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30 * heightScaleFactor),
                        child: Image.asset(
                          Appimages.house1,
                          height: 85 * heightScaleFactor,
                          width: 100 * widthScaleFactor,
                        ),
                      )
                    ],
                  );
                }),

                SizedBox(height: 12 * heightScaleFactor),

                /// 🧭 Tab Selector
                FacilOverViewStackContainer(
                  widthScaleFactor: widthScaleFactor,
                  heightScaleFactor: heightScaleFactor,
                  containerWidth: containerWidth,
                  controller: controller,
                  tabCount: tabCount,
                  tabWidth: tabWidth,
                  tabs: tabs,
                ),

                SizedBox(height: 12 * heightScaleFactor),

                /// 📱 Dynamic Screen Section
                Obx(() => screens[controller.selectedIndex.value]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
