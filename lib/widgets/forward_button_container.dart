










































import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';

class ForwardButtonContainer extends StatelessWidget {
  final String? image;
  final double? height1;
  final double? height2;
  final double? width1;
  final double? width2;
  final VoidCallback? onTap;

  const ForwardButtonContainer({
    super.key,
    this.image,
    this.height1,
    this.height2,
    this.width1,
    this.width2, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    
    final Size screenSize = MediaQuery.of(context).size;
    
    
    const double baseWidth = 414.0;
    
    
    final double scaleFactor = screenSize.width / baseWidth;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height1 ?? 62 * scaleFactor,
        width: width1 ?? 62 * scaleFactor,
        decoration: BoxDecoration(
          color: AppColors.forwardColor.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
            height: height2 ?? 44 * scaleFactor,
            width: width2 ?? 44 * scaleFactor,
            decoration: const BoxDecoration(
              color: AppColors.forwardColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                image ?? Appimages.forward,
                width: 12 * scaleFactor,
                height: 14 * scaleFactor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}