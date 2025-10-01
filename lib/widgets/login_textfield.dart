import 'package:flutter/material.dart';
import 'package:scorer/constants/appcolors.dart';

class LoginTextfield extends StatelessWidget {
  final double? fontsize;
  final String text;
  final double? height;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged; // ✅ Added here

  const LoginTextfield({
    super.key,
    required this.text,
    this.fontsize,
    this.height,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.onChanged, // ✅ Added here
    required bool ishow,
  });

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
      height: height ?? 70 * heightScaleFactor,
      width: 337 * widthScaleFactor,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25 * heightScaleFactor),
        border: Border.all(
          color: AppColors.selectLangugaeColor.withOpacity(0.1),
          width: 2 * widthScaleFactor,
        ),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: validator,
        onChanged: onChanged, // ✅ Hooked up
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10 * widthScaleFactor),
          hintText: text,
          hintStyle: TextStyle(
            fontFamily: "giory",
            fontSize: fontsize ?? 21 * heightScaleFactor,
            color: AppColors.languageTextColor,
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
