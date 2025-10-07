
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/controllers/facil_dashboard_controller.dart';
import 'package:scorer/widgets/main_text.dart';

class AdminContainerStackContainer extends StatelessWidget {
  const AdminContainerStackContainer({
    super.key,
    required this.heightScaleFactor,
    required this.widthScaleFactor,
    required this.controller,
  });

  final double heightScaleFactor;
  final double widthScaleFactor;
  final FacilDashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53 * heightScaleFactor,
      width: 336 * widthScaleFactor,
      decoration: BoxDecoration(
        color: AppColors.settingColor,
        borderRadius: BorderRadius.circular(12 * widthScaleFactor),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: controller.selectedIndex.value == 0
                ? Alignment.centerLeft
                : Alignment.centerRight,
            duration: const Duration(milliseconds: 250),
            child: Container(
              height: 42 * heightScaleFactor,
              width: 150 * widthScaleFactor,
              margin: EdgeInsets.symmetric(horizontal: 6 * widthScaleFactor),
              decoration: BoxDecoration(
                color: AppColors.forwardColor,
                borderRadius: BorderRadius.circular(12 * widthScaleFactor),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Center(
                  child: MainText(
                    onTap: () {
                      controller.changeTab(0);
                    },
                      text:   "active_sessions".tr,
                    color: controller.selectedIndex.value == 0
                        ? AppColors.whiteColor
                        : AppColors.languageColor,
                    fontSize: 14 * heightScaleFactor,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: MainText(
                    text:  "scheduled".tr,
                    fontSize: 14 * heightScaleFactor,
                    color: controller.selectedIndex.value == 0
                        ? AppColors.languageColor
                        : AppColors.whiteColor,
                    onTap: () {
                      controller.changeTab(1);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
