import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';

class CreateContainer extends StatelessWidget {
  final String? text;
  final double? height;
  final double? width;
  final double? fontsize2;
  final Color? borderColor;
  final Color? containerColor;
  final Color? textColor;
  final double? right;
  final double? top;
  final bool ishow;

  /// ✅ Add this to handle taps
  final VoidCallback? onTap;

  const CreateContainer({
    super.key,
    this.text,
    this.height,
    this.width,
    this.fontsize2,
    this.borderColor,
    this.containerColor,
    this.textColor,
    this.right,
    this.top,
    this.ishow = true,
    this.onTap, // ✅ Make it optional
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double baseHeight = 812.0;
    final double baseWidth = 414.0;
    final double heightScaleFactor = screenSize.height / baseHeight;
    final double widthScaleFactor = screenSize.width / baseWidth;

    return GestureDetector(
      onTap: onTap, // ✅ Connect the callback here
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: (width ?? 70) * widthScaleFactor,
            height: (height ?? 36) * heightScaleFactor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              color: containerColor ?? AppColors.createColor,
              border: Border.all(
                color: borderColor ?? AppColors.createBorderColor,
                width: 2 * widthScaleFactor,
              ),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  text ?? "create".tr,
                  style: TextStyle(

                    fontSize: fontsize2 ?? 13 * heightScaleFactor,
                    color: textColor ?? AppColors.createBorderColor,
                  ),
                ),
              ),
            ),
          ),
          if (ishow)
            Positioned(
              top: top ?? -16 * heightScaleFactor,
              right: (right ?? -1) * widthScaleFactor,
              child: SvgPicture.asset(
                Appimages.arrowdown,
                height: 22 * heightScaleFactor,
                width: 20 * widthScaleFactor,
              ),
            ),
        ],
      ),
    );
  }
}
