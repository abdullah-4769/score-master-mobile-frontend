import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';

class ScenerioContainer extends StatelessWidget {
  final double heightScaleFactor;
  final double widthScaleFactor;
  final String text;
  final double? width;
  final double? height;
  final double? fontsize;

  const ScenerioContainer({
    super.key,
    required this.heightScaleFactor,
    required this.widthScaleFactor,
    this.text = '',
    this.width,
    this.height,
    this.fontsize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 347 * heightScaleFactor,
      width: width ?? 338 * widthScaleFactor,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyColor, width: 1.5),
        borderRadius: BorderRadius.circular(24 * widthScaleFactor),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20 * widthScaleFactor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30 * heightScaleFactor),
            BoldText(
              text: "scenario".tr,
              selectionColor: AppColors.blueColor,
              fontSize: 16 * heightScaleFactor,
            ),
            SizedBox(height: 15 * heightScaleFactor),
            MainText(
              height: 1.5,
              text: text.isNotEmpty ? text : "scenario_description".tr,
              fontSize: fontsize ?? 13 * heightScaleFactor,
            ),
          ],
        ),
      ),
    );
  }
}
