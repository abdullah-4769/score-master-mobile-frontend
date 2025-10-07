
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/players_container.dart';
class AdminTeamProgress extends StatelessWidget {
  const AdminTeamProgress({
    super.key,
    required this.contentWidth,
    required this.screenHeight,
    required this.screenWidth,
    required this.verticalSpacing,
    // required this.controller,
  });

  final double contentWidth;
  final double screenHeight;
  final double screenWidth;
  final double verticalSpacing;
  // final StageController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: contentWidth,
      height: screenHeight * 0.69,
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: verticalSpacing),
              BoldText(
                 text: "team_progress".tr,
                  selectionColor: AppColors.blueColor,
                  fontSize: screenWidth * 0.04),
              SizedBox(height: screenHeight * 0.015),
         
          Row(
                  children: [
                    Expanded(
                      flex:  2,
                      child: Container(
                        height: screenHeight * 0.008,
                        decoration: BoxDecoration(
                          color: AppColors.forwardColor,
                          borderRadius: BorderRadius.circular(
                              screenWidth * 0.05),
                        ),
                      ),
                    ),
                    Expanded(
                      flex:  2,
                      child: Container(
                        height: screenHeight * 0.008,
                        decoration: BoxDecoration(
                          color: AppColors.greyColor,
                          borderRadius: BorderRadius.circular(
                              screenWidth * 0.05),
                        ),
                      ),
                    ),
                  ],
                ),
              
              SizedBox(height: screenHeight * 0.015),
             Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    BoldText(
                      text:  "4 of 5 submitted",
                      fontSize: screenWidth * 0.04,
                      selectionColor: AppColors.blueColor,
                    ),
                  ],
                ),
              SizedBox(height: verticalSpacing),
              PlayersContainers(
                  text1: "1",
                  text2: "You",
                  image: Appimages.play1),
              SizedBox(height: verticalSpacing * 0.7),
         PlayersContainers(
                    color: AppColors.yellowColor,
                    text3:"working".tr,
                    text1: "2",
                    text2: "Sarah J.",
                    image: Appimages.play2),
              SizedBox(height: verticalSpacing * 0.7),
              PlayersContainers(
                  text1: "3",
                  text2: "Mike C.",
                  image: Appimages.play3),
              SizedBox(height: verticalSpacing * 0.7),
              PlayersContainers(
                  text1: "4",
                  text2: "David B.",
                  image: Appimages.play4),
              SizedBox(height: verticalSpacing * 0.7),
              PlayersContainers(
                  text1: "5",
                  text2: "Lisa G.",
                  image: Appimages.play5),
            ],
          ),
        ),
      ),
    );
  }
}
