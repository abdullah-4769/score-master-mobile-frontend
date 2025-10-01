
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/useable_textrow.dart';

class TipsContainer extends StatelessWidget {
  const TipsContainer({
    super.key,
    required this.scaleFactor,
    required this.widthScaleFactor,
  });

  final double scaleFactor;
  final double widthScaleFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 376 * scaleFactor,
      height: 271 * scaleFactor,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.greyColor,
          width: 1.5 * scaleFactor,
        ),
        borderRadius: BorderRadius.circular(24 * scaleFactor),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15 * scaleFactor),
        child: Column(
          children: [
            SizedBox(height: 30 * scaleFactor),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: AppColors.yellowColor,
                  size: 24 * scaleFactor,
                ),
                SizedBox(width: 9 * scaleFactor),
               
    BoldText(
      text: "tips_next_challenge".tr,
      selectionColor: AppColors.blueColor,
      fontSize: 16 * scaleFactor,
    ),
              ],
            ),
            SizedBox(height: 28 * scaleFactor),
           
    UseableTextrow(
      // fontsize11:ResponsiveFont.getFontSize() ,
      fontsize11:ResponsiveFont.getFontSizeCustom(
        smallSize: 9*widthScaleFactor*widthScaleFactor,
    defaultSize: 13*widthScaleFactor*widthScaleFactor
      ) ,
      height: 1.4,
      color: AppColors.forwardColor,
      text: "tip_contingency".tr,
    ),
            SizedBox(height: 20 * scaleFactor),
          UseableTextrow(
      fontsize11:ResponsiveFont.getFontSizeCustom(
        smallSize: 9*widthScaleFactor,
    defaultSize: 13*widthScaleFactor
      ) ,
    
      height: 1.4,
      color: AppColors.forwardColor,
      text: "tip_stakeholder".tr,
    ),
            SizedBox(height: 20 * scaleFactor),
          
    UseableTextrow(
      height: 1.4,
      fontsize11:ResponsiveFont.getFontSizeCustom(
        smallSize: 9*widthScaleFactor,
    defaultSize: 13*widthScaleFactor
      ) ,
      color: AppColors.forwardColor,
      text: "tip_quantify".tr,
    ),
          ],
        ),
      ),
    );
  }
}
