


















  















    




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/widgets/custom_dashboard_container.dart';

class ActiveSessionScreen extends StatelessWidget {
  const ActiveSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double baseHeight = 812.0;
    final double heightScaleFactor = screenSize.height / baseHeight;

    return Column(
      children: [
        SizedBox(height: 12 * heightScaleFactor),
        
        
        
        
        
        
        
        
        
        
         CustomDashboardContainer(
          onTap:()=> Get.toNamed(RouteName.overViewOptionScreen),
width: 70,
          heading: "Team Building Workshop",
          text1: "phase_1".tr,
          height: 10,
          text2: "phase_1".tr,
          description: "Team Building Workshop strengthens teamwork through interactive activities.",
          text3: "paused".tr,
          text4: "next_phase".tr,
          icon1: Icons.pause,
          text5: "15 Players",
          text6: "25min left",
          icon2: Icons.fast_forward,
        ),
        SizedBox(height: 12 * heightScaleFactor),
        CustomDashboardContainer(
          
          onTap:()=> Get.toNamed(RouteName.overViewOptionScreen),
          heading: "Team Building Workshop",
          text1: "phase_1".tr,
          height: 10,
          text2:"phase_1".tr,
          description: "Team Building Workshop strengthens teamwork through interactive activities.",
          text3: "resume".tr,
          text4:  "end".tr,
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
