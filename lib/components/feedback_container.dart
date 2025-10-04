// lib/components/feedback_container.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';

class FeedbackContainer extends StatelessWidget {
  final bool ishow;
  final int? finalScore;
  final String? feedback;

  const FeedbackContainer({
    super.key,
    this.ishow = false,
    this.finalScore,
    this.feedback,
  });

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
          height: 297 * scaleHeight,
          width: 337 * scaleWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26 * scaleWidth),
            border: Border.all(
                color: AppColors.greyColor, width: 1.7 * scaleWidth),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 19 * scaleWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100 * scaleHeight),
                BoldText(
                  text: "ai_feedback".tr,
                  fontSize: 22 * scaleWidth,
                  selectionColor: AppColors.languageTextColor,
                ),
                MainText(
                  text: feedback ??
                      "Provide more detailed steps on how you would check and resolve the billing issue.",
                  fontSize: 14 * scaleWidth,
                  height: 1.3,
                  maxLines: 6,
                //  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -100 * scaleHeight,
          left: 70 * scaleWidth,
          child: Container(
            height: 181 * scaleWidth,
            width: 181 * scaleWidth,
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
                    text: "${finalScore ?? 89}/100",
                    fontSize: 30 * scaleWidth,
                    selectionColor: AppColors.createBorderColor,
                  ),
                  SizedBox(height: 4 * scaleHeight),
                  BoldText(
                    text: "final_score".tr,
                    fontSize: 16 * scaleWidth,
                    selectionColor: AppColors.blueColor,
                  )
                ],
              ),
            ),
          ),
        ),
        if (ishow)
          Positioned(
            top: -175 * scaleHeight,
            left: 195 * scaleWidth,
            child: SvgPicture.asset(
              Appimages.arrowdown,
              height: 38 * scaleHeight,
              width: 31 * scaleWidth,
            ),
          ),
        if (ishow)
          Positioned(
            top: -170 * scaleHeight,
            left: 110 * scaleWidth,
            child: Image.asset(
              Appimages.ai2,
              height: 116 * scaleHeight,
              width: 115 * scaleWidth,
            ),
          ),
      ],
    );
  }
}