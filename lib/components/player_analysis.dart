
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/useable_container.dart';

class PlayerAnalyasis extends StatelessWidget {
  const PlayerAnalyasis({
    super.key,
    required this.scaleFactor,
  });

  final double scaleFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 510 * scaleFactor,
      width: 330 * scaleFactor,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.greyColor,
          width: 1.5 * scaleFactor,
        ),
        borderRadius: BorderRadius.circular(24 * scaleFactor),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15 * scaleFactor),
            child: Column(
              children: [
                SizedBox(height: 27 * scaleFactor),
                BoldText(
                  text: "ai_analysis_suggestion".tr,
                  fontSize: 16 * scaleFactor,
                  selectionColor: AppColors.blueColor,
                ),
                SizedBox(height: 28 * scaleFactor),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      right: -10 * scaleFactor,
                      top: -10 * scaleFactor,
                      child: SvgPicture.asset(Appimages.arrowdown),
                    ),
                    Container(
                      child: Image.asset(Appimages.ai2),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BoldText(
                     text: "relevance_score".tr,
                      fontSize: 16 * scaleFactor,
                      selectionColor: AppColors.blueColor,
                    ),
                    UseableContainer(
                      text: "78",
                      fontFamily: "giory",
                      fontSize: 14 * scaleFactor,
                      width: 37 * scaleFactor,
                      height: 28 * scaleFactor,
                      color: AppColors.orangeColor,
                    )
                  ],
                ),
              MainText(
      text: "response_address_prompt".tr,
      fontSize: 14 * scaleFactor,
      height: 1.3,
    ),
    
                SizedBox(height: 10 * scaleFactor),
                Divider(
                  color: AppColors.greyColor,
                  thickness: 1 * scaleFactor,
                ),
                SizedBox(height: 20 * scaleFactor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  BoldText(
      text: "quality_assessment".tr,
      fontSize: 16 * scaleFactor,
      selectionColor: AppColors.blueColor,
    ),
                    
    UseableContainer(
      text: "high".tr,
      fontSize: 12 * scaleFactor,
      width: 46 * scaleFactor,
      height: 28 * scaleFactor,
      color: AppColors.forwardColor,
    ),
                  ],
                ),
                SizedBox(height: 10 * scaleFactor),
                MainText(
                  text: "Well-structured response with specific metrics and measurable outcomes.",
                  fontSize: 14 * scaleFactor,
                  height: 1.3,
                )
              ],
            ),
          ),
          Positioned(
            bottom: -70 * scaleFactor,
            left: 70 * scaleFactor,
            child: Container(
              height: 181 * scaleFactor,
              width: 181 * scaleFactor,
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
                margin: EdgeInsets.all(3 * scaleFactor),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 202, 202, 202),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BoldText(
                      text: "89/100",
                      fontSize: 30 .sp,
                      selectionColor: AppColors.createBorderColor,
                    ),
                    SizedBox(height: 4 * scaleFactor),
                   BoldText(
      text: "final_score".tr,
      fontSize: 16.sp,
      selectionColor: AppColors.blueColor,
    ),
    
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
