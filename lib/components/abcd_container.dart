import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ✅ Clipboard
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';

class ABCDContainer extends StatelessWidget {
  const ABCDContainer({
    super.key,
    required this.widthScaleFactor,
    required this.heightScaleFactor,
    required this.sessionCode,
  });

  final double widthScaleFactor;
  final double heightScaleFactor;
  final String sessionCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330 * widthScaleFactor,
      height: 64 * heightScaleFactor,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.forwardColor,
          width: 2 * widthScaleFactor,
        ),
        borderRadius: BorderRadius.circular(60 * widthScaleFactor),
        color: AppColors.forwardColor.withOpacity(0.1),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20 * widthScaleFactor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoldText(
              text: "team_code".tr,
              fontSize: 16 * widthScaleFactor,
              selectionColor: AppColors.blueColor,
            ),
            Row(
              children: [
                MainText(
                  text: sessionCode,
                  color: AppColors.forwardColor,
                  fontSize: 24 * widthScaleFactor,
                  fontFamily: "gotham",
                ),
                SizedBox(width: 10 * widthScaleFactor),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: sessionCode));
                    Get.snackbar(
                      "Copied!",
                      "Session code copied to clipboard",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.forwardColor,
                      colorText: Colors.white,
                      margin: EdgeInsets.all(16),
                    );
                  },
                  child: Container(
                    width: 32 * widthScaleFactor,
                    height: 32 * heightScaleFactor,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.forwardColor,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        Appimages.copy,
                        color: AppColors.whiteColor,
                        height: 16 * heightScaleFactor,
                        width: 16 * widthScaleFactor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
