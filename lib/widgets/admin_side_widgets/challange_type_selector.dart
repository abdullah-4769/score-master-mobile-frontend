import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';

import '../bold_text.dart';

class ChallengeTypeSelector extends StatefulWidget {
  final List<String> availableTypes; // e.g. ["MCQ", "Open Ended", "Puzzle", "Simulation"]
  final List<String> initialSelected; // already selected types
  final Function(List<String>) onSelectionChanged; // callback

  const ChallengeTypeSelector({
    super.key,
    required this.availableTypes,
    this.initialSelected = const [],
    required this.onSelectionChanged,
  });

  @override
  State<ChallengeTypeSelector> createState() => _ChallengeTypeSelectorState();
}

class _ChallengeTypeSelectorState extends State<ChallengeTypeSelector> {
  late List<String> selectedTypes;

  @override
  void initState() {
    super.initState();
    selectedTypes = List.from(widget.initialSelected);
  }

  void toggleSelection(String type) {
    setState(() {
      if (selectedTypes.contains(type)) {
        selectedTypes.remove(type);
      } else {
        selectedTypes.add(type);
      }
    });
    widget.onSelectionChanged(selectedTypes); // send updated list to parent
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BoldText(
          text: "challenge_types".tr,
          selectionColor: AppColors.blueColor,
          fontSize: 16,
        ),
        const SizedBox(height: 20),

        ...widget.availableTypes.map((type) {
          final isSelected = selectedTypes.contains(type);

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () => toggleSelection(type),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.blueColor.withOpacity(0.2) : Colors.white,
                  border: Border.all(
                    color: isSelected ? AppColors.blueColor : AppColors.greyColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      type.tr,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? AppColors.blueColor : AppColors.greyColor,
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle, color: AppColors.blueColor)
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
