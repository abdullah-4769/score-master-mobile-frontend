
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/controllers/game_select_controller.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';

class CompleteSessionRow extends StatelessWidget {
  const CompleteSessionRow({
    super.key,
    required this.widthScaleFactor,
    required this.controller,
  });

  final double widthScaleFactor;
  final GameSelectController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // First circle
        Container(
          height: 20 * widthScaleFactor,
          width: 20 * widthScaleFactor,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.forwardColor,
          ),
          child: Center(
            child: Icon(
              Icons.check,
              size: 17 * widthScaleFactor,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        SizedBox(width: 7 * widthScaleFactor),
        // First line
        Container(
          width: 120 * widthScaleFactor,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.forwardColor,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SizedBox(width: 7 * widthScaleFactor),
    
        // Second circle
        controller.currentPhase.value >= 1
            ? Container(
                height: 20 * widthScaleFactor,
                width: 20 * widthScaleFactor,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.forwardColor,
                ),
                child: Center(
                  child: Icon(
                    Icons.check,
                    size: 17 * widthScaleFactor,
                    color: AppColors.whiteColor,
                  ),
                ),
              )
            : Container(
                height: 20 * widthScaleFactor,
                width: 20 * widthScaleFactor,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.orangeColor,
                ),
                child: Center(
                  child: MainText(
                    text: "2",
                    color: AppColors.whiteColor,
                    fontSize: 11 * widthScaleFactor,
                  ),
                ),
              ),
        SizedBox(width: 7 * widthScaleFactor),
        // Second line
        Container(
          width: 120 * widthScaleFactor,
          height: 4,
          decoration: BoxDecoration(
            color: controller.currentPhase.value >= 2
                ? AppColors.forwardColor
                : AppColors.greyColor,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SizedBox(width: 7 * widthScaleFactor),
    
        // Third circle
        controller.currentPhase.value >= 2
            ? Container(
                height: 20 * widthScaleFactor,
                width: 20 * widthScaleFactor,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.forwardColor,
                ),
                child: Center(
                  child: Icon(
                    Icons.check,
                    size: 17 * widthScaleFactor,
                    color: AppColors.whiteColor,
                  ),
                ),
              )
            : Container(
                height: 20 * widthScaleFactor,
                width: 20 * widthScaleFactor,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.greyColor,
                ),
                child: Center(
                  child: MainText(
                    text: "3",
                    color: AppColors.whiteColor,
                    fontSize: 11 * widthScaleFactor,
                  ),
                ),
              ),
      ],
    );
  }
}
