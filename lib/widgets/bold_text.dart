


















        

        

    










































import 'package:flutter/material.dart';
import 'package:scorer/constants/appcolors.dart';

class BoldText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? selectionColor;
  final TextAlign? textAlign;
  final String? fontFamily;
  final double? height;

  const BoldText({
    super.key,
    required this.text,
    this.selectionColor,
    this.textAlign,
    this.fontSize,
    this.height,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    
    final double screenHeight = MediaQuery.of(context).size.height;

    
    const double baseHeight = 812.0;

    
    final double responsiveFontSize =
        (fontSize ?? 22) * (screenHeight / baseHeight);
    final double? responsiveHeight = height != null
        ? height! * (screenHeight / baseHeight)
        : null;

    return Text(
      text,
      style: TextStyle(
        fontFamily: fontFamily ?? "giory",
        fontSize: responsiveFontSize,
        letterSpacing: -0.3,
        fontWeight: FontWeight.w400,
        color: selectionColor ?? AppColors.languageTextColor,
        height: responsiveHeight,
      ),
      textAlign: textAlign,
    );
  }
}
