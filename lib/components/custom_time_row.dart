import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';

import 'package:scorer/widgets/bold_text.dart';
class CustomTimeRow extends StatelessWidget {
  const CustomTimeRow({
    super.key,
    required this.heightScaleFactor,
    required this.widthScaleFactor,
  });

  final double heightScaleFactor;
  final double widthScaleFactor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 116 * heightScaleFactor,
            width: 105 * widthScaleFactor,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.greyColor,
                width: 1.7 * widthScaleFactor,
              ),
              borderRadius: BorderRadius.circular(24 * widthScaleFactor),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BoldText(
                  text: "2:98",
                  selectionColor: AppColors.redColor,
                  fontSize: 24 * widthScaleFactor,
                ),
                BoldText(
                   text: "time".tr,
                  fontSize: 16 * widthScaleFactor,
                  selectionColor: AppColors.blueColor,
                  textAlign: TextAlign.center,
                ),
                  BoldText(
                   text: "duration".tr,
                  fontSize: 16 * widthScaleFactor,
                  selectionColor: AppColors.blueColor,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10 * widthScaleFactor),
        Expanded(
          child: Container(
            height: 116 * heightScaleFactor,
            width: 105 * widthScaleFactor,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.greyColor,
                width: 1.7 * widthScaleFactor,
              ),
              borderRadius: BorderRadius.circular(24 * widthScaleFactor),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BoldText(
                  text: "12",
                  selectionColor: AppColors.forwardColor,
                  fontSize: 24 * widthScaleFactor,
                ),
                BoldText(
                  text: "active".tr,
                  textAlign: TextAlign.center,

                  fontSize: 16 * widthScaleFactor,
                  selectionColor: AppColors.blueColor,
                ),
                 BoldText(
                  text: "players".tr,
                  textAlign: TextAlign.center,

                  fontSize: 16 * widthScaleFactor,
                  selectionColor: AppColors.blueColor,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10 * widthScaleFactor),
        Expanded(
          child: Container(
            height: 116 * heightScaleFactor,
            width: 105 * widthScaleFactor,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.greyColor,
                width: 1.7 * widthScaleFactor,
              ),
              borderRadius: BorderRadius.circular(24 * widthScaleFactor),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BoldText(
                  text: "03",
                  selectionColor: AppColors.redColor,
                  fontSize: 24 * widthScaleFactor,
                ),
                BoldText(
                 text: "total".tr,
                  textAlign: TextAlign.center,

                  fontSize: 16 * widthScaleFactor,
                  selectionColor: AppColors.blueColor,
                ),
                  BoldText(
                 text: "phases".tr,
                  textAlign: TextAlign.center,

                  fontSize: 16 * widthScaleFactor,
                  selectionColor: AppColors.blueColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}