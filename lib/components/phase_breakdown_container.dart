import 'package:flutter/material.dart';
import 'package:scorer/constants/appcolors.dart';
// import 'package:scorer/view/startscreen/aa.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';
class PhaseBreakDownContainer extends StatelessWidget {
  const PhaseBreakDownContainer({
    super.key,
    required this.widthScaleFactor,
    required this.heightScaleFactor,
  });

  final double widthScaleFactor;
  final double heightScaleFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 336 * widthScaleFactor,
      height: 256 * heightScaleFactor,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30 * heightScaleFactor),
            BoldText(
              text: "Phase Breakdown",
              fontSize: 16 * widthScaleFactor,
              selectionColor: AppColors.blueColor,
            ),
            SizedBox(height: 19 * heightScaleFactor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 24 * heightScaleFactor,
                      width: 24 * widthScaleFactor,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.forwardColor,
                      ),
                      child: Icon(
                        Icons.check,
                        color: AppColors.whiteColor,
                        size: 15 * widthScaleFactor,
                      ),
                    ),
                    SizedBox(width: 6 * widthScaleFactor),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainText(
                          text: "Phase 1 - Strategy",
                          fontSize: 14 * widthScaleFactor,
                        ),
                        MainText(
                          text: "1h 12 minutes",
                          color: AppColors.teamColor,
                          fontSize: 12 * widthScaleFactor,
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                MainText(
                  text: "Avg: 850 pts",
                  fontSize: 13 * widthScaleFactor,
                )
              ],
            ),
            SizedBox(height: 19 * heightScaleFactor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 24 * heightScaleFactor,
                      width: 24 * widthScaleFactor,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.forwardColor,
                      ),
                      child: Icon(
                        Icons.check,
                        color: AppColors.whiteColor,
                        size: 15 * widthScaleFactor,
                      ),
                    ),
                    SizedBox(width: 6 * widthScaleFactor),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainText(
                          text: "Phase 2 - Execution",
                          fontSize: 14 * widthScaleFactor,
                        ),
                        MainText(
                          text: "1h 12 minutes",
                          color: AppColors.teamColor,
                          fontSize: 12 * widthScaleFactor,
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                MainText(
                  text: "Avg: 850 pts",
                  fontSize: 13 * widthScaleFactor,
                )
              ],
            ),
            SizedBox(height: 19 * heightScaleFactor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 24 * heightScaleFactor,
                      width: 24 * widthScaleFactor,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.forwardColor,
                      ),
                      child: Icon(
                        Icons.check,
                        color: AppColors.whiteColor,
                        size: 15 * widthScaleFactor,
                      ),
                    ),
                    SizedBox(width: 6 * widthScaleFactor),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainText(
                          text: "Phase 3 - Strategy",
                          fontSize: 14 * widthScaleFactor,
                        ),
                        MainText(
                          text: "1h 12 minutes",
                          color: AppColors.teamColor,
                          fontSize: 12 * widthScaleFactor,
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                MainText(
                  text: "Avg: 850 pts",
                  fontSize: 13 * widthScaleFactor,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
