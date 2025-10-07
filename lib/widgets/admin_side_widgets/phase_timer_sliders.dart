import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';

class PhaseTimeSlider extends StatelessWidget {
  const PhaseTimeSlider({
    super.key,
    required this.label,
    required this.value,
    required this.totalTime,
    required this.allValues,
  });

  final String label;
  final RxInt value;
  final RxInt totalTime;
  final List<RxInt> allValues;

  int get otherPhasesSum {
    return allValues.fold(0, (sum, v) => sum + v.value) - value.value;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label (${value.value} min)",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.blueColor,
          ),
        ),
        Slider(
          value: value.value.toDouble(),
          min: 0,
          max: totalTime.value.toDouble(),
          divisions: totalTime.value > 0 ? totalTime.value : null,
          activeColor: AppColors.forwardColor,
          onChanged: (val) {
            final newVal = val.toInt();
            if (otherPhasesSum + newVal <= totalTime.value) {
              value.value = newVal;
            } else {
              Get.snackbar("Error", "Total time cannot exceed game limit");
            }
          },
        ),
      ],
    ));
  }
}
