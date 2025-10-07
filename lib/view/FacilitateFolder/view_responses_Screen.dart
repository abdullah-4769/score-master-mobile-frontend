
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/components/team_Alpha_Container.dart';
import 'package:scorer/components/view_response_stack_container.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/controllers/stage_controllers.dart';

import 'package:scorer/view/FacilitateFolder/aa.dart';

import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/custom_response_container.dart';
import 'package:scorer/widgets/custom_stratgy_container.dart';

class ViewResponsesScreen extends StatelessWidget {
  final StageController controller = Get.put(StageController());
  ViewResponsesScreen({super.key});
final List<String> tabs = ["all".tr, "pending".tr, "scored".tr];


  @override
  Widget build(BuildContext context) {
    bool isSpanish = Get.locale?.languageCode == 'es';

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
          child: Stack(
            
            children: [
              
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      
                       SizedBox(
  height: 50,
  child: Stack(
    alignment: Alignment.center,
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: SvgPicture.asset(
                                Appimages.arrowback,
                                colorFilter: ColorFilter.mode(
                                    AppColors.forwardColor, BlendMode.srcIn),
                                width: 24 .w,
                                height: 20 .h,
                              ),
                            ),
      ),
      Center(
        child: BoldText(
            text: "stage2_responses".tr,
            
fontSize: ResponsiveFont.getFontSizeCustom(
defaultSize: 22*widthScaleFactor
,
smallSize: 20*widthScaleFactor
),
          selectionColor: AppColors.blueColor,
        ),
      ),
    ],
  ),
),
                      SizedBox(height: 27,),
                  
                      CustomStratgyContainer(
                        isshow: true,
                        mainHeight: 1.3,
                        fontSize: ResponsiveFont.getFontSizeCustom(
                          defaultSize: 14*widthScaleFactor,
                          smallSize: 12*widthScaleFactor
                        ),
                        containerHeight: 180,
                        width3: 54,
                        spaceHeight2: 20,
                        spaceHeight: 14,
                        extra:
                            "primary_objective".tr,
                        width1: 150,
                        width2: 126,
                        iconContainer: AppColors.selectLangugaeColor,
                        icon: Icons.play_arrow_rounded,
                        text1:"phase2_strategy".tr,
                        fontSize2: ResponsiveFont.getFontSizeCustom
                        
                        (
defaultSize: 14*widthScaleFactor
,smallSize: 10*widthScaleFactor
                        ),
                      

                        text2: 'Completed • 20 min',
                        text3: 'active'.tr,
                        smallContainer: AppColors.selectLangugaeColor,
                        largeConatiner: AppColors.selectLangugaeColor,
                      ),
                  
