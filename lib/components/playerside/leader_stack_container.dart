




































































































import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/main_text.dart';

class LeaderStackContainer extends StatefulWidget {
  const LeaderStackContainer({super.key});

  @override
  State<LeaderStackContainer> createState() => _LeaderStackContainerState();
}

class _LeaderStackContainerState extends State<LeaderStackContainer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: isExpanded ? screenWidth * 0.45 : screenWidth * 0.05,
          height: screenHeight * 0.07,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(screenWidth * 0.1),
              bottomLeft: Radius.circular(screenWidth * 0.1),
            ),
            color: AppColors.forwardColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isExpanded) ...[
                SvgPicture.asset(
                  Appimages.king,
                  width: screenWidth * 0.14,
                ),
                SizedBox(width: screenWidth * 0.02),
                MainText(
                  text: "leaderboard".tr,
                  fontSize: screenWidth * 0.04,
                  color: AppColors.whiteColor,
                  fontFamily: "gotham",
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
