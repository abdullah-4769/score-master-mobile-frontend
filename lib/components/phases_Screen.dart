


























       












              




















































              



              


              






































                                   






              





















              




















                             
















































































              














































              





































































              



















































































       

































































































































































































































































































































































































































































import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:scorer/components/phases_container.dart';
import 'package:scorer/components/real_time_monitor_container.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/components/stages_row.dart';
import 'package:scorer/components/team_Alpha_Container.dart';
import 'package:scorer/components/team_progress_Container.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/controllers/stage_controllers.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/custom_stratgy_container.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/pause_container.dart';

class PhasesScreen extends StatelessWidget {
  final StageController controller = Get.put(StageController());
  PhasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
       final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;

    
    final double baseHeight = 812.0;
    final double baseWidth = 414.0;
    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;

    
    

    bool isSpanish = Get.locale?.languageCode == 'es';
    
    final verticalSpacing = screenHeight * 0.02;
    final horizontalPadding = screenWidth * 0.05;
    final contentWidth = screenWidth * 0.9;

    return Stack(
      children: [
        
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: verticalSpacing * 2),
              CreateContainer(
                  text: "current_phase".tr, width: screenWidth * 0.3),
              SizedBox(height: verticalSpacing),
              Center(
                child: CircularPercentIndicator(
             radius:  ResponsiveFont.getFontSizeCustom(
defaultSize: 60*widthScaleFactor,
smallSize:55 *widthScaleFactor,

                     ),
                  lineWidth: 5.0, 
                  percent: 0.7, 
                  animation: true,
                  animationDuration: 500,
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: Colors.transparent,
                  progressColor: AppColors.forwardColor,
                  center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             BoldText(
                  text: "12:32",
                  fontSize: ResponsiveFont.getFontSizeCustom(
                    defaultSize: 20,
smallSize: 18
                  ),
                  selectionColor: AppColors.blueColor),
              MainText(
                  text: "remaining".tr,
  fontSize: ResponsiveFont.getFontSizeCustom(
                    defaultSize: 14,
smallSize: 12
                  ),
                  height: 1),
          ],
                  ),
                ),
              ),
              
              
              SizedBox(height: verticalSpacing),
          
              
              PhaseContainer(horizontalPadding: horizontalPadding, contentWidth: contentWidth, screenHeight: screenHeight, screenWidth: screenWidth),
              Icon(Icons.arrow_downward_sharp,
                  color: AppColors.forwardColor, size: screenWidth * 0.08),
              SizedBox(height: verticalSpacing),
          
              StagesRow(),
              SizedBox(height: verticalSpacing),
          
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Row(
                        children: [
                          Expanded(
                                      flex: controller.isCompleted.value ? 3 : 2,
          
                            child: Container(
                              height: screenHeight * 0.008,
                              width: controller.isCompleted.value
                                  ? contentWidth
                                  : contentWidth * 0.5,
                              decoration: BoxDecoration(
                                  color: controller.isCompleted.value
                                      ? AppColors.forwardColor
                                      : AppColors.selectLangugaeColor,
                                  borderRadius:
                                      BorderRadius.circular(screenWidth * 0.05)),
                            ),
                          ),
                          Container(
                            height: screenHeight * 0.008,
                            width: controller.isCompleted.value
                                ? 0
                                : contentWidth * 0.4,
                            decoration: BoxDecoration(
                                color: AppColors.greyColor,
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.05)),
                          ),
                        ],
                      );
                    }),
                    SizedBox(height: screenHeight * 0.01),
                    Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BoldText(
                              text: controller.isCompleted.value
                                  ? "8:19"
                                  : "12:32",
                              fontSize: screenWidth * 0.06,
                              selectionColor: AppColors.blueColor),
                          MainText(
                              text: controller.isCompleted.value
                                  ? "complete".tr
                                  : "remaining".tr,
                              fontSize: screenWidth * 0.04),
                        ],
                      );
                    }),
                    SizedBox(height: verticalSpacing),
          
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: PauseContainer(
                              height: 42,
                                onTap: () =>
                                
                                    controller.isCompleted.value = false,
                                 text: "back".tr,
                                 fontSize: ResponsiveFont.getFontSizeCustom(
defaultSize: 14*widthScaleFactor,
smallSize: 12*widthScaleFactor

                     ),
                                 
                                 )),
                        SizedBox(width: horizontalPadding),
                       Expanded(
            child: PauseContainer(
              onTap: () {
                if (!controller.isCompleted.value) {
                  
                  controller.isCompleted.value = true;
                } else {
                  
                Get.toNamed(RouteName.viewResponsesScreen); 
                  
                }
              },
              height: 42,
              text: "assign_score".tr,
              fontSize: ResponsiveFont.getFontSizeCustom(
defaultSize: 14*widthScaleFactor,
smallSize: 12*widthScaleFactor

                     ),
              icon: Icons.fast_forward,
              color: AppColors.assignColor,
            ),
          ),
                     ],
                    ),
                    SizedBox(height: verticalSpacing),
          
                    
                    TeamProgressContainer(contentWidth: contentWidth, screenHeight: screenHeight, screenWidth: screenWidth, verticalSpacing: verticalSpacing, controller: controller),
                    SizedBox(height: verticalSpacing),
                    BoldText( text: "all_phases".tr,fontSize: 16,selectionColor: AppColors.blueColor,),
          SizedBox(height: 25,),
                    CustomStratgyContainer(
                      
fontSize2:  ResponsiveFont.getFontSize(),


                      width3: 80,
                      iconContainer: AppColors.forwardColor, icon: Icons.check, text1:  "phase1_strategy".tr, text2: "Completed • 20 min", text3: "completed".tr, smallContainer: AppColors.forwardColor, largeConatiner: AppColors.forwardColor,
                    flex: 3,flex1: 0,
                    ),
                    SizedBox(height: 10,),
                     CustomStratgyContainer(
                      


fontSize2:  ResponsiveFont.getFontSize(),


                      
                      
                      iconContainer: AppColors.selectLangugaeColor, icon: Icons.play_arrow_sharp, text1: "phase2_strategy".tr ,text2: "Active • 30 min", text3: "active".tr, smallContainer: AppColors.selectLangugaeColor, largeConatiner: AppColors.selectLangugaeColor,
             
                    ),
                     SizedBox(height: 10,),
                     CustomStratgyContainer(

fontSize2:  ResponsiveFont.getFontSize(),

                      width3: 80,
                      iconContainer: AppColors.watchColor, icon: Icons.watch_later, text1: "phase3_implementation".tr, text2: "Upcoming • 25 min", text3: "pending".tr, smallContainer: AppColors.watchColor, largeConatiner: AppColors.greyColor,flex: 4,flex1: 0,
             
                    ),
                         SizedBox(height: 10,),
                     CustomStratgyContainer(

fontSize2:  ResponsiveFont.getFontSize(),
                      width3: 80,
                      iconContainer: AppColors.watchColor, icon: Icons.watch_later, text1: "phase4_evaluation".tr,text2: "Upcoming • 15 min", text3: "pending".tr, smallContainer: AppColors.watchColor, largeConatiner: AppColors.greyColor,flex: 4,flex1: 0,
             
                    ),
                    SizedBox(height: 25,),
          
          
                    
                    RealTimeMonitorContainer(contentWidth: contentWidth, screenHeight: screenHeight, screenWidth: screenWidth, verticalSpacing: verticalSpacing),
                    SizedBox(height: verticalSpacing),
          
                    
                    Center(
                      child: LoginButton(
                        fontSize: 18,
                         text: "view_responses".tr,
                        color: AppColors.forwardColor,
                        ishow: true,
                        image: Appimages.eye,
                      ),
                    ),
                    SizedBox(height: verticalSpacing * 2),
                  ],
                ),
              ),
            ],
          ),
        ),

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

        
        Positioned(
          right: 0,
          top: screenHeight * 0.2,
          child: TeamAlphaContainer(screenWidth: screenWidth, screenHeight: screenHeight),
        ),

        
        
        
        
        
        
        
      ],
    );
  }
}
