import 'package:flutter/material.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/useable_textrow.dart';
class AdminSessionContainer extends StatelessWidget {
  const AdminSessionContainer({
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
          height: screenHeight * 0.32,
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
                    text: "Session Timeline",
                    selectionColor: AppColors.blueColor,
                    fontSize: screenWidth * 0.04),
      SizedBox(height: verticalSpacing),
               
                UseableTextrow(
                    color: AppColors.forwardColor,
                    text: "Session Start: 12:20 PM"),
                // SizedBox(height: verticalSpacing * 0.2),
                UseableTextrow(
                    color: AppColors.forwardColor2,
                    text: "Current Time: 1:00 PM"),
                // SizedBox(height: verticalSpacing * 0.2),
                UseableTextrow(
                    color: AppColors.forwardColor3,
                    text: "Estimated End: 1:55 PM"),
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
    text: "40% Complete",
    fontSize: screenWidth * 0.036),
                    BoldText(
    text: "55 minutes remaining",
    fontSize: screenWidth * 0.035,
    selectionColor: AppColors.blueColor),
                  ],
                ),
    
              ],
            ),
          ),
        );
  }
}
