
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/widgets/custom_dashboard_container.dart';

class AdminScheduleSession extends StatelessWidget {
  const AdminScheduleSession({super.key});

  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;
    final double baseHeight = 812.0;
    final double heightScaleFactor = screenSize.height / baseHeight;

    return Column(
      children: [
        SizedBox(height: 12 * heightScaleFactor),
        CustomDashboardContainer(
          onTap: () => Get.toNamed(RouteName.adminOverviewOptionScreens),
  width: 70,


          height1:22 ,

          height2: 20,
          width2: 80,
          color2: AppColors.scheColor,
          heading: "Eranove Odyssey – Team A",
          text1: "Phase 2",
          ishow: false,
          text2: "scheduled".tr,
          description: "Leadership Assessment strengthens teamwork through interactive activities.",


          text3: "Pause",
        text7: "start_early".tr,
          icon3: Icons.fast_forward,
          color3: AppColors.forwardColor,
          text5: "12 Players",
          text6: "Starts in 2h",
        ),
        SizedBox(height: 12 * heightScaleFactor),
        CustomDashboardContainer(
          onTap: () => Get.toNamed(RouteName.adminOverviewOptionScreens),
  width: 70,

            height2: 22,
          height1:22 ,
          height: 10,
          ishow: false,
          width2: 78,
          color2: AppColors.scheColor,
          heading: "Leadership Assessment",
          text1: "Phase 1",
          color1: AppColors.phaseColor,
          text2: "Scheduled",
          description: "Leadership Assessment strengthens teamwork through interactive activities.",
          text3: "Resume",
          text4: "Next Phase",
          svg: Appimages.edit,
          text7: "edit_session".tr,
          text6: "Friday 2:00 PM",
        ),
        SizedBox(height: 20 * heightScaleFactor)
      ],
    );
  }
}
