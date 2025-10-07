






























                        





















import 'package:flutter/material.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/main_text.dart';

class GameSelectUseableContainer extends StatelessWidget {
  final String text1;
  final String text2;
  final bool isSelected;
  final double?fontSize;
  const GameSelectUseableContainer({super.key, required this.text1, required this.text2, required this.isSelected, this.fontSize});

  @override
  Widget build(BuildContext context) {
    
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    const double baseWidth = 375.0; 
    final double scaleFactor = screenWidth / baseWidth;

    return Container(
      height: 74 * scaleFactor, 
      width: 334 * scaleFactor, 
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12 * scaleFactor), 
        border: Border.all(
          color: AppColors.greyColor,
          width: 1.5 * scaleFactor, 
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17 * scaleFactor), 
        child: Row(
          children: [
            Container(
              height: 24 * scaleFactor, 
              width: 24 * scaleFactor, 
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? AppColors.forwardColor : AppColors.greyColor,
                  width: isSelected ? 0 : 2 * scaleFactor, 
                ),
                shape: BoxShape.circle,
                color: isSelected ? AppColors.forwardColor : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      color: AppColors.whiteColor,
                      size: 15 * scaleFactor, 
                    )
                  : const SizedBox(),
            ),
            SizedBox(width: 10 * scaleFactor), 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainText(
                  text: text1,
                  fontSize: 14 * scaleFactor, 
                ),
                MainText(
                  text: text2,
                  fontSize:fontSize?? 13 * scaleFactor, 
                  color: AppColors.teamColor,
                  height: 1.5,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
