import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/bold_text.dart';

import '../../api/api_controllers/create_game_controller.dart';

class DefaultTimeContainer extends StatelessWidget {
  const DefaultTimeContainer({
    super.key,
    required this.scaleFactor,
    required this.controller,
  });

  final double scaleFactor;
  final CreateGameController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20 * scaleFactor),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.forwardColor.withOpacity(0.1), width: 1.7 * scaleFactor),
        borderRadius: BorderRadius.circular(24 * scaleFactor),
        color: Colors.grey.shade100.withValues(alpha: 0.5),
        boxShadow: [
          // BoxShadow(
          //   color: Colors.black12,
          //   blurRadius: 10 * scaleFactor,
          //   offset: Offset(0, 5 * scaleFactor),
          // )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Header Row ---
          Row(
            children: [
              Icon(Icons.access_time, color: AppColors.blueColor, size: 28 * scaleFactor),
              SizedBox(width: 10 * scaleFactor),
              BoldText(
                text: "total_game_time_minutes".tr,
                selectionColor: AppColors.blueColor,
                fontSize: 18 * scaleFactor,
              ),
            ],
          ),
          SizedBox(height: 16 * scaleFactor),

          /// --- Input for total time ---
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly, // ✅ allow digits only
            ],
            onChanged: (value) {
              if (value.isEmpty) {
                controller.timeDuration.value = 0;
                return;
              }

              final time = int.tryParse(value);
              if (time == null) {
                /// ❌ Invalid input
                Get.snackbar(
                  "Invalid Input",
                  "Only numbers are acceptable",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(12),
                  borderRadius: 8,
                );
                controller.timeDuration.value = 0;
              } else {
                /// ✅ Valid number
                controller.timeDuration.value = time;
              }
            },
            decoration: InputDecoration(
              hintText: "enter_total_time".tr,
              prefixIcon: Icon(Icons.timer, color: AppColors.orangeColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12 * scaleFactor),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 14 * scaleFactor,
                horizontal: 12 * scaleFactor,
              ),
            ),
          ),
          SizedBox(height: 10 * scaleFactor),

          /// --- Selected time text ---
          Obx(() => Text(
            "Selected time: ${controller.timeDuration.value} minutes",
            style: TextStyle(
              fontSize: 14 * scaleFactor,
              fontWeight: FontWeight.w500,
              color: AppColors.teamColor,
            ),
          )),
        ],
      ),
    );
  }
}
