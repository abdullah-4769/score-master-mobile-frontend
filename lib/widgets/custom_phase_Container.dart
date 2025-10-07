




































import 'package:flutter/material.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/bold_text.dart';

class CustomPhaseContainer extends StatelessWidget {
  final String text1;
  final String text2;
  final double? fontSize;
  final Color? color;

  const CustomPhaseContainer({super.key, required this.text1, required this.text2, this.fontSize, this.color});

  @override
  Widget build(BuildContext context) {
    
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    const double baseWidth = 375.0; 
    final double scaleFactor = screenWidth / baseWidth;

    return Container(
      width: 337 * scaleFactor, 
      height: 74 * scaleFactor, 
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.greyColor,
          width: 1.5 * scaleFactor, 
        ),
        borderRadius: BorderRadius.circular(24 * scaleFactor), 
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 19 * scaleFactor), 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoldText(
              text: text1,
              fontSize: 18 * scaleFactor, 
            ),
            BoldText(
              text: text2,
              fontSize: fontSize ?? 18 * scaleFactor, 
              selectionColor: color,
            )
          ],
        ),
      ),
    );
  }
}