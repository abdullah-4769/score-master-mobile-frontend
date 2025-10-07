import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/custom_dashboard_container.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final Size screenSize = MediaQuery.of(context).size;
    final double baseHeight = 812.0;
    final double heightScaleFactor = screenSize.height / baseHeight;

    return Column(
      children: [
        SizedBox(height: 12 * heightScaleFactor),
        
          CustomDashboardContainer(
        text7: "start_early".tr,
          icon3: Icons.fast_forward,
          heading: "Team Building Workshop",
          text1: "Phase 1",
          height: 10,
          text2: "Phase 1",
          description: "Team Building Workshop strengthens teamwork through interactive activities.",
          text3: "Resume",
          text4: "Next Phase",
          icon1: Icons.play_arrow,
          text5: "15 Players",
          text6: "Paused",
          icon2: Icons.square,
          ishow: false,
        ),
        SizedBox(height: 12 * heightScaleFactor),
      
          CustomDashboardContainer(
            
          icon3: Icons.fast_forward,
          heading: "Team Building Workshop",
          text1: "Phase 1",
          height: 10,
          text2: "Phase 1",
          description: "Team Building Workshop strengthens teamwork through interactive activities.",
          text3: "Resume",
          text4: "Next Phase",
          icon1: Icons.play_arrow,
          text5: "15 Players",
          
          icon2: Icons.square,
          ishow: false,
           svg: Appimages.edit,
       text7: "edit_session".tr,
          text6: "Friday 2:00 PM," ),
        SizedBox(height: 20 * heightScaleFactor)
      ],
    );
  }
}
