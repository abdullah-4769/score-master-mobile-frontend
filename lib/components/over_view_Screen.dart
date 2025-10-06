import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/components/engagement_Container.dart';
import 'package:scorer/components/new_session_container.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';

class OverViewScreen extends StatelessWidget {
  const OverViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double baseHeight = 812.0;
    final double baseWidth = 414.0;
    final double heightScaleFactor = screenSize.height / baseHeight;
    final double widthScaleFactor = screenSize.width / baseWidth;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20 * heightScaleFactor),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30 * widthScaleFactor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoldText(
                text: "session_info".tr,
                selectionColor: AppColors.blueColor,
                fontSize: 16 * heightScaleFactor,
              ),
              MainText(
                text: "session_description".tr,
                fontSize: 14 * heightScaleFactor,
                height: 1.5,
              ),
            ],
          ),
        ),
        SizedBox(height: 20 * heightScaleFactor),
        EngagementContainer(
          widthScaleFactor: widthScaleFactor,
          heightScaleFactor: heightScaleFactor,
        ),
        SizedBox(height: 10 * heightScaleFactor),
        NewSessionContainer(
          widthScaleFactor: widthScaleFactor,
          heightScaleFactor: heightScaleFactor,
        ),
      ],
    );
  }
}
