
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/useable_container.dart';
class PhaseContainer extends StatelessWidget {
  const PhaseContainer({
    super.key,
    required this.horizontalPadding,
    required this.contentWidth,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double horizontalPadding;
  final double contentWidth;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
       final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;

    // A more direct way to get scaling factors
    final double baseHeight = 812.0;
    final double baseWidth = 414.0;
    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;

    // bool isSpanish = Get.locale?.languageCode == 'es';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Container(
        width: contentWidth,
        height: screenHeight * 0.13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          border: Border.all(
              color: AppColors.selectLangugaeColor,
              width: screenWidth * 0.004),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.025),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(Appimages.div,
                          width: screenWidth * 0.05),
                      SizedBox(width: screenWidth * 0.02),
                      UseableContainer(
                        text: "Phase 2",
                        color: AppColors.orangeColor,
                      ),
                      SizedBox(width: screenWidth * 0.02),
                     MainText(
  text: "strategy_building".tr,
  fontSize: ResponsiveFont.getFontSizeCustom(
defaultSize: 14*widthScaleFactor,
smallSize: 11*widthScaleFactor,
  )
                     ),
                    ],
                  ),
                  UseableContainer(
                      text: "active".tr,
                      color: AppColors.selectLangugaeColor),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              Padding(
                padding:
                    EdgeInsets.only(left: screenWidth * 0.08),
                child: MainText(
                  height: 1.5,
                    text: "team_collaboration_phase".tr,
                  color: AppColors.teamColor,
                  fontSize: screenWidth * 0.035,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
