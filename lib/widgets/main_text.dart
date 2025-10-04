import 'package:flutter/material.dart';
import 'package:scorer/constants/appcolors.dart';

class MainText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final TextAlign? textAlign;
  final Color? color;
  final double? height;
  final String? fontFamily;
  final VoidCallback? onTap;
  final FontWeight? fontWeight;

  // Optional parameters for ellipsis
  final bool isEllipsis; // To control whether to show ellipsis
  final int? maxLines; // To control the maximum number of lines

  const MainText({
    super.key,
    required this.text,
    this.fontSize,
    this.textAlign,
    this.height,
    this.color,
    this.fontFamily,
    this.onTap,
    this.fontWeight,
    this.isEllipsis = false, // Default to false
    this.maxLines, // Default to null
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: fontFamily ?? "refsan",
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color ?? AppColors.languageColor,
          fontSize: fontSize ?? 18,
          letterSpacing: -0.1,
          height: height ?? 2.0,
        ),
        textAlign: textAlign,
        softWrap: true, // Ensures text wraps to the next line
        overflow: isEllipsis ? TextOverflow.ellipsis : TextOverflow.visible, // Conditional overflow
        maxLines: isEllipsis ? (maxLines ?? 1) : null, // Conditional max lines
      ),
    );
  }
}