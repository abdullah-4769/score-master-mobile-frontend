

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';

import 'package:scorer/view/FacilitateFolder/aa.dart';

import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/forward_button_container.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/page_changed_container.dart';

class StartScreen1 extends StatelessWidget {
  const StartScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double screenHeight = constraints.maxHeight;
              final double titleFontSize = screenHeight * 0.03;
              final double descriptionFontSize = screenHeight * 0.018;
              final double imageTopPadding = screenHeight * 0.1;
              final double imageLeftPadding = constraints.maxWidth * 0.16;
              final double imageManHeight = screenHeight * 0.45;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    SvgPicture.asset(
                      Appimages.splash,
                      width: constraints.maxWidth * 0.2,
                      height: constraints.maxHeight * 0.08,
                    ),
                     Center(
                       child: Image.asset(
                                         Appimages.man1,
                                         height: imageManHeight,

                                       ),
                     ),
                     SizedBox(height: 20,),
                    
             
                    
                    Center(
  child: BoldText(
    selectionColor: AppColors.blueColor,
    text: "gamify_title".tr,  
    textAlign: TextAlign.center,
    fontSize: titleFontSize,
  ),
),

                    SizedBox(height: screenHeight * 0.01),
                  Center(
  child: MainText(
    text: "experience_text".tr,  
    textAlign: TextAlign.center,
    fontSize: descriptionFontSize,
    height: 1.24,
  ),
),

                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: constraints.maxWidth * 0.2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PageChangedContainer(
                              color: AppColors.forwardColor,
                              width: constraints.maxWidth * 0.08,
                              height: screenHeight * 0.008,
                            ),
                            SizedBox(width: constraints.maxWidth * 0.01),
                            PageChangedContainer(
                              color: AppColors.pageColor,
                              width: constraints.maxWidth * 0.03,
                              height: screenHeight * 0.008,
                            ),
                            SizedBox(width: constraints.maxWidth * 0.01),
                            PageChangedContainer(
                              color: AppColors.pageColor,
                              width: constraints.maxWidth * 0.03,
                              height: screenHeight * 0.008,
                            ),
                          ],
                        ),
                        ForwardButtonContainer(

                          onTap:(){
                            Get.toNamed(RouteName.startScreen2);
                          } ,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Center(child: SvgPicture.asset(Appimages.bottom)),
                    SizedBox(height: screenHeight * 0.01),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
