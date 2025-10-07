import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/components/adminside/admin_new_Session_screen.dart';
import 'package:scorer/components/engagement_Container.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/useable_textrow.dart';

import '../../api/api_controllers/session_controller.dart';


class AdminOverviewScreen extends StatelessWidget {
  const AdminOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double baseWidth = 414.0;
    final double scaleFactor = screenSize.width / baseWidth;

    final SessionController controller = Get.put(SessionController());
    controller.fetchSession(7); // Fetch session ID 7

    return Obx(() {
      if (controller.isLoading.value || controller.session.value == null) {
        return const Center(child: CircularProgressIndicator());
      }

      final session = controller.session.value!;

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20 * scaleFactor),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30 * scaleFactor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoldText(
                    text: "session_info".tr,
                    selectionColor: AppColors.blueColor,
                    fontSize: 16 * scaleFactor,
                  ),
                  MainText(
                    text: session.description,
                    fontSize: 14 * scaleFactor,
                    height: 1.5,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20 * scaleFactor),

            EngagementContainer(
              widthScaleFactor: scaleFactor,
              heightScaleFactor: scaleFactor,
            ),
            SizedBox(height: 10 * scaleFactor),

            AdminNewSessionScreen(
              widthScaleFactor: scaleFactor,
              heightScaleFactor: scaleFactor,
              sessionId: session.id,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleFactor),
              child: Column(
                children: [
                  Container(
                    width: 382 * scaleFactor,
                    height: 220 * scaleFactor,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.greyColor, width: 1.7 * scaleFactor),
                      borderRadius: BorderRadius.circular(24 * scaleFactor),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor, vertical: 16 * scaleFactor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BoldText(
                            text: "system_activity".tr,
                            selectionColor: AppColors.blueColor,
                            fontSize: 16 * scaleFactor,
                          ),
                          SizedBox(height: 10 * scaleFactor),
                          UseableTextrow(
                            color: AppColors.forwardColor,
                            text: "Alex joined session",
                          ),
                          SizedBox(height: 2 * scaleFactor),
                          UseableTextrow(
                            color: AppColors.forwardColor2,
                            text: "Phase 2 auto-started",
                          ),
                          SizedBox(height: 2 * scaleFactor),
                          UseableTextrow(
                            color: AppColors.forwardColor3,
                            text: "Connection timeout: Mike",
                          ),
                          SizedBox(height: 2 * scaleFactor),
                          UseableTextrow(
                            color: AppColors.forwardColor3,
                            text: "Mike went inactive • 5m ago",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 22 * scaleFactor),
                  LoginButton(
                    text: "export_by_phase".tr,
                    ishow: true,
                    image: Appimages.export,
                    fontSize: 18,
                  ),
                  SizedBox(height: 9 * scaleFactor),
                  LoginButton(
                    text: "export_by_team".tr,
                    ishow: true,
                    image: Appimages.export,
                    color: AppColors.redColor,
                    fontSize: 18,
                  ),
                  SizedBox(height: 9 * scaleFactor),
                  LoginButton(
                    text: "export_by_player".tr,
                    ishow: true,
                    image: Appimages.export,
                    color: AppColors.forwardColor,
                    fontSize: 18,
                  ),
                  SizedBox(height: 44 * scaleFactor),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
