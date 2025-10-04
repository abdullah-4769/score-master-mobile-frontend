import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/widgets/custom_dashboard_container.dart';
import '../../api/api_controllers/active_schedule_controller.dart';
import '../../api/api_controllers/session_action_controller.dart';

class AdminScheduleSession extends StatelessWidget {
  const AdminScheduleSession({super.key});

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

      final scheduledSessions = controller.scheduleAndActiveSession.value.scheduledSessions ?? [];

      if (scheduledSessions.isEmpty) {
        return const Center(child: Text('No scheduled sessions available'));
      }

      return Column(
        children: [
          SizedBox(height: 12 * heightScaleFactor),
          ...scheduledSessions.map((session) => Column(
            children: [
              CustomDashboardContainer(
                onTap: () {
                  print("[AdminScheduleSession] Container tapped for session ID: ${session.id}");
                  Get.toNamed(RouteName.adminOverviewOptionScreens);
                },
                onTapStartEarly: () {
                  print("[AdminScheduleSession] Start Early button tapped for session ID: ${session.id}");
                  sessionController.startSession(session.id ?? 0);
                },
                onTapPause: () {
                  print("[AdminScheduleSession] Pause button tapped for session ID: ${session.id}");
                  sessionController.pauseSession(session.id ?? 0);
                },
                width: 70,
                height1: 22,
                height2: 20,
                width2: 80,
                color2: AppColors.scheColor,
                heading: session.teamTitle ?? "Eranove Odyssey – Team A",
                text1: "Phase ${session.totalPhases ?? 1}",
                ishow: false,
                text2: "scheduled".tr,
                description: session.description ?? "Leadership Assessment strengthens teamwork through interactive activities.",
                text3: "Pause",
                text7: "start_early".tr,
                icon3: Icons.fast_forward,
                color3: AppColors.forwardColor,
                text5: "${session.totalPlayers ?? 0} Players",
                text6: session.startTime ?? "Starts in 2h",
                svg: Appimages.edit,
              ),
              SizedBox(height: 12 * heightScaleFactor),
            ],
          )).toList(),
          SizedBox(height: 20 * heightScaleFactor),
        ],
      );
    });
  }
}