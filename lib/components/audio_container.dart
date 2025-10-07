











































































































                               










import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';

class AudioContainer extends StatelessWidget {
  const AudioContainer({super.key});

  @override
  Widget build(BuildContext context) {
    
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    
    const double baseWidth = 414.0;
    const double baseHeight = 896.0;

    
    final double scaleWidth = screenWidth / baseWidth;
    final double scaleHeight = screenHeight / baseHeight;

    return Container(
      height: 179 * scaleHeight,
      width: 336 * scaleWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24 * scaleWidth),
        border: Border.all(color: AppColors.greyColor, width: 1.7 * scaleWidth),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17 * scaleWidth),
        child: Column(
          children: [
            SizedBox(height: 20 * scaleHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoldText(
                 text: "audio_response".tr,
                  fontSize: 16 * scaleWidth,
                  selectionColor: AppColors.blueColor,
                ),
                SizedBox(height: 25 * scaleHeight),
                Row(
                  children: [
                    Image.asset(
                      Appimages.timeout2,
                      height: 19 * scaleHeight,
                      width: 19 * scaleWidth,
                    ),
                    MainText(
                      text: "2 min read",
                      fontSize: 14 * scaleWidth,
                      color: AppColors.teamColor,
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 10*scaleHeight,),
            Container(
              width: 300 * scaleWidth,
              height: 52 * scaleHeight,
              decoration: BoxDecoration(
                color: AppColors.forwardColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(9 * scaleWidth),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 11 * scaleWidth,
                  right: 11 * scaleWidth,
                  bottom: 6 * scaleHeight,
                  top: 9 * scaleHeight,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SvgPicture.asset(
                        Appimages.lines,
                        height: 37 * scaleHeight,
                      ),
                    ),
                    Expanded(
                      child: SvgPicture.asset(
                        Appimages.lines2,
                        height: 37 * scaleHeight,
                      ),
                    ),
                    Expanded(
                      child: SvgPicture.asset(
                        Appimages.lines2,
                        height: 37 * scaleHeight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20 * scaleHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 31 * scaleWidth,
                  width: 31 * scaleWidth,
                  decoration: BoxDecoration(
                    color: AppColors.forwardColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow_sharp,
                    color: AppColors.whiteColor,
                    size: 20 * scaleWidth, 
                  ),
                ),
                Row(
                  children: [
                    MainText(
                      text: "1:45",
                      color: AppColors.teamColor,
                      fontSize: 14 * scaleWidth,
                    ),
                    SizedBox(width: 6 * scaleWidth),
                    Row(
                      children: [
                        Container(
                          width: 22 * scaleWidth,
                          height: 3 * scaleHeight,
                          decoration: BoxDecoration(
                            color: AppColors.forwardColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(4 * scaleWidth),
                              topLeft: Radius.circular(4 * scaleWidth),
                            ),
                          ),
                        ),
                        Container(
                          width: 42 * scaleWidth,
                          height: 3 * scaleHeight,
                          decoration: BoxDecoration(
                            color: AppColors.teamColor,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(4 * scaleWidth),
                              topRight: Radius.circular(4 * scaleWidth),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 6 * scaleWidth),
                    MainText(
                      text: "1:45",
                      color: AppColors.teamColor,
                      fontSize: 14 * scaleWidth,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}