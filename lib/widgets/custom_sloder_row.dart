

















































import 'package:flutter/material.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/main_text.dart';

class CustomSloderRow extends StatelessWidget {
  final String text;
  final String text2;
  final double? fontSize;
  final double? height;
  final double? width;
  final double?value;
  final Color?color;
  final double? width1;

  const CustomSloderRow({
    super.key,
    required this.text,
    required this.text2,
    this.fontSize,
    this.height,
    this.width, this.value, this.color, this.width1,
  });

  @override
  Widget build(BuildContext context) {
    
    final double screenWidth = MediaQuery.of(context).size.width;

    
    const double baseWidth = 414.0;

    
    final double scaleWidth = screenWidth / baseWidth;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MainText(
          text: text,
          fontSize: fontSize ?? 14 * scaleWidth,
        ),
        Row(
          
          children: [
            Column(
              
              children: [
                SizedBox(
                  width: width ?? 75 * scaleWidth,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: height ?? 4 * scaleWidth,
                      activeTrackColor:color?? AppColors.forwardColor,
                      inactiveTrackColor: AppColors.greyColor,
                      thumbColor:color?? AppColors.forwardColor,
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 6 * scaleWidth,
                      ),
                      overlayShape: SliderComponentShape.noOverlay,
                    ),
                    child: Slider(
                      value:value?? 20, 
                      onChanged: (_) {}, 
                      min: 0,
                      max: 30,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: width1,),
            MainText(
              text: text2,
              fontSize: fontSize ?? 14 * scaleWidth,
            )
          ],
        )
      ],
    );
  }
}