import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/useable_container.dart';

class GameUseAbleContainer extends StatelessWidget {
  final double widthScaleFactor;
  final double heightScaleFactor;

  const GameUseAbleContainer({
    super.key,
    required this.widthScaleFactor,
    required this.heightScaleFactor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 335 * widthScaleFactor,
      width: double.infinity,
      height: 184 * heightScaleFactor,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.greyColor,
          width: 1.5 * widthScaleFactor,
        ),
        borderRadius: BorderRadius.circular(12 * widthScaleFactor),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 10 * heightScaleFactor,
            left: -20 * widthScaleFactor,
            child: Image.asset(
              Appimages.game,
              width: 55 * widthScaleFactor,
              height: 55 * heightScaleFactor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 40 * widthScaleFactor,
              right: 20 * widthScaleFactor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 17 * heightScaleFactor),
                MainText(
                  text: "odyssee_des_okr".tr,
                  fontSize: 14 * widthScaleFactor,
                ),
                SizedBox(height: 5 * heightScaleFactor),
                MainText(
text: "okr_description".tr,                  fontSize: 14 * widthScaleFactor,
                  height: 1.3,
                  color: AppColors.teamColor,
                ),
                SizedBox(height: 8 * heightScaleFactor),
                Row(
                  children: [
                    UseableContainer(
                      fontSize: 9,
                      height: 26,
                      text: "ai_based".tr,
                      color: AppColors.orangeColor,
                      width: 75 * widthScaleFactor,
                    ),
                    SizedBox(width: 7 * widthScaleFactor),
                    UseableContainer(
                      fontSize: 9,
                      text: "active".tr,height: 26,
                      color: AppColors.forwardColor,
                    )
                  ],
                ),
                SizedBox(height: 18 * heightScaleFactor),
                Row(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          Appimages.player2,
                          height: 28 * heightScaleFactor,
                          width: 26 * widthScaleFactor,
                        ),
                        MainText(
                          text: "12 Players",
                          fontSize: 12 * widthScaleFactor,
                        ),
                      ],
                    ),
                    SizedBox(width: 9 * widthScaleFactor),
                    Row(
                      children: [
                        Image.asset(
                          Appimages.timeout2,
                          height: 28 * heightScaleFactor,
                          width: 26 * widthScaleFactor,
                        ),
                        SizedBox(width: 6 * widthScaleFactor),
                        MainText(
                          text: "60 min duration",
                          fontSize: 12 * widthScaleFactor,
                          color: AppColors.redColor,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}