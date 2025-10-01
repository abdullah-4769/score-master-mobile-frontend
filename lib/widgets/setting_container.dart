





























                   








import 'package:flutter/material.dart';
import 'package:scorer/constants/appcolors.dart';

class SettingContainer extends StatelessWidget {
  final bool ishow;
  final IconData icons;
  const SettingContainer({super.key, this.ishow = false, required this.icons});

  @override
  Widget build(BuildContext context) {
    
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    
    const double baseHeight = 812.0;
    const double baseWidth = 414.0;
    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;
    final double iconSize = 24;

    return Stack(
      children: [
        Container(
          height: 44 * heightScaleFactor,
          width: 44 * widthScaleFactor,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.settingColor.withOpacity(0.8),
          ),
          child: Icon(
            icons,
            color: AppColors.forwardColor,
            size: iconSize * heightScaleFactor,
          ),
        ),
        ishow
            ? Positioned(
                top: -0.1,
                right: -0.1,
                child: Container(
                  height: 12 * heightScaleFactor,
                  width: 12 * widthScaleFactor,
                  decoration: BoxDecoration(
                    color: AppColors.selectLangugaeColor,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
