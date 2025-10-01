
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/controllers/game_select_controller.dart';
import 'package:scorer/widgets/custom_stratgy_container.dart';

class PhaseStrategyColumn extends StatelessWidget {
  const PhaseStrategyColumn({
    super.key,
    required this.widthScaleFactor,
    required this.heightScaleFactor,
    required this.controller,
  });

  final double widthScaleFactor;
  final double heightScaleFactor;
  final GameSelectController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
     children: [
         CustomStratgyContainer(
                          
                          fontSize2: ResponsiveFont.getFontSizeCustom(
                            defaultSize: 14*widthScaleFactor,
                            smallSize: 10*widthScaleFactor
                          ),
    
                          width3: 80,
                          iconContainer: AppColors.forwardColor, icon: Icons.check, text1:  "phase1_strategy".tr, text2: "Completed • 20 min", text3: "completed".tr, smallContainer: AppColors.forwardColor, largeConatiner: AppColors.forwardColor,
                        flex: 3,flex1: 0,
                        ),
       SizedBox(height: 10 * heightScaleFactor),
       if (controller.currentPhase.value >= 1)
        CustomStratgyContainer(
                          
    
    
       fontSize2: ResponsiveFont.getFontSizeCustom(
                            defaultSize: 14*widthScaleFactor,
                            smallSize: 10*widthScaleFactor
                          ),
    
                          
                          
                          iconContainer: AppColors.selectLangugaeColor, icon: Icons.play_arrow_sharp, text1: "phase2_strategy".tr ,text2: "Active • 30 min", text3: "active".tr, smallContainer: AppColors.selectLangugaeColor, largeConatiner: AppColors.selectLangugaeColor,
                 
                        )
       else
         CustomStratgyContainer(
    
       fontSize2: ResponsiveFont.getFontSizeCustom(
                            defaultSize: 14*widthScaleFactor,
                            smallSize: 10*widthScaleFactor
                          ),
           iconContainer: AppColors.selectLangugaeColor,
           icon: Icons.play_arrow_sharp,
           text1: "phase2_strategy".tr ,
           text2: "Upcoming • 25 min",
           text3: "Active",
           smallContainer: AppColors.selectLangugaeColor,
           largeConatiner: AppColors.selectLangugaeColor,
         ),
       SizedBox(height: 10 * heightScaleFactor),
       if (controller.currentPhase.value >= 2)
         CustomStratgyContainer(
    
       fontSize2: ResponsiveFont.getFontSizeCustom(
                            defaultSize: 14*widthScaleFactor,
                            smallSize: 10*widthScaleFactor
                          ),
           iconContainer: AppColors.forwardColor,
           icon: Icons.check,
           text1: "phase3_implementation".tr,
           text2: "Completed • 20 min",
           text3: "Completed",
           smallContainer: AppColors.forwardColor,
           largeConatiner: AppColors.forwardColor,
           flex: 4,
           flex1: 0,
         )
       else
         CustomStratgyContainer(
    
       fontSize2: ResponsiveFont.getFontSizeCustom(
                            defaultSize: 14*widthScaleFactor,
                            smallSize: 10*widthScaleFactor
                          ),
           iconContainer: AppColors.watchColor,
           icon: Icons.watch_later,
           text1: "phase3_implementation".tr,
           text2: "Upcoming • 25 min",
           text3: "Pending",
           smallContainer: AppColors.watchColor,
           largeConatiner: AppColors.greyColor,
           flex: 4,
           flex1: 0,
         ),
       SizedBox(height: 10 * heightScaleFactor),
       if (controller.currentPhase.value >= 2)
         CustomStratgyContainer(
    
       fontSize2: ResponsiveFont.getFontSizeCustom(
                            defaultSize: 14*widthScaleFactor,
                            smallSize: 10*widthScaleFactor
                          ),
           iconContainer: AppColors.selectLangugaeColor,
           icon: Icons.play_arrow_sharp,
         text1: "phase4_evaluation".tr,
           text2: "Upcoming • 15 min",
           text3: "Active",
           smallContainer: AppColors.selectLangugaeColor,
           largeConatiner: AppColors.selectLangugaeColor,
         )
       else
         CustomStratgyContainer(
    
       fontSize2: ResponsiveFont.getFontSizeCustom(
                            defaultSize: 14*widthScaleFactor,
                            smallSize: 10*widthScaleFactor
                          ),
           iconContainer: AppColors.watchColor,
           icon: Icons.watch_later,
          text1: "phase4_evaluation".tr,
           text2: "Upcoming • 15 min",
           text3: "Pending",
           smallContainer: AppColors.watchColor,
           largeConatiner: AppColors.greyColor,
           flex: 4,
           flex1: 0,
         ),
     ],
    );
  }
}
