
import 'package:flutter/material.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/controllers/overview_controller.dart';

class FacilOverViewStackContainer extends StatelessWidget {
  const FacilOverViewStackContainer({
    super.key,
    required this.widthScaleFactor,
    required this.heightScaleFactor,
    required this.containerWidth,
    required this.controller,
    required this.tabCount,
    required this.tabWidth,
    required this.tabs,
  });

  final double widthScaleFactor;
  final double heightScaleFactor;
  final double containerWidth;
  final OverviewController controller;
  final int tabCount;
  final double tabWidth;
  final List<String> tabs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 21 * widthScaleFactor),
      child: Container(
        height: 53 * heightScaleFactor,
        width: containerWidth,
        decoration: BoxDecoration(
          color: AppColors.settingColor,
          borderRadius: BorderRadius.circular(12 * widthScaleFactor),
        ),
        child: Stack(
          children: [
                
                AnimatedAlign(
    alignment: Alignment(
      (controller.selectedIndex.value / (tabCount - 1)) * 2 - 1, 
      0,
    ),
    duration: const Duration(milliseconds: 250),
    curve: Curves.easeInOut,
    child: Container(
      margin: EdgeInsets.symmetric(
        horizontal: 4 * widthScaleFactor,
        vertical: 5.5 * heightScaleFactor,
      ),
      height: 42 * heightScaleFactor,
      width: tabWidth - (18 * widthScaleFactor),
      decoration: BoxDecoration(
        color: AppColors.forwardColor,
        borderRadius: BorderRadius.circular(12 * widthScaleFactor),
      ),
    ),
                ),
                
                
                Row(
    children: List.generate(tabCount, (index) {
      return Expanded(
        child: GestureDetector(
          onTap: () => controller.changeTab(index),
          child: Center(
            child:FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      tabs[index],
      style: TextStyle(
        fontSize: 13 * heightScaleFactor,
        color: controller.selectedIndex.value == index
                ? AppColors.whiteColor
                : AppColors.languageColor,
      ),
    ),
                )
                
          ),
        ),
      );
    }),
                ),
          ],
        ),
      ),
    );
  }
}
