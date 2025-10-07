  
  
  
  
  
  
  

  
  
  

    
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  
  
  
  
  
  
  
  
  
  
  
  

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
                              
  
  





















































































































import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/useable_container.dart';

class PlayersContainers extends StatelessWidget {
  final String text1;
  final String text2;
  final String image;
  final Color? color;
  final String? text3;
  final double? width1;
  final IconData? icon;
  final String? text4;
  final Color? iconColor;
  final Color? containerColor;
  final bool ishow;
  final double? imageheight;
  final double? imageWidth;
  final double? leftPadding; 

  const PlayersContainers({
    super.key,
    required this.text1,
    required this.text2,
    required this.image,
    this.color,
    this.text3,
    this.width1,
    this.icon,
    this.text4,
    this.containerColor,
    this.iconColor,
    this.ishow = false,
    this.imageheight,
    this.imageWidth,
    this.leftPadding, 
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    
    final containerWidth = screenWidth * 0.9;
    final containerHeight = containerWidth * (65 / 330);
    final horizontalPadding = containerWidth * (28 / 330);

    final iconSize = containerWidth * 0.06;
    final imageSize = containerWidth * (40 / 330);

    final text1FontSize = containerWidth * 0.044;
    final text2FontSize = containerWidth * 0.039;
    final text4FontSize = containerWidth * 0.044;

    final gapSmall = containerWidth * 0.02;
    final gapMedium = containerWidth * 0.05;
    final borderRadius = containerWidth * 0.09;

    return Container(
      height: containerHeight,
      width: containerWidth,
      decoration: BoxDecoration(
        color: containerColor ?? AppColors.playerColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: leftPadding ?? horizontalPadding, 
          right: horizontalPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (ishow)
                  Icon(
                    icon,
                    color: iconColor ?? AppColors.forwardColor,
                    size: iconSize,
                  ),
                if (ishow) SizedBox(width: gapSmall),
                BoldText(
                  text: text1,
                  selectionColor: AppColors.blueColor,
                  fontSize: text1FontSize,
                ),
                SizedBox(width: gapSmall),
                Image.asset(
                  image,
                  height: imageheight ?? imageSize,
                  width: imageWidth ?? imageSize,
                ),
                SizedBox(width: gapSmall),
                MainText(
                  text: text2,
                  fontSize: text2FontSize,
                ),
              ],
            ),
            if (ishow)
              BoldText(
                text: text4 ?? "",
                fontSize: text4FontSize,
                selectionColor: AppColors.blueColor,
              )
            else
              Flexible(
                child: UseableContainer(
                  text: text3 ?? "submitted".tr,
                  width: width1 ?? containerWidth * 0.23,
                  height: 35.h,
                  color: color ?? AppColors.forwardColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
