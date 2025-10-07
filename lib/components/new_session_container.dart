
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/pause_container.dart';
import 'package:scorer/widgets/useable_container.dart';

class NewSessionContainer extends StatelessWidget {
  const NewSessionContainer({
    super.key,
    required this.widthScaleFactor,
    required this.heightScaleFactor,
  });

  final double widthScaleFactor;
  final double heightScaleFactor;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isSpanish = Get.locale?.languageCode == 'es';


    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * widthScaleFactor),
      child: Column(
        children: [
          Container(
            width: 376 * widthScaleFactor,
            height: 179 * heightScaleFactor,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.greyColor, width: 1.5),
              borderRadius: BorderRadius.circular(24 * widthScaleFactor),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 20 * widthScaleFactor,
                right: 20 * widthScaleFactor,
                top: 15 * heightScaleFactor,
                bottom: 15 * heightScaleFactor,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainText(text: "session_code".tr, fontSize: ResponsiveFont.getFontSizeCustom(
                        defaultSize: 14.sp,
                        smallSize: 12.sp,

                      )),
                      Row(
                        children: [
                          BoldText(
                            text: "ABC123",
                            fontSize: 14 .sp,
                            selectionColor: AppColors.blueColor,
                          ),
                          SizedBox(width: 10 * widthScaleFactor),
                          SvgPicture.asset(Appimages.copy,
                              height: 16 * heightScaleFactor,
                              width: 16 * widthScaleFactor)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 6 * heightScaleFactor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainText(text: "join_link".tr,  fontSize: ResponsiveFont.getFontSizeCustom(
                        defaultSize: 14.sp,
                        smallSize: 12.sp,

                      )),

                      Row(
                        children: [
                          BoldText(
                            text: "https:/www.score.com",
                            fontSize: ResponsiveFont.getFontSizeCustom(
                              defaultSize: 14.sp,
                              smallSize: 12.sp,
                            ),
                            selectionColor: AppColors.blueColor,
                          ),
                          SizedBox(width: 10 * widthScaleFactor),
                          SvgPicture.asset(Appimages.move,
                              height: 16 * heightScaleFactor,
                              width: 16 * widthScaleFactor)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 6 * heightScaleFactor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainText(text: "started".tr, fontSize: ResponsiveFont.getFontSizeCustom(
                        defaultSize: 14.sp,
                        smallSize: 12.sp,

                      )),

                      BoldText(
                        text: "2:30 PM",
                        fontSize: 14.sp,
                        selectionColor: AppColors.blueColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 6 * heightScaleFactor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainText(text: "duration".tr, fontSize: ResponsiveFont.getFontSizeCustom(
                        defaultSize: 14.sp,
                        smallSize: 12.sp,

                      )),

                      BoldText(
                        text: "45 minutes",
                        fontSize: 14 .sp,
                        selectionColor: AppColors.blueColor,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20 * heightScaleFactor),
          Container(
            height: 220 * heightScaleFactor,
            width: 376 * widthScaleFactor,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.greyColor, width: 1.5),
              borderRadius: BorderRadius.circular(24 * widthScaleFactor),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 17 * heightScaleFactor,
                    right: 21 * widthScaleFactor,
                    left: 20 * widthScaleFactor,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BoldText(
                                text: "current_phase".tr,
                                fontSize: 16 * heightScaleFactor,
                                selectionColor: AppColors.blueColor,
                              ),
                              Row(
                                children: [
                                  UseableContainer(
                                    width: 70.w,
                                    text: "Phase 2",
                                    color: AppColors.orangeColor,
                                    fontSize: 10 .sp,

                                  ),
                                  SizedBox(width: 7* widthScaleFactor),
                                  MainText(
                                      text: "strategy_building".tr,
                                      fontSize: ResponsiveFont.getFontSizeCustom(
                                        defaultSize: 14.sp,
                                        smallSize: 12.sp,

                                      )
                                  )

                                ],
                              )
                            ],
                          ),
                          CircularPercentIndicator(
                            radius:  ResponsiveFont.getFontSizeCustom(
                              defaultSize: 40*widthScaleFactor,
                              smallSize: 34*widthScaleFactor,

                            ),
                            lineWidth: 4.0,
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
                                    fontSize: screenWidth * 0.04,
                                    selectionColor: AppColors.blueColor),
                                MainText(
                                  text: "remaining".tr,
                                  fontSize: screenWidth * 0.025,
                                  height: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20 * heightScaleFactor),
                      Row(
                        children: [
                          Container(
                            height: 6 * heightScaleFactor,
                            width: 200 * widthScaleFactor,
                            decoration: BoxDecoration(
                              color: AppColors.forwardColor,
                              borderRadius:
                              BorderRadius.circular(20 * widthScaleFactor),
                            ),
                          ),
                          Container(
                            height: 6 * heightScaleFactor,
                            width: 130 * widthScaleFactor,
                            decoration: BoxDecoration(
                              color: AppColors.greyColor,
                              borderRadius:
                              BorderRadius.circular(20 * widthScaleFactor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30 * heightScaleFactor),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: PauseContainer(
                              text: "pause".tr,

                              width: 140.w,
                            ),
                          ),
                          SizedBox(width: 20 * widthScaleFactor),
                          Expanded(
                            child: PauseContainer(
                              text: "next_phase".tr,
                              icon: Icons.fast_forward,
                              color: AppColors.forwardColor,

                              width: 140 .w,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20 * heightScaleFactor)
        ],
      ),
    );
  }
}
