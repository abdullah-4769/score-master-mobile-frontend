
































































































import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/bold_text.dart';

class LanguageSelectionContainer extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String image; 
  final bool isSelected;

  const LanguageSelectionContainer({
    super.key,
    required this.text,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    const double baseWidth = 375.0;
    final double scaleFactor = screenWidth / baseWidth;

    Widget buildImage() {
      if (image.toLowerCase().endsWith(".svg")) {
        return SvgPicture.asset(
          image,
          width: 35 * scaleFactor,
          height: 35 * scaleFactor,
        );
      } else {
        return Image.asset(
          image,
          width: 35 * scaleFactor,
          height: 35 * scaleFactor,
          fit: BoxFit.contain,
        );
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60 * scaleFactor,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.selectLangugaeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20 * scaleFactor),
          border: Border.all(
            color: isSelected
                ? AppColors.selectLangugaeColor.withOpacity(0.1)
                : AppColors.borderColor.withOpacity(0.25),
            width: 2 * scaleFactor,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 13 * scaleFactor),
          child: Row(
            children: [
              buildImage(),
              SizedBox(width: 17 * scaleFactor),
              BoldText(
                text: text,
                selectionColor: isSelected
                    ? AppColors.whiteColor
                    : AppColors.languageTextColor,
                fontSize: 20 * scaleFactor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
