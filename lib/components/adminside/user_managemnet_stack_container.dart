
import 'package:flutter/material.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/controllers/user_managment_controller.dart';

class UserManagementStackContainer extends StatelessWidget {
  const UserManagementStackContainer({
    super.key,
    required this.scaleFactor,
    required this.totalWidth,
    required this.left,
    required this.tabWidth,
    required this.tabs,
    required this.controller,
  });

  final double scaleFactor;
  final double totalWidth;
  final double left;
  final double tabWidth;
  final List<String> tabs;
  final UserManagmentController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53 * scaleFactor,
      width: totalWidth,
      decoration: BoxDecoration(
        color: AppColors.settingColor,
        borderRadius: BorderRadius.circular(12 * scaleFactor),
      ),
      child: Stack(
        children: [
          
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            left: left + (4 * scaleFactor),
            top: 5.5 * scaleFactor,
            child: Container(
              height: 42 * scaleFactor,
              width: tabWidth - (8 * scaleFactor),
              decoration: BoxDecoration(
                color: AppColors.forwardColor,
                borderRadius: BorderRadius.circular(12 * scaleFactor),
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
                        fontSize: 14 * scaleFactor,
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