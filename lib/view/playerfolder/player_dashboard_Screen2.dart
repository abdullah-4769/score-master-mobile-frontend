import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart'; // for firstWhereOrNull
import 'package:scorer/components/abcd_container.dart';
import 'package:scorer/components/device_connect_note.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/players_container.dart';
import '../../api/api_controllers/session_list_controller.dart';
import '../../api/api_controllers/team_view_controller.dart';
import '../../widgets/create_container.dart';
import '../../widgets/login_button.dart';
import '../../widgets/main_text.dart';
import '../FacilitateFolder/aa.dart';

class PlayerDashboardScreen2 extends StatefulWidget {
  const PlayerDashboardScreen2({super.key});

  @override
  State<PlayerDashboardScreen2> createState() => _PlayerDashboardScreen2State();
}

class _PlayerDashboardScreen2State extends State<PlayerDashboardScreen2> {
  final TeamViewController teamController = Get.put(TeamViewController());
  final SessionsListController sessionsController =
  Get.put(SessionsListController());

  bool _snackbarShown = false;

  @override
  void initState() {
    super.initState();

    /// Fetch APIs only once when screen opens
    Future.delayed(Duration.zero, () async {
      await teamController.loadTeams();
      await sessionsController.fetchSessions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    const double baseHeight = 812.0;
    const double baseWidth = 414.0;
    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 🔹 Header (static, no rebuild)
                Padding(
                  padding: EdgeInsets.only(
                    left: 30 * widthScaleFactor,
                    right: 10 * widthScaleFactor,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        Appimages.player2,
                        height: 63 * heightScaleFactor,
                        width: 50 * widthScaleFactor,
                      ),
                      Expanded(
                        child: Center(
                          child: BoldText(
                            text: "Team Alpha",
                            fontSize: 22 * widthScaleFactor,
                          ),
                        ),
                      ),
                      Image.asset(
                        Appimages.house1,
                        height: 63 * heightScaleFactor,
                        width: 80 * widthScaleFactor,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10 * heightScaleFactor),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32 * widthScaleFactor,
                  ),
                  child: Column(
                    children: [
                      // 🔹 TEAM INFO SECTION (shows loader only here)
                      Obx(() {
                        if (teamController.isLoading.value) {
                          return SizedBox(
                            height: 200 * heightScaleFactor,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        final teamData = teamController.teamView.value;
                        if (teamData == null) {
                          if (!_snackbarShown) {
                            _snackbarShown = true;
                            Get.snackbar(
                              "No Team Data",
                              "Unable to load team information",
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                            );
                          }
                          return Center(
                            child: Text(
                              "No team data available",
                              style: TextStyle(color: Colors.white70),
                            ),
                          );
                        }

                        final facilitatorName =
                        teamData.gameFormat.facilitators.isNotEmpty
                            ? teamData.gameFormat.facilitators[0].name
                            .split(" ")
                            .map((e) => e.isNotEmpty
                            ? e[0].toUpperCase() + e.substring(1)
                            : "")
                            .join(" ")
                            : "N/A";

                        return Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                SizedBox(
                                  height: 170 * heightScaleFactor,
                                  child: Image.asset(
                                    Appimages.group,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Positioned(
                                  bottom: -2 * heightScaleFactor,
                                  right: 15 * widthScaleFactor,
                                  child: CreateContainer(
                                    fontsize2: 12,
                                    text:
                                    "${teamData.gameFormat.id} Phases", // ✅ dynamic
                                    width: 90 * widthScaleFactor,
                                    height: 30 * heightScaleFactor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20 * heightScaleFactor),

                            BoldText(
                              text: "team_building_workshop".tr,
                              fontSize: 16 * heightScaleFactor,
                              selectionColor: AppColors.blueColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  Appimages.person,
                                  height: 18 * heightScaleFactor,
                                  width: 18 * widthScaleFactor,
                                ),
                                SizedBox(width: 8 * widthScaleFactor),
                                MainText(
                                  text: "Facilitator: $facilitatorName",
                                  fontSize: 14 * widthScaleFactor,
                                ),
                              ],
                            ),
                          ],
                        );
                      }),

                      SizedBox(height: 30 * heightScaleFactor),

                      // 🔹 SESSION CODE SECTION (shows loader only here)
                      Obx(() {
                        if (sessionsController.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final currentSession =
                        sessionsController.activeSessions.isNotEmpty
                            ? sessionsController.activeSessions.first
                            : sessionsController.scheduledSessions.isNotEmpty
                            ? sessionsController
                            .scheduledSessions.first
                            : null;

                        if (currentSession == null) {
                          return Center(
                            child: Text(
                              "No session data available",
                              style: TextStyle(color: Colors.white70),
                            ),
                          );
                        }

                        return ABCDContainer(
                          widthScaleFactor: widthScaleFactor,
                          heightScaleFactor: heightScaleFactor,
                          sessionCode: currentSession.joinCode ??
                              "N/A", // ✅ dynamic session code
                        );
                      }),

                      SizedBox(height: 30 * heightScaleFactor),

                      Row(
                        children: [
                          Container(
                            height: 8 * heightScaleFactor,
                            width: 8 * widthScaleFactor,
                            decoration: BoxDecoration(
                              color: AppColors.brownColor2,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 8 * widthScaleFactor),
                          MainText(
                            text: "waiting_facilitator_start".tr,
                            fontSize: 12 * widthScaleFactor,
                          ),
                        ],
                      ),
                      SizedBox(height: 20 * heightScaleFactor),

                      // 🔹 PLAYERS LIST SECTION (shows loader only here)
                      Obx(() {
                        if (teamController.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final teamData = teamController.teamView.value;
                        if (teamData == null || teamData.teams.isEmpty) {
                          return const Center(
                            child: Text(
                              "No players joined yet",
                              style: TextStyle(color: Colors.white70),
                            ),
                          );
                        }

                        return Column(
                          children:
                          teamData.teams.asMap().entries.map((entry) {
                            final index = entry.key;
                            final team = entry.value;
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom: 15 * heightScaleFactor),
                              child: PlayersContainers(
                                color: AppColors.forwardColor,
                                text3: "joined".tr,
                                text1: (index + 1).toString(),
                                text2: team.nickname,
                                image: Appimages.play1,
                              ),
                            );
                          }).toList(),
                        );
                      }),

                      DeviceConnectNote(
                        widthScaleFactor: widthScaleFactor,
                        heightScaleFactor: heightScaleFactor,
                      ),
                      SizedBox(height: 15 * heightScaleFactor),

                      LoginButton(
                        onTap: () =>
                            Get.toNamed(RouteName.gameStart1Screen),
                        text: "leave_session".tr,
                        ishow: true,
                        image: Appimages.leave,
                        color: AppColors.redColor,
                        height: 75 * heightScaleFactor,
                        fontSize: 18 * widthScaleFactor,
                      ),
                      SizedBox(height: 60 * heightScaleFactor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
