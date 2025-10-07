


































import 'package:flutter/material.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/main_text.dart';

class UseableTextrow extends StatelessWidget {
  final Color color;
  final String text;
  final String? text1;
  final double?height;
  final bool ishow;
  final double?fontsize11;
  const UseableTextrow({super.key, required this.color, required this.text, this.text1, this.height,  this.ishow=false, this.fontsize11});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dotSize = screenWidth * 0.02; 
    final horizontalSpace = screenWidth * 0.025; 
    final fontSize = screenWidth * 0.035; 
    final fontSize1 = screenWidth * 0.04; 

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ishow? Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.forwardColor,
              ),
              child: Center(child: Icon(Icons.check,color: AppColors.whiteColor,size: 10,)),
            ):
            Container(
              height: dotSize,
              width: dotSize,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
           
            SizedBox(width: horizontalSpace),
            MainText(
              text: text,
              color: AppColors.teamColor,
              fontSize:fontsize11?? fontSize,
              height:height?? 1,
            )
          ],
        ),
        MainText(
          text: text1 ?? "",
          fontSize: fontSize1,
        )
      ],
    );
  }
}