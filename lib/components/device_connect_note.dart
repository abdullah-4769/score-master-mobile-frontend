
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/main_text.dart';

class DeviceConnectNote extends StatelessWidget {
  const DeviceConnectNote({
    super.key,
    required this.widthScaleFactor,
    required this.heightScaleFactor,
  });

  final double widthScaleFactor;
  final double heightScaleFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 338 * widthScaleFactor,
      height: 113 * heightScaleFactor,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.greyColor,
          width: 1.5 * widthScaleFactor,
        ),
        borderRadius: BorderRadius.circular(24 * widthScaleFactor),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 18 * widthScaleFactor,
          vertical: 29 * heightScaleFactor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              Appimages.bulb,
              height: 24 * heightScaleFactor,
              width: 24 * widthScaleFactor,
            ),
            SizedBox(width: 10 * widthScaleFactor),
            Expanded(
              child: MainText(
      height: 1.6,
      text: "device_connection_notice".tr,
      fontSize: 13 * widthScaleFactor,
      textAlign: TextAlign.start,
    ),
            ),
          ],
        ),
      ),
    );
  }
}
