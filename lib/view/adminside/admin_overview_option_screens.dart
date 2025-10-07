import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/components/adminside/admin_overview_screen.dart';
import 'package:scorer/components/adminside/admin_phase_screen.dart';
import 'package:scorer/components/adminside/admin_player_Screen.dart';
import 'package:scorer/components/leader_boeard_screen.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/controllers/overview_controller.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/useable_container.dart';
import '../../api/api_controllers/session_controller.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';

class AdminOverviewOptionScreens extends StatelessWidget {
  final controller = Get.put(OverviewController());
  AdminOverviewOptionScreens({super.key});

  final List<String> tabs = [
    "tab_overview".tr,
    "tab_phases".tr,
    "tab_players".tr,
    "tab_leaderboard".tr,
  ];

  final List<Widget> screens = [
    AdminOverviewScreen(),
    AdminPhaseScreen(),
    AdminPlayerScreen(),
    LeaderBoardScreen()
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

    // ✅ Initialize or find the SessionController
    final SessionController sessionController = Get.put(SessionController());
    print("[LOG] SessionController initialized");

    // Optionally, fetch a session here (replace 7 with your session ID)
    sessionController.fetchSession(7).then((_) {
      print("[LOG] Session fetched: ${sessionController.session.value?.teamTitle}");
    }).catchError((err) {
      print("[ERROR] Failed to fetch session: $err");
    });

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                children: [
                  // Top Row with Team Title, Phase, Status, and Icon
                  Obx(() {
                    final session = sessionController.session.value;
                    print("[LOG] Rebuilding header. Team: ${session?.teamTitle}");

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
                                text: session?.teamTitle ?? "Loading...",
                                selectionColor: AppColors.blueColor,
                                fontSize: 16 * heightScaleFactor,
                              ),
                              SizedBox(height: 8 * heightScaleFactor),
                              Row(
                                children: [
                                  UseableContainer(
                                    width: 70,
                                    height: 20,
                                    text: session?.activePhase.name ?? "Phase ?",
                                    color: AppColors.orangeColor,
                                    fontSize: 10 * heightScaleFactor,
                                  ),
                                  SizedBox(width: 8 * widthScaleFactor),
                                  UseableContainer(
                                    width: 70,
                                    height: 20,
                                    text: session?.status ?? "loading".tr,
                                    color: AppColors.forwardColor,
                                    fontSize: 10 * heightScaleFactor,
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

                  // Tabs
                  Obx(() {
                    int tabCount = tabs.length;
                    double containerWidth = screenSize.width;
                    double tabWidth = containerWidth / tabCount;

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 21 * widthScaleFactor),
                      child: Container(
                        height: 53 * heightScaleFactor,
                        width: containerWidth,
                        decoration: BoxDecoration(
                          color: AppColors.settingColor,
                          borderRadius: BorderRadius.circular(12 * widthScaleFactor),
                        ),
                        child: Stack(
                          children: [
                            AnimatedAlign(
                              alignment: Alignment(
                                (controller.selectedIndex.value / (tabCount - 1)) * 2 - 1,
                                0,
                              ),
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 5 * widthScaleFactor,
                                  vertical: 5.5 * heightScaleFactor,
                                ),
                                height: 42 * heightScaleFactor,
                                width: tabWidth - (18 * widthScaleFactor),
                                decoration: BoxDecoration(
                                  color: AppColors.forwardColor,
                                  borderRadius: BorderRadius.circular(12 * widthScaleFactor),
                                ),
                              ),
                            ),
                            Row(
                              children: List.generate(tabCount, (index) {
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () => controller.changeTab(index),
                                    child: Center(
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            tabs[index],
                                            style: TextStyle(
                                              fontSize: 13 * heightScaleFactor,
                                              color: controller.selectedIndex.value == index
                                                  ? AppColors.whiteColor
                                                  : AppColors.languageColor,
                                            ),
                                          ),
                                        )),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                  SizedBox(height: 12 * heightScaleFactor),

                  // Selected Screen
                  Obx(() => screens[controller.selectedIndex.value]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
