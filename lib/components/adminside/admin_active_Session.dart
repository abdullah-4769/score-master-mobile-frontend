import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/widgets/custom_dashboard_container.dart';
import '../../api/api_controllers/active_schedule_controller.dart';
import '../../api/api_controllers/session_action_controller.dart';
import '../../shared_preferences/shared_preferences.dart';

class AdminActiveSession extends StatelessWidget {
  const AdminActiveSession({super.key});

  @override
  Widget build(BuildContext context) {
    final ActiveAndSessionController controller = Get.find<ActiveAndSessionController>();
    final SessionActionController sessionController = Get.find<SessionActionController>();
    final Size screenSize = MediaQuery.of(context).size;
    final double baseHeight = 812.0;
    final double heightScaleFactor = screenSize.height / baseHeight;

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final activeSessions = controller.scheduleAndActiveSession.value.activeSessions ?? [];

      if (activeSessions.isEmpty) {
        return const Center(child: Text('No active sessions available'));
      }

      return Column(
        children: [
          SizedBox(height: 12 * heightScaleFactor),
          ...activeSessions.map((session) => Column(
            children: [
              CustomDashboardContainer(
                width: 70,
                width2: 70,
                height2: 22,
                height1: 22,
                onTap: () async {
                  print("[AdminActiveSession] Container tapped for session ID: ${session.id}");
                  if (session.id != null) {
                    await SharedPrefServices.saveSessionId(session.id!);
                    print("[AdminActiveSession] Session ID saved: ${session.id}");
                  }
                  Get.toNamed(RouteName.adminOverviewOptionScreens);
                },
                onTapResume: sessionController.isSessionActive() ? null : () async {
                  await handleResume(session, sessionController);
                },
                onTapNextPhase: () async {
                  await handleNextPhase(session, sessionController);
                },
                heading: session.teamTitle ?? "Team Building Workshop",
                text1: "Phase ${sessionController.currentPhaseId.value}",
                height: 10,
                text2: "Phases: ${sessionController.phases.length}",
                description: session.description ?? "Team Building Workshop strengthens teamwork through interactive activities.",
                text3: "resume".tr,
                text4: "next_phase".tr,
                icon1: Icons.play_arrow,
                text5: "${session.totalPlayers ?? 0} Players",
                text6: sessionController.isSessionActive() ? "active".tr : "paused".tr,
                icon2: Icons.square,
                color1: AppColors.redColor,
                color2: AppColors.yellowColor,
                ishow: !sessionController.isSessionActive(),
              ),
              SizedBox(height: 12 * heightScaleFactor),
            ],
          )).toList(),
          SizedBox(height: 20 * heightScaleFactor),
        ],
      );
    });
  }

  Future<void> handleResume(session, SessionActionController sessionController) async {
    print("[AdminActiveSession] Resume button tapped for session ID: ${session.id}");
    if (session.id != null) {
      await SharedPrefServices.saveSessionId(session.id!);
      bool success = await sessionController.resumeSession(session.id!);
      if (success) {
        Get.snackbar(
          'Success',
          'Session resumed successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    }
  }

  Future<void> handleNextPhase(session, SessionActionController sessionController) async {
    print("[AdminActiveSession] Next Phase button tapped for session ID: ${session.id}");
    if (session.id != null) {
      await SharedPrefServices.saveSessionId(session.id!);
      bool success = await sessionController.nextPhase(session.id!);
      if (success) {
        Get.snackbar(
          'Success',
          'Advanced to Phase ${sessionController.currentPhaseId.value}!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    }
  }
}