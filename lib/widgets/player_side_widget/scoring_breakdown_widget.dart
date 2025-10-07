import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../api/api_models/player_score_model.dart';
import '../../components/responsive_fonts.dart';
import '../../constants/appcolors.dart';
import '../bold_text.dart';
import '../custom_sloder_row.dart';

class ScoringBreakdownWidget extends StatelessWidget {
  final PlayerScoreModel? scoreData;
  final double scaleFactor;

  const ScoringBreakdownWidget({
    Key? key,
    required this.scoreData,
    this.scaleFactor = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (scoreData == null) {
      return Center(
        child: Text(
          "no_data_found".tr,
          style: TextStyle(
            color: AppColors.greyColor,
            fontSize: 14.sp,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30 * scaleFactor),
      child: Container(
        height: 215.h,
        width: 336.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.greyColor,
            width: 1.7 * scaleFactor,
          ),
          borderRadius: BorderRadius.circular(24 * scaleFactor),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 17 * scaleFactor,
            right: 15 * scaleFactor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20 * scaleFactor),
              BoldText(
                text: "scoring_breakdown".tr,
                selectionColor: AppColors.blueColor,
                fontSize: 16.sp,
              ),
              SizedBox(height: 5 * scaleFactor),
              _buildScoreRow("clarity_specificity".tr, scoreData!.charityScore),
              SizedBox(height: 5 * scaleFactor),
              _buildScoreRow("strategic_thinking".tr, scoreData!.strategicThinking),
              SizedBox(height: 5 * scaleFactor),
              _buildScoreRow("feasibility".tr, scoreData!.feasibilityScore),
              SizedBox(height: 5 * scaleFactor),
              _buildScoreRow("innovation".tr, scoreData!.innovationScore),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreRow(String title, int score) {
    const int maxScore = 25; // static for now, can be dynamic later
    return CustomSloderRow(
      fontSize: ResponsiveFont.getFontSizeCustom(
        defaultSize: 14.sp,
        smallSize: 11.sp,
      ),
      text: title,
      text2: "$score/$maxScore",
    );
  }
}






