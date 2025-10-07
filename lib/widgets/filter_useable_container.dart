import 'package:flutter/material.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/main_text.dart';

class FilterUseableContainer extends StatelessWidget {
  final bool isSelected;
  final String text;
  final VoidCallback onTap;
  final double? fontSze;

  const FilterUseableContainer({
    super.key,
    required this.isSelected,
    required this.text,
    required this.onTap,
    this.fontSze,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    const double baseWidth = 375.0;
    final double scaleFactor = screenWidth / baseWidth;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 74 * scaleFactor,
        width: 334 * scaleFactor,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.greyColor,
            width: 1.5 * scaleFactor,
          ),
          borderRadius: BorderRadius.circular(24 * scaleFactor),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23 * scaleFactor),
          child: Row(
            children: [
              Container(
                height: 24 * scaleFactor,
                width: 24 * scaleFactor,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected
                        ? AppColors.forwardColor
                        : AppColors.greyColor,
                    width: isSelected ? 0 : 1.5 * scaleFactor,
                  ),
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.forwardColor : Colors.transparent,
                ),
                child: isSelected
                    ? Icon(
                  Icons.check,
                  color: AppColors.whiteColor,
                  size: 15 * scaleFactor,
                )
                    : const SizedBox(),
              ),
              SizedBox(width: 14 * scaleFactor),
              MainText(
                text: text,
                fontSize: fontSze ?? 14 * scaleFactor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterSelector extends StatefulWidget {
  final Function(String selectedValue) onSelected;

  const FilterSelector({super.key, required this.onSelected});

  @override
  State<FilterSelector> createState() => _FilterSelectorState();
}

class _FilterSelectorState extends State<FilterSelector> {
  String selected = "manual"; // default selected

  final List<String> options = ["manual", "ai", "mixed"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.map((option) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FilterUseableContainer(
            isSelected: selected == option,
            text: option,
            onTap: () {
              setState(() {
                selected = option;
              });
              widget.onSelected(option); // ✅ Pass selected value to parent/API
            },
          ),
        );
      }).toList(),
    );
  }
}
