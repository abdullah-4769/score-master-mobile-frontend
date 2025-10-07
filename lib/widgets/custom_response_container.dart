
















































                         









                









                























        



          




          














import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';

import 'package:scorer/widgets/useable_container.dart';

class CustomResponseContainer extends StatelessWidget {
  final String? text;
  final bool ishow;
  final Color? color1;
  final String? text1;
  final String? image;
  final Color? textColor;
  final double? containerHeight;
  final double? containerWidth;
  final bool ishow1;
  final  VoidCallback ?onTap;

  const CustomResponseContainer({
    super.key,
    this.text,
    this.ishow = false,
    this.color1,
    this.text1,
    this.image,
    this.textColor,
    this.containerHeight,
    this.containerWidth,
    this.ishow1 = true, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;

    
    final double baseHeight = 896.0;
    final double baseWidth = 414.0;
    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;
    
    
    

    
    
    

    
    final double scaleWidth = screenWidth / baseWidth;
    final double scaleHeight = screenHeight / baseHeight;
    bool isSpanish = Get.locale?.languageCode == 'es';


    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: containerHeight ?? 226 * scaleHeight,
            width: containerWidth ?? 346 * scaleWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24 * scaleWidth),
              border: Border.all(color: AppColors.greyColor, width: 1.7 * scaleWidth),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17 * scaleWidth),
              child: Column(
                children: [
                  SizedBox(height: 16 * scaleHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            Appimages.blackgirl,
                            height: 47 * scaleHeight,
                            width: 35 * scaleWidth,
                          ),
                          SizedBox(width: 3 * scaleWidth),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MainText(
                                text: "Sarah Johnson",
                                fontSize: 14 * scaleWidth,
                              ),
                              MainText(
                                text: "Team Beta 3:42 PM",
                                color: AppColors.teamColor,
                                fontSize: 13 * scaleWidth,
                                height: 1,
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UseableContainer(
                            text: text ?? "pending".tr,
                            height: 28 * scaleHeight,
                            width: 75 * scaleWidth,
                            color: color1 ?? AppColors.yellowColor,
                            textColor: textColor ?? AppColors.languageTextColor,
                            fontSize:isSpanish?10: 12 * scaleWidth, 
                          ),
                          SizedBox(width: 4 * scaleWidth),
                          UseableContainer(
                            text: "78",
                            fontFamily: "giory",
                            fontSize: 14 * scaleWidth,
                            width: 37 * scaleWidth,
                            height: 28 * scaleHeight,
                            color: AppColors.orangeColor,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 17 * scaleHeight),
                MainText(
  text: "primary_objective".tr,
  
  fontSize: ResponsiveFont.getFontSizeCustom(
    defaultSize: 14*widthScaleFactor,
    smallSize: 9*widthScaleFactor
  ),
  height: 1.5,
),

                  const Spacer(),
                  if (ishow1)
                    LoginButton(
                      fontSize: 14 * scaleWidth,
                      fontFamily: "refsan",
                      imageHeight: 17 * scaleHeight,
                      imageWidth: 18 * scaleWidth,
                text: text1?.tr ?? "evaluate".tr,
                      height: 45 * scaleHeight,
                      width: 300 * scaleWidth,
                      radius: 12 * scaleWidth,
                      image: image ?? Appimages.star,
                      ishow: true,
                    )
                  else
                    SizedBox.shrink(),
                  SizedBox(height: 20 * scaleHeight),
                ],
              ),
            ),
          ),
        ),
        if (ishow)
          Positioned(
            top: 70 * scaleHeight,
            right: 14 * scaleWidth,
            child: Image.asset(
              Appimages.ai2,
              height: 38 * scaleHeight,
              width: 38 * scaleWidth,
            ),
          ),
        if (ishow)
          Positioned(
            top: 60 * scaleHeight,
            right: -6 * scaleWidth,
            child: SvgPicture.asset(
              Appimages.arrowdown,
              height: 22 * scaleHeight,
              width: 20 * scaleWidth,
            ),
          ),
      ],
    );
  }
}