





























































                        






        






      





        


        
























        



























        
        
        








































    















































































































































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

import 'package:scorer/view/FacilitateFolder/aa.dart';

import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/useable_container.dart';

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
    LeaderBoeardScreen()
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

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                
                Row(
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
                            text: "Eranove Odyssey – Team A",
                            selectionColor: AppColors.blueColor,
                            fontSize: 16 * heightScaleFactor,
                          ),
                          SizedBox(height: 8 * heightScaleFactor),
                          Row(
                            children: [
                              UseableContainer(
                                width: 70.w,
                                text: "Phase 2",
                                color: AppColors.orangeColor,
                                fontSize: 10.sp,
                                
                              ),
                              SizedBox(width: 8 * widthScaleFactor),
                              UseableContainer(
                                width: 70.w,
                                text: "active".tr,
                                
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
                ),
            
                SizedBox(height: 12 * heightScaleFactor),
            
              
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            Obx(() {
              int tabCount = tabs.length;
            
              
              double containerWidth = screenSize.width - (0 * widthScaleFactor);
            
              
              double tabWidth = containerWidth / tabCount;
            
              return FacilOverViewStackContainer(widthScaleFactor: widthScaleFactor, heightScaleFactor: heightScaleFactor, containerWidth: containerWidth, controller: controller, tabCount: tabCount, tabWidth: tabWidth, tabs: tabs);
            }),
            
                SizedBox(height: 12 * heightScaleFactor),
            
                
                Obx(() => screens[controller.selectedIndex.value]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
