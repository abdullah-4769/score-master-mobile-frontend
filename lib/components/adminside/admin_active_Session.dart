import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/widgets/custom_dashboard_container.dart';

class AdminActiveSession extends StatelessWidget {
  const AdminActiveSession({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double baseHeight = 812.0;
    final double heightScaleFactor = screenSize.height / baseHeight;

    return Column(
      children: [
        SizedBox(height: 12 * heightScaleFactor),
         CustomDashboardContainer(
          width: 70,
            width2:70 ,
            height2: 22,

          height1:22 ,
          onTap: () => Get.toNamed(RouteName.adminOverviewOptionScreens),
          heading: "Team Building Workshop",
          text1: "Phase 1",
          height: 10,
          text2: "Phase 1",
          description: "Team Building Workshop strengthens teamwork through interactive activities.",
          text3: "resume".tr,
          text4: "next_phase".tr,
          icon1: Icons.play_arrow,
          text5: "15 Players",
          text6: "paused".tr,
          icon2: Icons.square,
        ),
        SizedBox(height: 12 * heightScaleFactor),
















          CustomDashboardContainer(
            width2:70 ,
            height2: 22,
               width: 70,
          height1:22 ,

          onTap: () => Get.toNamed(RouteName.adminOverviewOptionScreens),

              color2: AppColors.yellowColor,
          color1: AppColors.redColor,
          heading: "Team Building Workshop",

          text1: "Phase 1",
          height: 10,
          text2: "Phase 1",
          description: "Team Building Workshop strengthens teamwork through interactive activities.",
          text3: "resume".tr,
          text4: "next_phase".tr,
          icon1: Icons.play_arrow,
          text5: "15 Players",
          text6: "paused".tr,
          icon2: Icons.square,
        ),
        SizedBox(height: 20 * heightScaleFactor)
      ],
    );
  }
}
