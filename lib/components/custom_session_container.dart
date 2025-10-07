import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';

import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/session_useable_row.dart';
class CustomSessionContainer extends StatelessWidget {
  const CustomSessionContainer({
    super.key,
    required this.heightScaleFactor,
    required this.widthScaleFactor,
  });

  final double heightScaleFactor;
  final double widthScaleFactor;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: 355 .h,
      width: 330 .w,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.greyColor,
          width: 1.5 * widthScaleFactor,
        ),
        borderRadius: BorderRadius.circular(24 * widthScaleFactor),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16 * widthScaleFactor),
        child: Column(
          children: [
            SizedBox(height: 20 * heightScaleFactor),
            BoldText(
             text: "session_statistics".tr,
              selectionColor: AppColors.blueColor,
              fontSize: 16 * widthScaleFactor,
            ),
            SizedBox(height: 30 * heightScaleFactor),
            SessionUseableRow(
fontsize2: ResponsiveFont.getFontSizeCustom(
  defaultSize: 10 *widthScaleFactor,
  smallSize: 9*widthScaleFactor
),
              
fontSize:ResponsiveFont.getFontSizeCustom(
  defaultSize: 10*widthScaleFactor,
  smallSize: 9*widthScaleFactor,
),
              iamge: Appimages.phone1,
              text: "average_score".tr,
              text2: "across_all_players".tr,
              tex3: "2,890",
              tex4: "pts",
            ),
            SizedBox(height: 25 * heightScaleFactor),
            SessionUseableRow(


              fontSize: ResponsiveFont.getFontSizeCustom(
defaultSize: 10*widthScaleFactor
,smallSize: 9*widthScaleFactor,
              ),
                fontsize2: ResponsiveFont.getFontSizeCustom(
defaultSize: 10*widthScaleFactor
,smallSize: 8*widthScaleFactor,
              ),
              iamge: Appimages.phone2,
              text: "top_performer".tr,
              
              text2: "highest_scoring_player".tr,
              tex3: "Alex M.",
              tex4: "2890 points",
            ),
            SizedBox(height: 25 * heightScaleFactor),
            SessionUseableRow(
fontsize2: ResponsiveFont.getFontSizeCustom(
  defaultSize: 10*widthScaleFactor,
  smallSize: 9*widthScaleFactor,
),
              
fontSize:ResponsiveFont.getFontSizeCustom(
  defaultSize: 10*widthScaleFactor,
  smallSize: 9*widthScaleFactor,
),
              iamge: Appimages.phone3,
              text: "completion_rate".tr,
              text2: "players_finished".tr,
              tex3: "100%",
              tex4: "12/12 players",
            ),
            SizedBox(height: 25 * heightScaleFactor),
            SessionUseableRow(
fontsize2: ResponsiveFont.getFontSizeCustom(
  defaultSize: 10*widthScaleFactor,
  smallSize: 9*widthScaleFactor,
),
              
fontSize:ResponsiveFont.getFontSizeCustom(
  defaultSize: 10*widthScaleFactor,
  smallSize: 9*widthScaleFactor,
),
              iamge: Appimages.phone4,
              text: "participation_rate".tr,
              text2: "participation_rate".tr,
              tex3: "100%",
              tex4: "Very high",
            ),
          ],
        ),
      ),
    );
  }
}
