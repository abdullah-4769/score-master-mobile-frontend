





















































































































































            














import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/main_text.dart';

class PauseContainer extends StatelessWidget {
  final Color? color;
  final IconData? icon;
  final String? svgPath;
  final String text;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final double?fontSize;

  const PauseContainer({
    super.key,
    this.color,
    this.icon,
    this.svgPath,
    this.text = "",
    this.height,
    this.width,
    this.onTap, this.fontSize,
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
      height: (height ?? 45).h,

        width: (width ?? 140).w,
        decoration: BoxDecoration(
          color: color ?? AppColors.selectLangugaeColor,
          borderRadius: BorderRadius.circular(12 * widthScaleFactor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (svgPath != null) ...[
              SvgPicture.asset(
                svgPath!,
                height: 16 .h,
                width: 16 .w,
                color: AppColors.whiteColor,
              ),
              SizedBox(width: 8 * widthScaleFactor),
            ] else if (icon != null) ...[
              Icon(
                icon,
                color: AppColors.whiteColor,
                size: 20 * heightScaleFactor,
              ),
              SizedBox(width: 5 * widthScaleFactor),
            ],
            MainText(
              text: text,
              color: AppColors.whiteColor,
              fontSize:fontSize?? 14.sp,
            ),
          ],
        ),
      ),
    );
  }
}
