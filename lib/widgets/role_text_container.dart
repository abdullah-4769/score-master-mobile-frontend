





















import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/bold_text.dart';

class RoleTextContainer extends StatelessWidget {
  const RoleTextContainer({super.key});

  @override
  Widget build(BuildContext context) {
    
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    
    const double baseHeight = 812.0;
    const double baseWidth = 414.0;
    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;

    return Container(
      width: 80 * widthScaleFactor,
      height: 30 * heightScaleFactor,
      decoration: BoxDecoration(
        color: AppColors.forwardColor,
        borderRadius: BorderRadius.circular(80),
      ),
      child: Center(
        child: BoldText(
          text:"role".tr,
          selectionColor: AppColors.whiteColor,
            fontSize: ResponsiveFont.getFontSizeCustom(
defaultSize: 20*widthScaleFactor,
smallSize: 17*widthScaleFactor

                                  ),
        ),
      ),
    );
  }
}
