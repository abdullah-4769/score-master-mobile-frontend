






















































import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/controllers/role_selection_controller.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';

class RoleSelectionContainer extends StatelessWidget {

  final bool isSelected;
  final String image;
  final String image2;
  final String text;
  final String text2;
  final double? height;
  final double? width;
  final VoidCallback onTap;

   const RoleSelectionContainer({
    super.key,
    required this.image,
    required this.image2,
    required this.text,
    required this.text2,
   required this.isSelected ,
    this.height,
    this.width, required this.onTap,
  });

  

  @override
  Widget build(BuildContext context) {
    
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    
    
    const double baseWidth = 414.0;
    final double scaleFactor = screenWidth / baseWidth;

    
    final double containerHeight = 156 * scaleFactor;
    final double imageMainHeight = height ?? 150 * scaleFactor;
    final double imageMainWidth = width ?? screenWidth * 0.4; 
    final double svgIconHeight = 50 * scaleFactor; 
    final double svgIconWidth = 50 * scaleFactor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: containerHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30 * scaleFactor),
          border: Border.all(
            color: isSelected ? AppColors.forwardColor : AppColors.greyColor,
            width: 2 * scaleFactor,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              height: imageMainHeight,
              width: imageMainWidth,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, 
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    image2,
                    height: svgIconHeight,
                    width: svgIconWidth,
                  ),
                  BoldText(
                    text: text,
                    fontSize: 17 * scaleFactor, 
                    selectionColor: AppColors.blueColor,
                  ),
                  MainText(
                    text: text2,
                    fontSize: 12 * scaleFactor, 
                    height: 1.3,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}