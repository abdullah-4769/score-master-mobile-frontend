// lib/widgets/custom_response_container.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/useable_container.dart';

class CustomResponseContainer extends StatelessWidget {
  final String? text;
  final bool ishow;
  final Color? color1;
  final String? text1;
  final String? image;
  final Color? textColor;
  final double? containerHeight;
  final double? containerWidth;
  final bool ishow1;
  final VoidCallback? onTap;

  // Dynamic parameters
  final String? playerName;
  final String? questionText;
  final String? answer;
  final int? score;
  final bool isScored;
  final int? questionPoints; // NEW - Add this

  final VoidCallback? onEvaluateTap;
  final VoidCallback? onViewScoreTap;
  final bool showEvaluate;
  final bool showViewScore;

  const CustomResponseContainer({
    super.key,
    this.text,
    this.ishow = false,
    this.color1,
    this.text1,
    this.image,
    this.textColor,
    this.containerHeight,
    this.containerWidth,
    this.ishow1 = true,
    this.onTap,
    this.questionPoints, // NEW

    this.playerName,
    this.questionText,
    this.answer,
    this.score,
    this.isScored = false,
    this.onEvaluateTap,
    this.onViewScoreTap,
    this.showEvaluate = true,
    this.showViewScore = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final double baseHeight = 896.0;
    final double baseWidth = 414.0;
    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;

    final double scaleWidth = screenWidth / baseWidth;
    final double scaleHeight = screenHeight / baseHeight;
    bool isSpanish = Get.locale?.languageCode == 'es';

    // Dynamic height calculation
    double baseContainerHeight = containerHeight ?? 226 * scaleHeight;
    double extraHeight = 0;

    if (questionText != null && questionText!.length > 50) {
      extraHeight += 20 * scaleHeight;
    }
    if (answer != null && answer!.length > 50) {
      extraHeight += 30 * scaleHeight;
    }

    final dynamicHeight = baseContainerHeight + extraHeight;

    final String teamTimeFallback = "Team Beta 3:42 PM";

    final buttonColor = isScored ? AppColors.forwardColor : AppColors.greyColor;
    final buttonTextColor = isScored ? AppColors.whiteColor : null;
    final buttonText = showViewScore ? "view_score".tr : "evaluate".tr;
    final buttonImage = showViewScore ? Appimages.eye : Appimages.star;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: dynamicHeight,
          width: containerWidth ?? 346 * scaleWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24 * scaleWidth),
            border: Border.all(
                color: AppColors.greyColor, width: 1.7 * scaleWidth),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17 * scaleWidth),
            child: Column(
              children: [
                SizedBox(height: 16 * scaleHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          Appimages.blackgirl,
                          height: 47 * scaleHeight,
                          width: 35 * scaleWidth,
                        ),
                        SizedBox(width: 3 * scaleWidth),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MainText(
                              text: playerName ?? "Sarah Johnson",
                              fontSize: 14 * scaleWidth,
                            ),
                            MainText(
                              text: teamTimeFallback,
                              color: AppColors.teamColor,
                              fontSize: 13 * scaleWidth,
                              height: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Inside CustomResponseContainer build method, replace the score display section:

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (score != null || (questionText != null))
                          UseableContainer(
                            text: score != null ? "$score" : "5", // Default question point or pass from parent
                            fontFamily: "giory",
                            fontSize: 14 * scaleWidth,
                            width: 37 * scaleWidth,
                            height: 28 * scaleHeight,
                            color: score != null ? AppColors.orangeColor : AppColors.orangeColor,
                          ),
                        SizedBox(width: 4 * scaleWidth),

                        UseableContainer(
                          text: text ?? "pending".tr,
                          height: 28 * scaleHeight,
                          width: 75 * scaleWidth,
                          color: color1 ?? AppColors.yellowColor,
                          textColor: textColor ?? AppColors.languageTextColor,
                          fontSize: isSpanish ? 10 : 12 * scaleWidth,
                        ),
                        // Show score if available, otherwise show question points

                      ],
                    ),
                  ],
                ),
                SizedBox(height: 17 * scaleHeight),

                // Dynamic Question Text with proper overflow handling
                if (questionText != null)
                  MainText(
                    text: questionText!,
                    fontSize: ResponsiveFont.getFontSizeCustom(
                      defaultSize: 12 * widthScaleFactor,
                      smallSize: 10 * widthScaleFactor,
                    ),
                    height: 1.3,
                    maxLines: 3,
                   // overflow: TextOverflow.ellipsis,
                  ),
                if (questionText != null) SizedBox(height: 8 * scaleHeight),

                // Dynamic Answer Text with proper overflow handling
                if (answer != null)
                  MainText(
                    text: "Answer: $answer",
                    color: AppColors.languageColor.withOpacity(0.7),
                    fontSize: ResponsiveFont.getFontSizeCustom(
                      defaultSize: 12 * widthScaleFactor,
                      smallSize: 10 * widthScaleFactor,
                    ),
                    height: 1.3,
                    maxLines: 3,
                   // overflow: TextOverflow.ellipsis,
                  ),


                const Spacer(),

                // Conditional Button
                if (ishow1 && (showEvaluate || showViewScore))
                  LoginButton(
                    fontSize: 14 * scaleWidth,
                    fontFamily: "refsan",
                    imageHeight: 17 * scaleHeight,
                    imageWidth: 18 * scaleWidth,
                    text: buttonText,
                    height: 45 * scaleHeight,
                    width: 300 * scaleWidth,
                    radius: 12 * scaleWidth,
                    image: buttonImage,
                    color: AppColors.blueColor,
                    ishow: true,
                    onTap: showEvaluate ? onEvaluateTap : onViewScoreTap,
                  )
                else
                  const SizedBox.shrink(),

                SizedBox(height: 20 * scaleHeight),
              ],
            ),
          ),
        ),
        if (ishow)
          Positioned(
            top: 70 * scaleHeight,
            right: 14 * scaleWidth,
            child: Image.asset(
              Appimages.ai2,
              height: 38 * scaleHeight,
              width: 38 * scaleWidth,
            ),
          ),
        if (ishow)
          Positioned(
            top: 60 * scaleHeight,
            right: -6 * scaleWidth,
            child: SvgPicture.asset(
              Appimages.arrowdown,
              height: 22 * scaleHeight,
              width: 20 * scaleWidth,
            ),
          ),
      ],
    );
  }
}