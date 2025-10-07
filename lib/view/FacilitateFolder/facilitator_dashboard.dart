import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/components/active_Session_Screen.dart';
import 'package:scorer/components/facil_dashboard_stack_container.dart';
import 'package:scorer/components/schedule_Screen.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/controllers/facil_dashboard_controller.dart';
import 'package:scorer/widgets/add_one_Container.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/setting_container.dart';

import 'aa.dart';

class FacilitatorDashboard extends StatelessWidget {
  final controller = Get.put(FacilDashboardController());

  FacilitatorDashboard({super.key}) {
    print("FacilitatorDashboard: Controller created or retrieved");
    // Listen to changes in selectedIndex
    ever(controller.selectedIndex, (value) {
      print("FacilDashboardController: selectedIndex changed to $value");
    });
  }

  final List<Widget> screens = const [
    ActiveSessionScreen(),
    ScheduleScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    print("FacilitatorDashboard: build called");

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32 * widthScaleFactor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        Appimages.facil2,
                        width: 62 * widthScaleFactor,
                        height: 83 * heightScaleFactor,
                      ),
                      Row(
                        children: [
                          SettingContainer(icons: Icons.settings),
                          SizedBox(width: 6 * widthScaleFactor),
                          SettingContainer(
                            icons: Icons.notifications,
                            ishow: true,
                          ),
                          Row(
                            children: [
                              SettingContainer(icons: Icons.settings),
                              SizedBox(width: 6 * widthScaleFactor),
                              SettingContainer(
                                icons: Icons.notifications,
                                ishow: true,
                              ),
                              SizedBox(width: 6 * widthScaleFactor),
                              AddOneContainer(icon: Icons.add, onTap: () {
                                print("AddOneContainer tapped, navigating to createNewSessionScreen");
                                Get.toNamed(RouteName.createNewSessionScreen);
                              }),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 21 * widthScaleFactor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(""),
                      CreateContainer(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32 * widthScaleFactor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          BoldText(
                            text: "welcome_back".tr,
                            fontSize: 16 * heightScaleFactor,
                            selectionColor: AppColors.blueColor,
                          ),
                          BoldText(
                            text: " Adam!",
                            fontSize: 16 * heightScaleFactor,
                            selectionColor: AppColors.blueColor,
                          ),
                        ],
                      ),

                      MainText(
                        text: "manage_sessions".tr,
                        fontSize: 14 * heightScaleFactor,
                        height: 1.4,
                      ),
                      SizedBox(height: 23 * heightScaleFactor),
                      Obx(() {
                        print("Obx: Building FacilDashBoardStackContainer with selectedIndex: ${controller.selectedIndex.value}");
                        return FacilDashBoardStackContainer(
                          heightScaleFactor: heightScaleFactor,
                          widthScaleFactor: widthScaleFactor,
                          controller: controller,
                        );
                      }),
                    ],
                  ),
                ),
                Obx(() {
                  print("Obx: Displaying screen at index: ${controller.selectedIndex.value}");
                  return screens[controller.selectedIndex.value];
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}