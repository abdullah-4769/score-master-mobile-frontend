
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/custom_sloder_row.dart';

class EvaluateResponseScoreBreakContainer extends StatelessWidget {
  const EvaluateResponseScoreBreakContainer({
    super.key,
    required this.heightScaleFactor,
    required this.widthScaleFactor,
  });

  final double heightScaleFactor;
  final double widthScaleFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220 * heightScaleFactor,
      width: 336 * widthScaleFactor,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyColor, width: 1.7 * widthScaleFactor),
        borderRadius: BorderRadius.circular(24 * widthScaleFactor),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 17 * widthScaleFactor, right: 15 * widthScaleFactor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20 * heightScaleFactor),
            BoldText(
      text: "scoring_breakdown".tr,
      fontSize: 16 * widthScaleFactor,
      selectionColor: AppColors.blueColor,
    ),
           SizedBox(height: 31 * heightScaleFactor),
    CustomSloderRow(
      
      
       fontSize: ResponsiveFont.getFontSizeCustom
                            
                            (
    defaultSize: 14 * widthScaleFactor
    ,smallSize: 11 * widthScaleFactor,
                            ),
      text: "clarity_specificity".tr, text2: "22/25"),
    SizedBox(height: 5 * heightScaleFactor),
    CustomSloderRow(
      
      
    
       fontSize: ResponsiveFont.getFontSizeCustom
                            
                            (
    defaultSize: 14 * widthScaleFactor
    ,smallSize: 11 * widthScaleFactor,
                            ),
      text: "strategic_thinking".tr, text2: "22/25"),
    SizedBox(height: 5 * heightScaleFactor),
    CustomSloderRow(
      
     fontSize: ResponsiveFont.getFontSizeCustom
                            
                            (
    defaultSize: 14 * widthScaleFactor
    ,smallSize: 11 * widthScaleFactor,
                            ),
      
    
      
      text: "feasibility".tr, text2: "22/25"),
    SizedBox(height: 5 * heightScaleFactor),
    CustomSloderRow(
      
      
     fontSize: ResponsiveFont.getFontSizeCustom
                            
                            (
    defaultSize: 14 * widthScaleFactor
    ,smallSize: 11 * widthScaleFactor,
                            ),
      
      text: "innovation".tr, text2: "22/25"),
          ],
        ),
      ),
    );
  }
}