                      SizedBox(height: 31),
                      CreateContainer( text: "stage2_scoring".tr, width: 134),
                  SizedBox(height: 31,),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 51,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.greyColor, width: 1.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BoldText(
                                    text: "08",
                                    selectionColor: AppColors.redColor,
                                    fontSize: 24,
                                  ),
                                  SizedBox(width: 11),
                                  BoldText(
                                    text: "scored".tr,
                                    selectionColor: AppColors.blueColor,
                                    fontSize: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Container(
                              height: 51,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.greyColor, width: 1.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BoldText(
                                    text: "04",
                                    selectionColor: AppColors.redColor,
                                    fontSize: 24,
                                  ),
                                  SizedBox(width: 11),
                                  BoldText(
                                    text: "pending".tr,
                                    selectionColor: AppColors.blueColor,
                                    fontSize: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              
                  
                      SizedBox(height: 20),
                  
                      
                     Obx(() {
                    double totalWidth = MediaQuery.of(context).size.width - 60; 
                    
                    double tabWidth = totalWidth / tabs.length;
                    double left = controller.selectedIndex.value * tabWidth;
                  
                    return ViewResponseStackContainer(totalWidth: totalWidth, left: left, tabWidth: tabWidth, tabs: tabs, controller: controller);
                  }),
                  
                  SizedBox(height: 13,),
                  CustomResponseContainer(
onTap: () {
  Get.toNamed(RouteName.evaluateResponseScreen2);
},

                  ),
                  SizedBox(height: 13,),
              
                  CustomResponseContainer(
                    onTap: () {
  Get.toNamed(RouteName.viewScoreScreen);
},
              color1: AppColors.forwardColor,
              text1: "view_score".tr,
              image: Appimages.eye,
              text: "scored".tr,
              ishow: true,
              textColor: AppColors.whiteColor,
              
                  ),
                   SizedBox(height: 13,),
                  CustomResponseContainer(
                      onTap: () {
  Get.toNamed(RouteName.evaluateResponseScreen2);
},
                  ),
                  SizedBox(height: 13,),
              
                  CustomResponseContainer(
              color1: AppColors.forwardColor,
               text1: "view_score".tr,
              image: Appimages.eye,
              text: "scored".tr,
              ishow: true,
              textColor: AppColors.whiteColor,
              
                  ),
              
                  SizedBox(height: 30),
                  
                            BoldText(
                               text: "all_phases".tr,
                                fontSize: 16,
                                selectionColor: AppColors.blueColor),
                            CustomStratgyContainer(
                                
                        spaceHeight2: 20,

                        spaceHeight: 14,
                        
                        
                              
                              
                              
                            
   fontSize2: ResponsiveFont.getFontSizeCustom
                        
                        (
defaultSize: 14*widthScaleFactor
,smallSize: 10*widthScaleFactor
                        ),
                              iconContainer: AppColors.forwardColor,
                              icon: Icons.check,
                              width1: 277,
                            text1:  "phase1_strategy".tr, text2: "Completed • 20 min", text3: "completed".tr,
                                
                              smallContainer: AppColors.forwardColor,
                              largeConatiner: AppColors.forwardColor,
                              fontSize3: 10,
                          width3  :70
                            ),
                            SizedBox(height: 10),
                            CustomStratgyContainer(
                                mainHeight: 1.3,
                        fontSize: 14,
                        
                        
                        
                          
fontSize3: 10,
                          width3  :70,
                        spaceHeight2: 20,
                        spaceHeight: 14,
                              width1: 207,
                               width2: 70,
                              
                            
   fontSize2: ResponsiveFont.getFontSizeCustom
                        
                        (
defaultSize: 14*widthScaleFactor
,smallSize: 9*widthScaleFactor
                        ),
              
                              iconContainer: AppColors.selectLangugaeColor,
                              icon: Icons.play_arrow_rounded,
                            text1: "phase2_strategy".tr ,text2: "Active • 30 min", text3: "active".tr,
                              smallContainer: AppColors.selectLangugaeColor,
                              largeConatiner: AppColors.selectLangugaeColor,
                            ),
                            SizedBox(height: 10),
                            CustomStratgyContainer(
                              fontSize3: 10,
                          width3  :70,
                              
                        spaceHeight2: 20,
                        spaceHeight: 14,
                              width1: 207,
                               width2: 70,
                              iconContainer: AppColors.watchColor,
                              
                            
   fontSize2: ResponsiveFont.getFontSizeCustom
                        
                        (
defaultSize: 14*widthScaleFactor
,smallSize: 10*widthScaleFactor
                        ),
                              icon: Icons.watch_later,
                           text1: "phase3_implementation".tr, text2: "Upcoming • 25 min", text3: "pending".tr,
                              smallContainer: AppColors.watchColor,
                              largeConatiner: AppColors.greyColor,
                            ),
                            SizedBox(height: 10),
                            CustomStratgyContainer(
                              fontSize3: 10,
                          width3  :70,
                                  
                                
                        spaceHeight2: 20,
                        spaceHeight: 14,
                              width1: 207,
                               width2: 70,
                              iconContainer: AppColors.watchColor,
                            
   fontSize2: ResponsiveFont.getFontSizeCustom
                        
                        (
defaultSize: 14*widthScaleFactor
,smallSize: 10*widthScaleFactor
                        ),
                              icon: Icons.watch_later,
                            text1: "phase4_evaluation".tr,text2: "Upcoming • 15 min", text3: "pending".tr,
                              smallContainer: AppColors.watchColor,
                              largeConatiner: AppColors.greyColor,
                            ),
                            SizedBox(height: 25),
                  
                            
                  
                  
                  
                    ],
                  ),
                ),
              ),

              
        
         Positioned(
          right: 0,
          top: screenHeight * 0.2,
          child: TeamAlphaContainer(screenWidth: screenWidth, screenHeight: screenHeight),
        ),

        
       
      
            ],
          ),
        ),
      ),
    );
  }
}
