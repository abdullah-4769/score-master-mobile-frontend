
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/analysis_container.dart';
import 'package:scorer/components/evaluate_response__team_progress_container.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/components/team_Alpha_Container.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart'; 

import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/useable_container.dart';

class ViewScoreScreen extends StatelessWidget {
  const ViewScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    
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
                padding: EdgeInsets.symmetric(horizontal: 30 * widthScaleFactor),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 23 * heightScaleFactor),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        InkWell(
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
                          BoldText(
                            fontSize: ResponsiveFont.getFontSizeCustom(
                              defaultSize: 22 * widthScaleFactor,
                              smallSize: 20 * widthScaleFactor,
                            ),
                            text: "view_score".tr,
                            selectionColor: AppColors.blueColor,
                          ),
                          const SizedBox.shrink(), 
                        ],
                      ),
                      SizedBox(height: 27 * heightScaleFactor),
                      Container(
                        height: 171 * heightScaleFactor,
                        width: 336 * widthScaleFactor,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.greyColor, width: 1.7 * widthScaleFactor),
                          borderRadius: BorderRadius.circular(24 * widthScaleFactor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 19 * widthScaleFactor),
                          child: Column(
                            children: [
                              SizedBox(height: 16 * heightScaleFactor),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        Appimages.blackgirl,
                                        height: 47 * heightScaleFactor,
                                        width: 35 * widthScaleFactor,
                                      ),
                                      SizedBox(width: 3 * widthScaleFactor),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          MainText(text: "Alex Martinez", fontSize: 14 * widthScaleFactor),
                                          MainText(
                                            text: "Team Alpha",
                                            color: AppColors.teamColor,
                                            fontSize: 13 * widthScaleFactor,
                                            height: 1,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      UseableContainer(
                                        text: "submitted".tr,
                                        height: 20 * heightScaleFactor,
                                        fontSize: 11 * widthScaleFactor,
                                        width: 70 * widthScaleFactor,
                                        color: AppColors.forwardColor,
                                        textColor: AppColors.whiteColor,
                                      ),
                                      SizedBox(width: 4 * widthScaleFactor),
                                      UseableContainer(
                                        text: "94",
                                        fontFamily: "giory",
                                        fontSize: 14 * widthScaleFactor,
                                        width: 37 * widthScaleFactor,
                                        height: 28 * heightScaleFactor,
                                        color: AppColors.orangeColor,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 25 * heightScaleFactor),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      BoldText(
                                        text: "3:42 PM",
                                        fontSize: 24 * widthScaleFactor,
                                        selectionColor: AppColors.forwardColor,
                                      ),
                                      BoldText(
                                        text: "submitted".tr,
                                        selectionColor: AppColors.blueColor,
                                        fontSize: 16 * widthScaleFactor,
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 40 * widthScaleFactor),
                                  Column(
                                    children: [
                                      BoldText(
                                        text: "4:15 PM",
                                        fontSize: 24 * widthScaleFactor,
                                        selectionColor: AppColors.forwardColor,
                                      ),
                                      BoldText(
                                        text: "scored".tr,
                                        selectionColor: AppColors.blueColor,
                                        fontSize: 16 * widthScaleFactor,
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 18 * heightScaleFactor),
                      AnalysisContainer(height: 500 * heightScaleFactor, ishow: true),
                      SizedBox(height: 90 * heightScaleFactor),
                      BoldText(
                        text: "relevance_threshold".tr,
                        fontSize: 16 * widthScaleFactor,
                        selectionColor: AppColors.forwardColor,
                      ),
                      SizedBox(height: 22 * heightScaleFactor),
                     EvaluateResponseTeamProgressContainer(widthScaleFactor: widthScaleFactor, heightScaleFactor: heightScaleFactor),
                      SizedBox(height: 26 * heightScaleFactor),
                      LoginButton(
                        fontSize: ResponsiveFont.getFontSizeCustom(
                          defaultSize: 18 .sp,
                          smallSize: 15 .sp,
                        ),
                        onTap: () {
                          Get.toNamed(RouteName.overViewOptionScreen);
                        },
                        text: "move_next_stage".tr,
                        ishow: true,
                        imageHeight: 22 .h,
                        imageWidth: 26 .w,
                        icon: Icons.fast_forward,
                      ),
                      SizedBox(height: 15 * heightScaleFactor),
                      LoginButton(
                        fontSize: ResponsiveFont.getFontSizeCustom(
                          defaultSize: 18 .sp,
                          smallSize: 15 .sp,
                        ),
                        text: "Share Responses",
                        color: AppColors.forwardColor,
                        image: Appimages.move,
                        ishow: true,
                        imageHeight: 26 .h,
                        imageWidth: 30 .w,
                      ),
                      SizedBox(height: 15 * heightScaleFactor),
                      LoginButton(
                        fontSize: ResponsiveFont.getFontSizeCustom(
                          defaultSize: 18 .sp,
                          smallSize: 15 .sp,
                        ),
                        text: "export_pdf".tr,
                        ishow: true,
                        imageHeight: 18 .h,
                        imageWidth: 18 .w,
                        image: Appimages.export,
                        color: AppColors.redColor,
                      ),
                      SizedBox(height: 15 * heightScaleFactor),
                      LoginButton(
                        fontSize: ResponsiveFont.getFontSizeCustom(
                          defaultSize: 18.sp,
                          smallSize: 15 .sp,
                        ),
                        text: "edit_score_feedback".tr,
                        ishow: true,
                        imageHeight: 22.h,
                        imageWidth: 22 .w,
                        icon: Icons.edit,
                        color: AppColors.orangeColor,
                      ),
                      SizedBox(height: 39 * heightScaleFactor),
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