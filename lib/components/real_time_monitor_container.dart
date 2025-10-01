
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/useable_textrow.dart';
class RealTimeMonitorContainer extends StatelessWidget {
  const RealTimeMonitorContainer({
    super.key,
    required this.contentWidth,
    required this.screenHeight,
    required this.screenWidth,
    required this.verticalSpacing,
  });

  final double contentWidth;
  final double screenHeight;
  final double screenWidth;
  final double verticalSpacing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: contentWidth,
      height: screenHeight * 0.35,
      decoration: BoxDecoration(
        border: Border.all(
            color: AppColors.greyColor,
            width: screenWidth * 0.004),
        borderRadius:
            BorderRadius.circular(screenWidth * 0.06),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: verticalSpacing),
            BoldText(
                text: "real_time_monitoring".tr,                selectionColor: AppColors.blueColor,
                fontSize: screenWidth * 0.04),
            SizedBox(height: verticalSpacing),
            Row(
              children: [
                Container(
                  height: screenHeight * 0.005,
                  width: screenWidth * 0.45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          screenWidth * 0.05),
                      color: AppColors.forwardColor),
                ),
                Container(
                  height: screenHeight * 0.007,
                  width: screenWidth * 0.22,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          screenWidth * 0.05),
                      color: AppColors.greyColor),
                ),
              ],
            ),
            SizedBox(height: verticalSpacing),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                MainText(
                  // height: 1,
                  text: "player_engagement".tr,
                    fontSize: screenWidth * 0.04),
                BoldText(
                    text: "89%",
                    fontSize: screenWidth * 0.04,
                    selectionColor: AppColors.blueColor),
              ],
            ),
            SizedBox(height: verticalSpacing),
            MainText(
               text: "recent_activity".tr,
                fontSize: screenWidth * 0.04),
            // SizedBox(height: verticalSpacing * 0.5),
            UseableTextrow(
                color: AppColors.forwardColor,
                text: "Alex submitted response • 1m ago"),
            // SizedBox(height: verticalSpacing * 0.2),
            UseableTextrow(
                color: AppColors.forwardColor2,
                text: "Sarah joined team discussion • 2m ago"),
            // SizedBox(height: verticalSpacing * 0.2),
            UseableTextrow(
                color: AppColors.forwardColor3,
                text: "Mike went inactive • 5m ago"),
          ],
        ),
      ),
    );
  }
}
