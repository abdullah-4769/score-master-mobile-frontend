
import 'package:flutter/material.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/controllers/stage_controllers.dart';

class ViewResponseStackContainer extends StatelessWidget {
  const ViewResponseStackContainer({
    super.key,
    required this.totalWidth,
    required this.left,
    required this.tabWidth,
    required this.tabs,
    required this.controller,
  });

  final double totalWidth;
  final double left;
  final double tabWidth;
  final List<String> tabs;
  final StageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53,
      width: totalWidth,
      decoration: BoxDecoration(
        color: AppColors.settingColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          
          AnimatedPositioned(
            duration: Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            left: left+4,
            top: 5.5,
            child: Container(
                      height: 42,
             width: tabWidth - 8, 
                      decoration: BoxDecoration(
    color: AppColors.forwardColor,
    borderRadius: BorderRadius.circular(12),
                      ),
            ),
          ),
                      
          
          Row(
            children: List.generate(tabs.length, (index) {
                      return SizedBox(
    width: tabWidth,
    child: GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Center(
        child: Text(
          tabs[index],
          style: TextStyle(
            fontSize: 14,
            color: controller.selectedIndex.value == index
                ? AppColors.whiteColor
                : AppColors.languageColor,
          ),
        ),
      ),
    ),
                      );
            }),
          )
        ],
      ),
    );
  }
}
