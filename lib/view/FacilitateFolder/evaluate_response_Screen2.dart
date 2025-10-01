




























































              









                    

























































































      















































































               








import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/analysis_container.dart';
import 'package:scorer/components/audio_container.dart';
import 'package:scorer/components/evaluate_response__team_progress_container.dart';
import 'package:scorer/components/evaluate_response_score_break_container.dart';
import 'package:scorer/components/feedback_container.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/components/team_Alpha_Container.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';

import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/custom_response_container.dart';
import 'package:scorer/widgets/custom_sloder_row.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/useable_container.dart';

class EvaluateResponseScreen2 extends StatelessWidget {
  const EvaluateResponseScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    
    const double baseHeight = 812.0;
    const double baseWidth = 414.0;
    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;
    bool isSpanish = Get.locale?.languageCode == 'es';


    return Scaffold(
      body: GradientBackground(
        
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
            padding: EdgeInsets.symmetric(horizontal: 30 * widthScaleFactor),

                
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
                          text: "evaluate_response".tr,
                          selectionColor: AppColors.blueColor,
                        ),
                      ),
                    ],
                  ),
                ), SizedBox(height: 27 * heightScaleFactor),
                      CustomResponseContainer(
                        ishow1: false,
                        containerHeight: 160 * heightScaleFactor,
                        color1: AppColors.yellowColor,
                        text1: "view_score".tr,
                        image: Appimages.eye,
                        text: "pending".tr,
                        ishow: true,
                        textColor: AppColors.languageTextColor,
                      ),
                      SizedBox(height: 12 * heightScaleFactor),
                      BoldText(
                        text: "relevance_threshold".tr,

                        fontSize: 16 * widthScaleFactor,
                        selectionColor: AppColors.forwardColor,
                      ),
                      SizedBox(height: 22 * heightScaleFactor),
                      Container(
                        height: 630 * heightScaleFactor,
                        width: 376 * widthScaleFactor,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.greyColor, width: 1.7 * widthScaleFactor),
                          borderRadius: BorderRadius.circular(24 * widthScaleFactor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20 * widthScaleFactor),
                          child: Column(
                            children: [
                              SizedBox(height: 20 * heightScaleFactor),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                 BoldText(
  text: "your_evaluation".tr,
  selectionColor: AppColors.blueColor,
  fontSize: 16 * widthScaleFactor, 
),
                                  UseableContainer(
                                    text: "completed".tr,
                                    width: 83 * widthScaleFactor,
                                    color: AppColors.forwardColor,
                                  )
                                ],
                              ),
                              SizedBox(height: 25 * heightScaleFactor),
                              Container(
                                height: 74 * heightScaleFactor,
                                width: 337 * widthScaleFactor,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.greyColor, width: 1.7 * widthScaleFactor),
                                  borderRadius: BorderRadius.circular(24 * widthScaleFactor),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 19 * widthScaleFactor, top: 22 * heightScaleFactor),
                                  child: BoldText(
                                    text: "85",
                                    fontSize: 22 * widthScaleFactor,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15 * heightScaleFactor),
                              Container(
                                height: 209 * heightScaleFactor,
                                width: 337 * widthScaleFactor,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.greyColor, width: 1.7 * widthScaleFactor),
                                  borderRadius: BorderRadius.circular(24 * widthScaleFactor),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 19 * widthScaleFactor),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20 * heightScaleFactor),
                                     BoldText(
  text: "feedback_optional".tr,
  fontSize: 20 * widthScaleFactor,
),
                                      SizedBox(height: 6 * heightScaleFactor),
                                     MainText(
  text: "evaluation_text".tr,
  fontSize: 14 * widthScaleFactor,
  height: 1.1,
),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 15 * heightScaleFactor),
                              EvaluateResponseScoreBreakContainer(heightScaleFactor: heightScaleFactor, widthScaleFactor: widthScaleFactor),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12 * heightScaleFactor),
                      EvaluateResponseTeamProgressContainer(widthScaleFactor: widthScaleFactor, heightScaleFactor: heightScaleFactor),
                      SizedBox(height: 200 * heightScaleFactor),
                      FeedbackContainer(ishow: true),
                      SizedBox(height: 12 * heightScaleFactor),
                      AudioContainer(),
                      SizedBox(height: 12 * heightScaleFactor),
                      AnalysisContainer(),
                      SizedBox(height: 26 * heightScaleFactor),
                      LoginButton(
                        onTap: () {
                  Get.toNamed(RouteName.evaluateResponseScreen);
                },
                        text:  "accept_ai_score".tr,
                        color: AppColors.forwardColor,
                        image: Appimages.ai2,
                        ishow: true,
                        
  fontSize:ResponsiveFont.getFontSizeCustom(
    defaultSize: 18.sp,
    smallSize: 16.sp,
  ),

                          
                        imageHeight: 38 .h,
                        imageWidth: 32 .w,
                        
                      ),
                                          SizedBox(height: 20.h),

                      LoginButton(
                        onTap: () {
                  Get.toNamed(RouteName.overViewOptionScreen);
                },
                       text: "move_next_stage".tr,
                        ishow: true,
                          
                        imageHeight: 22 .h,
                        imageWidth: 26 .w,
                        icon: Icons.fast_forward,
                        
                        
  fontSize:ResponsiveFont.getFontSizeCustom(
    defaultSize: 18.sp,
    smallSize: 16.sp,
  ),



                          
                      ),
                      SizedBox(height: 20.h),
                      LoginButton(
                        
  

  fontSize:ResponsiveFont.getFontSizeCustom(
    defaultSize: 18.sp,
    smallSize: 16.sp,
  ),

                          
                      text: "export_pdf".tr,
                        ishow: true,
                        imageHeight: 18 .h,
                        imageWidth: 18 .w,
                        image: Appimages.export,
                        
                        color: AppColors.redColor,
                      ),
                                           SizedBox(height: 20.h),

                      LoginButton(
                     text: "edit_score_feedback".tr,
                        
  
  fontSize:ResponsiveFont.getFontSizeCustom(
    defaultSize: 18.sp,
    smallSize: 16.sp,
  ),


                        ishow: true,
                        imageHeight: 22.h,
                        imageWidth: 22 .w,
                        icon: Icons.edit,
                        
                        color: AppColors.orangeColor,
                      ),
                         Text("version 3.0"),
                      SizedBox(height: 100 * heightScaleFactor),


                   

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
