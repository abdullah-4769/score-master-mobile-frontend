
import 'package:flutter/material.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/main_text.dart';

class CustomContainer extends StatelessWidget {
  final String? text1;
  final String? text2;
  final Color? color;
  final double scaleFactor;

  const CustomContainer({
    super.key,
    this.text1,
    this.text2,
    this.color,
    required this.scaleFactor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50 * scaleFactor,
      width: 334 * scaleFactor,
      decoration: BoxDecoration(
        border:
            Border.all(color: AppColors.greyColor, width: 1.5 * scaleFactor),
        borderRadius: BorderRadius.circular(12 * scaleFactor),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23 * scaleFactor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MainText(
              text: text1 ?? "Default Time Limit per Phase",
              fontSize: 14 * scaleFactor,
              color: AppColors.teamColor,
            ),
            MainText(
              text: text2 ?? "20m",
              fontSize: 14 * scaleFactor,
              color: color ?? AppColors.teamColor,
            )
          ],
        ),
      ),
    );
  }
}