import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/main_text.dart';

class BackStackContainer extends StatefulWidget {
  const BackStackContainer({super.key});

  @override
  State<BackStackContainer> createState() => _BackStackContainerState();
}

class _BackStackContainerState extends State<BackStackContainer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: isExpanded ? screenWidth * 0.39 : screenWidth * 0.07, // expand/collapse
          height: screenHeight * 0.07,
          decoration: BoxDecoration(
            color: AppColors.forwardColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(80),
              bottomRight: Radius.circular(80),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isExpanded
                  ? Row(
                      key: const ValueKey("expanded"),
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainText(
                          text: "back".tr,
                          fontSize: screenWidth * 0.04,
                          color: AppColors.whiteColor,
                          fontFamily: "gotham",
                        ),
                        Image.asset(
                          Appimages.main,
                          width: screenWidth * 0.2,
                        ),
                      ],
                    )
                  : const SizedBox.shrink(), // collapsed pe empty
            ),
          ),
        ),
      ),
    );
  }
}
