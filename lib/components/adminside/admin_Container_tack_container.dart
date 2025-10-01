import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/controllers/facil_dashboard_controller.dart';

class AdminContainerStackContainer extends StatelessWidget {
  final double heightScaleFactor;
  final double widthScaleFactor;
  final FacilDashboardController controller;

  const AdminContainerStackContainer({
    super.key,
    required this.heightScaleFactor,
    required this.widthScaleFactor,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Container(
        height: 60 * heightScaleFactor,
        width: double.infinity,
        decoration: BoxDecoration(
          color: controller.selectedIndex.value == 0
              ? AppColors.blueColor.withOpacity(0.2)
              : AppColors.scheColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                print("[AdminContainerStackContainer] Active Sessions tapped, setting index to 0");
                controller.selectedIndex.value = 0;
              },
              child: Container(

                padding: EdgeInsets.symmetric(
                  horizontal: 15 * widthScaleFactor,
                  vertical: 10 * heightScaleFactor,
                ),
                decoration: BoxDecoration(
                  color: controller.selectedIndex.value == 0
                      ? AppColors.scheColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Active Sessions",
                  style: TextStyle(
                    fontSize: 12 * heightScaleFactor,
                    fontWeight: controller.selectedIndex.value == 0
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: controller.selectedIndex.value == 0
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print("[AdminContainerStackContainer] Scheduled Sessions tapped, setting index to 1");
                controller.selectedIndex.value = 1;
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20 * widthScaleFactor,
                  vertical: 10 * heightScaleFactor,
                ),
                decoration: BoxDecoration(
                  color: controller.selectedIndex.value == 1
                      ? AppColors.scheColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Scheduled Sessions",
                  style: TextStyle(
                    fontSize: 12 * heightScaleFactor,
                    fontWeight: controller.selectedIndex.value == 1
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: controller.selectedIndex.value == 1
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}