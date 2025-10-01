

























































































import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scorer/constants/appcolors.dart';

class AddOneContainer extends StatelessWidget {
  final IconData? icon;
  final String? svgPath;
  final double? height;
  final double? width;
  final double? height1;
  final double? width1;
  final double? height2;
  final double? width2;
  final VoidCallback?onTap;


  const AddOneContainer({
    super.key,
    this.icon,
    this.svgPath,
    this.height,
    this.width,
    this.height1,
    this.width1,
    this.height2,
    this.width2, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double baseHeight = 812.0; 
    final double baseWidth = 414.0; 
    final double heightScaleFactor = screenSize.height / baseHeight;
    final double widthScaleFactor = screenSize.width / baseWidth;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.none,
        height: (height1 ?? 44) * heightScaleFactor,
        width: (width1 ?? 44) * widthScaleFactor,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.plusColor,
        ),
        child: Center(
          child: Container(
            height: (height2 ?? 30) * heightScaleFactor,
            width: (width2 ?? 30) * widthScaleFactor,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.forwardColor,
            ),
            child: Center(
              child: svgPath != null
                  ? SvgPicture.asset(
                      svgPath!,
                      colorFilter: ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn),
                      height: (height ?? 24) * heightScaleFactor,
                      width: (width ?? 24) * widthScaleFactor,
                    )
                  : icon != null
                      ? Icon(
                          icon,
                          color: AppColors.whiteColor,
                          size: (height ?? 24) * heightScaleFactor,
                        )
                      : const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
}
