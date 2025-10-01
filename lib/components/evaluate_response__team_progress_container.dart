
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';

class EvaluateResponseTeamProgressContainer extends StatelessWidget {
  const EvaluateResponseTeamProgressContainer({
    super.key,
    required this.widthScaleFactor,
    required this.heightScaleFactor,
  });

  final double widthScaleFactor;
  final double heightScaleFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 640.h,
      width: 330 .w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24 * widthScaleFactor),
        border: Border.all(color: AppColors.greyColor, width: 1.5 * widthScaleFactor),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17 * widthScaleFactor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoldText(
                 text: "team_response".tr,
                  fontSize: 16 * widthScaleFactor,
                  selectionColor: AppColors.blueColor,
                ),
                SizedBox(height: 25 * heightScaleFactor),
                Row(
                  children: [
                    Image.asset(
                      Appimages.timeout2,
                      height: 19 * heightScaleFactor,
                      width: 19 * widthScaleFactor,
                    ),
                    MainText(
                      text: "2 min read",
                      fontSize: 14 * widthScaleFactor,
                      color: AppColors.teamColor,
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 20 * heightScaleFactor),
            MainText(
              text: "Primary Objective: Our primary objective is to increase customer satisfaction by 25% through improved service delivery and enhanced user experience across all touchpoints.",
              fontSize: 14 * widthScaleFactor,
              height: 1.2,
            ),
            SizedBox(height: 20 * heightScaleFactor),
                                     
    BoldText(
      text: "key_strategies".tr,
      fontSize: 16 * widthScaleFactor,
      selectionColor: AppColors.blueColor,
    ),
            SizedBox(height: 20 * heightScaleFactor),
           MainText(
      text: "feedback_system".tr,
      fontSize: 14 * widthScaleFactor,
      height: 1.2,
    ),
            SizedBox(height: 20 * heightScaleFactor),
           MainText(
      text: "reduce_response_time".tr,
      fontSize: 14 * widthScaleFactor,
      height: 1.2,
    ),
            SizedBox(height: 20 * heightScaleFactor),
           MainText(
      text: "enhance_self_service".tr,
      fontSize: 14 * widthScaleFactor,
      height: 1.2,
    ),
            SizedBox(height: 20 * heightScaleFactor),
            MainText(
      text: "alignment".tr,
      fontSize: 14 * widthScaleFactor,
      height: 1.2,
    ),
      
          ],
        ),
      ),
    );
  }
}