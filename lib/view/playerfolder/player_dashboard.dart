
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/custom_dashboard_container.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/setting_container.dart';

class PlayerDashboard extends StatelessWidget {
  const PlayerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    
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
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 32 * widthScaleFactor,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        Appimages.player2,
                        width: 62 * widthScaleFactor,
                        height: 83 * heightScaleFactor,
                      ),
                      Row(
                        children: [
                          SettingContainer(
                            icons: Icons.settings,
                            
                          ),
                          SizedBox(width: 6 * widthScaleFactor),
                          SettingContainer(
                            icons: Icons.notifications,
                            ishow: true,
                            
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20 * heightScaleFactor),
                 BoldText(
  text: "welcome_scoremaster".tr,
  fontSize: 16 * heightScaleFactor,
  selectionColor: AppColors.blueColor,
),
                MainText(
  text: "join_session_text".tr,
  fontSize: 14 * heightScaleFactor,
  height: 1.4,
),
                  SizedBox(height: 20 * heightScaleFactor),
                  Container(
                    height: 70 * heightScaleFactor,
                    width: 337 * widthScaleFactor,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26 * widthScaleFactor),
                      border: Border.all(
                          color: AppColors.greyColor,
                          width: 1.5 * widthScaleFactor),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -20 * heightScaleFactor,
                          right: 0,
                          child: CreateContainer(
  text: "join_with_code".tr,
  width: 186 * widthScaleFactor,
),
                        ),
                      Center(
  child: BoldText(
    text: "enter_code".tr,
    fontSize: 22 * heightScaleFactor,
  ),
),
                      ],
                    ),
                  ),
                  SizedBox(height: 18 * heightScaleFactor),
                  
   
                    CustomDashboardContainer(
                      onTap: ()=>Get.toNamed(RouteName.playerLoginPlaySide),
          
arrowshow: false,
horizontal: 0,
          
          width2: 78,
          color2: AppColors.scheColor,
          heading: "Eranove Odyssey – Team A",
          text1: "Phase 2",
          ishow: false,
          text2: "Scheduled",
          description: "Leadership Assessment strengthens teamwork through interactive activities.",

          
          text3: "paused".tr,
          text7:"join_session".tr,
          icon3: Icons.fast_forward,
          color3: AppColors.forwardColor,
          text5: "12 Players",
          text6: "Starts in 2h",
        ),
        SizedBox(height: 12 * heightScaleFactor),
         CustomDashboardContainer(
                      onTap: ()=>Get.toNamed(RouteName.playerLoginPlaySide),
          
arrowshow: false,
horizontal: 0,
          
          width2: 78,
          color2: AppColors.scheColor,
          heading: "Eranove Odyssey – Team A",
          text1: "Phase 2",
          ishow: false,
          text2: "scheduled".tr,
          description: "Leadership Assessment strengthens teamwork through interactive activities.",

          
          text3: "Pause",
         text7: "join_session".tr,
          icon3: Icons.fast_forward,
          color3: AppColors.forwardColor,
          text5: "12 Players",
          text6: "Starts in 2h",
        ), SizedBox(height: 20 * heightScaleFactor)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}