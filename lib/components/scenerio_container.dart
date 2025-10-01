
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/controllers/game_select_controller.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';











































    













































    







































class ScenerioContainer extends StatelessWidget {
  const ScenerioContainer({
    super.key,
    required this.heightScaleFactor,
    required this.widthScaleFactor,
  });

  final double heightScaleFactor;
  final double widthScaleFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 347 * heightScaleFactor,
      width: 338 * widthScaleFactor,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.greyColor,
          width: 1.5,
        ),
        borderRadius:
            BorderRadius.circular(24 * widthScaleFactor),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20 * widthScaleFactor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30 * heightScaleFactor),
            BoldText(
             text: "scenario".tr,
              selectionColor: AppColors.blueColor,
              fontSize: 16 * heightScaleFactor,
            ),
            SizedBox(height: 15 * heightScaleFactor),
          
    MainText(
      height: 1.5,
      text: "scenario_description".tr,
      fontSize: 13 * heightScaleFactor,
    ),
            SizedBox(height: 15 * heightScaleFactor),
            
    BoldText(
      text: "question".tr,
      selectionColor: AppColors.redColor,
      fontSize: 16 * heightScaleFactor,
    ),
            SizedBox(height: 10 * heightScaleFactor),
           
    MainText(
      text: "question_description".tr,
      fontSize: 13 * heightScaleFactor,
      height: 1.5,
    ),
          ],
        ),
      ),
    );
  }
}
