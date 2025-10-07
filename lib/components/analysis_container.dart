


















































                                                      









                                                      





                                                  

















                                                      









                                                      





                                                  

















                                                      









                                                      





                                                  







                              
                              




















                                   



































import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';

class AnalysisContainer extends StatelessWidget {
  final double? height;
  final bool ishow;

  const AnalysisContainer({super.key, this.height, this.ishow = false});

  @override
  Widget build(BuildContext context) {
    
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    
    const double baseWidth = 414.0;
    const double baseHeight = 896.0;

    
    final double scaleWidth = screenWidth / baseWidth;
    final double scaleHeight = screenHeight / baseHeight;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: height ?? 430 .h,
          width: 330 .w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24 * scaleWidth),
            border: Border.all(color: AppColors.greyColor, width: 1.7 * scaleWidth),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 62 * scaleHeight,
                right: 110 * scaleWidth,
                child: SvgPicture.asset(Appimages.arrowdown),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16 * scaleWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20 .h),
                    Center(
                      child: BoldText(
                        text:  "ai_analysis_suggestion".tr,
                        fontSize: 16 .sp,
                        selectionColor: AppColors.blueColor,
                      ),
                    ),
                    SizedBox(height: 28 * scaleHeight),
                    Center(
                      child: Image.asset(
                        Appimages.ai2,
                        width: 46 .w,
                        height: 46 .h,
                      ),
                    ),
                    SizedBox(height: 20 * scaleHeight),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BoldText(
                        text: "relevance_to_question".tr,
                          selectionColor: AppColors.blueColor,
                          fontSize: 16 .sp,
                        ),
                        BoldText(
                          text: "95%",
                          selectionColor: AppColors.blueColor,
                          fontSize: 16 .sp,
                        ),
                      ],
                    ),
                    SizedBox(height: 10 * scaleHeight),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            width: 220 .w,
                            height: 6 .h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20 * scaleWidth),
                                topLeft: Radius.circular(20 * scaleWidth),
                              ),
                              color: AppColors.forwardColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 44 .w,
                            height: 6 .h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20 * scaleWidth),
                                topRight: Radius.circular(20 * scaleWidth),
                              ),
                              color: AppColors.greyColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30 * scaleHeight),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BoldText(
                          text: "strategic_depth".tr,
                          selectionColor: AppColors.blueColor,
                          fontSize: 16 .sp,
                        ),
                        BoldText(
                          text: "85%",
                          selectionColor: AppColors.blueColor,
                          fontSize: 16 * scaleWidth,
                        ),
                      ],
                    ),
                    SizedBox(height: 10 * scaleHeight),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: 180 .w,
                            height: 6 .h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20 * scaleWidth),
                                topLeft: Radius.circular(20 * scaleWidth),
                              ),
                              color: AppColors.percenColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: 84 .w,
                            height: 6 .h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20 * scaleWidth),
                                topRight: Radius.circular(20 * scaleWidth),
                              ),
                              color: AppColors.greyColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30 * scaleHeight),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BoldText(
                         text: "implementation_clarity".tr,
                          selectionColor: AppColors.blueColor,
                          fontSize: 16 .sp,
                        ),
                        BoldText(
                          text: "42%",
                          selectionColor: AppColors.blueColor,
                          fontSize: 16 .sp,
                        ),
                      ],
                    ),
                    SizedBox(height: 10 * scaleHeight),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 130 .w,
                            height: 6 .h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20 * scaleWidth),
                                topLeft: Radius.circular(20 * scaleWidth),
                              ),
                              color: AppColors.orangeColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            width: 134 .w,
                            height: 6 .h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20 * scaleWidth),
                                topRight: Radius.circular(20 * scaleWidth),
                              ),
                              color: AppColors.greyColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 25 * scaleHeight),
                  MainText(
  text: "ai_suggested_score".tr,
  fontSize: 14 .sp,
  height: 1.2,
),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (ishow)
          Positioned(
            bottom: -75 * scaleHeight,
            left: 57 * scaleWidth,
            right: 57 * scaleWidth,
            child: Container(
              height: 181 .h, 
              width: 181 .w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.forwardColor,
                    Colors.grey.shade200,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(3 * scaleWidth),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 202, 202, 202),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BoldText(
                      text: "89/100",
                      fontSize: 30.sp,
                      selectionColor: AppColors.createBorderColor,
                    ),
                    SizedBox(height: 4 * scaleHeight),
                    BoldText(
                       text: "final_score".tr,

                      fontSize: 16 .sp,
                      selectionColor: AppColors.blueColor,
                    )
                  ],
                ),
              ),
            ),
          )
        else
          SizedBox.shrink(),
      ],
    );
  }
}