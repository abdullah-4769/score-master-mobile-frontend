























































import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/useable_container.dart';

class AllPlayersContainer extends StatelessWidget {
  final String text;
  final String text2;
  final String image;
  final String? text3;
  final Color? color;
  final double? width;
  final double? fontSize;
  final double? fontSize2;
  final VoidCallback?onTap;

  const AllPlayersContainer({
    super.key,
    required this.text,
    required this.text2,
    required this.image,
    this.fontSize,
    this.fontSize2,
    this.text3,
    this.color,
    this.width, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    const double baseWidth = 375.0; 
    final double scaleFactor = screenWidth / baseWidth;
    
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;

    
    final double baseHeight = 812.0;
    
    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 336 * scaleFactor, 
        height: 76 * scaleFactor, 
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.greyColor,
            width: 1.7 * scaleFactor, 
          ),
          borderRadius: BorderRadius.circular(24 * scaleFactor), 
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15 * scaleFactor), 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    image,
                    width: 38 * scaleFactor, 
                    height: 70 * scaleFactor, 
                  ),
                  SizedBox(width: 13 * scaleFactor), 
                  Padding(
                    padding: EdgeInsets.only(top: 10 * scaleFactor), 
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MainText(
                          text: text,
                          fontSize: fontSize ?? 14 * scaleFactor, 
                          height: 1,
                        ),
                        MainText(
                          text: text2,
                          color: AppColors.teamColor,
                          fontSize: fontSize2 ?? 14 * scaleFactor, 
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              UseableContainer(
                fontSize: ResponsiveFont.getFontSizeCustom(
defaultSize: 12*widthScaleFactor,
smallSize: 10*widthScaleFactor

                ),
                text: text3 ?? "active".tr,
                height: 22* scaleFactor,
                width: width ?? 65 * scaleFactor, 
                color: color ?? AppColors.forwardColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}