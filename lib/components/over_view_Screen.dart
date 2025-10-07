


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/components/engagement_Container.dart';
import 'package:scorer/components/new_session_container.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/api/api_controllers/session_controller.dart';
import 'dart:developer' as developer;

class OverViewScreen extends StatefulWidget {
  const OverViewScreen({super.key});

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  @override
  void initState() {
    super.initState();
    // Ensure session is loaded when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final sessionController = Get.find<SessionController>();
      if (sessionController.session.value == null && !sessionController.isLoading.value) {
        sessionController.initializeSession();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double baseHeight = 812.0;
    final double baseWidth = 414.0;
    final double heightScaleFactor = screenSize.height / baseHeight;
    final double widthScaleFactor = screenSize.width / baseWidth;

    final SessionController sessionController = Get.find<SessionController>();

    return Obx(() {
      developer.log('[LOG] isLoading: ${sessionController.isLoading.value}, session: ${sessionController.session.value?.teamTitle}', name: 'OverViewScreen');

      if (sessionController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(color: AppColors.forwardColor),
        );
      }

      if (sessionController.session.value == null) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 60 * heightScaleFactor,
                color: AppColors.blueColor,
              ),
              SizedBox(height: 20 * heightScaleFactor),
              BoldText(
                text: "failed_to_load_session".tr,
                selectionColor: AppColors.blueColor,
                fontSize: 16 * heightScaleFactor,
              ),
              SizedBox(height: 10 * heightScaleFactor),
              MainText(
                text: "please_check_connection".tr,
                fontSize: 14 * heightScaleFactor,
              ),
              SizedBox(height: 20 * heightScaleFactor),
              ElevatedButton(
                onPressed: () => sessionController.initializeSession(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.forwardColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 30 * widthScaleFactor,
                    vertical: 12 * heightScaleFactor,
                  ),
                ),
                child: Text(
                  "retry".tr,
                  style: TextStyle(fontSize: 14 * heightScaleFactor),
                ),
              ),
            ],
          ),
        );
      }

      return SingleChildScrollView(
        child: Column(
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
                    text: sessionController.session.value!.description,
                    fontSize: 14 * heightScaleFactor,
                    height: 1.5,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20 * heightScaleFactor),
            EngagementContainer(
                widthScaleFactor: widthScaleFactor,
                heightScaleFactor: heightScaleFactor),
            SizedBox(height: 10 * heightScaleFactor),
            NewSessionContainer(
                widthScaleFactor: widthScaleFactor,
                heightScaleFactor: heightScaleFactor),
            SizedBox(height: 20 * heightScaleFactor),
          ],
        ),
      );
    });
  }
}