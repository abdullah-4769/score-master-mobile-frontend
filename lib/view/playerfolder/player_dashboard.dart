import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/custom_dashboard_container.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/setting_container.dart';
import '../../api/api_controllers/join_session_controller.dart';
import '../../api/api_controllers/login_controllers.dart';
import '../../api/api_controllers/session_list_controller.dart';
import '../../widgets/player_side_widget/join_session_wideget.dart';
import '../FacilitateFolder/aa.dart';

class PlayerDashboard extends StatelessWidget {
  PlayerDashboard({super.key});

  final LoginController authController = Get.find<LoginController>();
  final JoinSessionController joinController = Get.put(JoinSessionController());
  final SessionsListController sessionsController = Get.put(SessionsListController());

  String capitalizeEachWord(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map((word) =>
    word.isEmpty ? word : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}')
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    final int playerId = authController.user.value!.id;
    const double baseHeight = 812.0;
    const double baseWidth = 414.0;
    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32 * widthScaleFactor),
            child: RefreshIndicator(
              onRefresh: sessionsController.refreshSessions,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // top row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          Appimages.player2,
                          width: 62 * widthScaleFactor,
                          height: 83 * heightScaleFactor,
                        ),
                        Row(
                          children: [
                            SettingContainer(icons: Icons.settings),
                            SizedBox(width: 6 * widthScaleFactor),
                            SettingContainer(
                              icons: Icons.notifications,
                              ishow: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20 * heightScaleFactor),
                    BoldText(
                      text: "welcome_scoremaster".tr,
                      fontSize: 16 * heightScaleFactor,
                      selectionColor: AppColors.blueColor,
                    ),
                    MainText(
                      text: "join_session_text".tr,
                      fontSize: 14 * heightScaleFactor,
                      height: 1.4,
                    ),
                    SizedBox(height: 20 * heightScaleFactor),

                    Center(child: JoinSessionWidget(playerId: playerId)),

                    SizedBox(height: 18 * heightScaleFactor),

                    // Sessions data (only reactive part)
                    Obx(() {
                      if (sessionsController.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(color: AppColors.forwardColor),
                        );
                      }

                      final activeSessions = sessionsController.activeSessions;
                      final scheduledSessions = sessionsController.scheduledSessions;

                      if (activeSessions.isEmpty && scheduledSessions.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 50 * heightScaleFactor),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.event_busy,
                                  size: 48 * heightScaleFactor,
                                  color: AppColors.greyColor,
                                ),
                                SizedBox(height: 12 * heightScaleFactor),
                                MainText(
                                  text: "no_sessions_available".tr,
                                  fontSize: 14 * heightScaleFactor,
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (activeSessions.isNotEmpty) ...[
                            BoldText(
                              text: "active_sessions".tr,
                              fontSize: 14 * heightScaleFactor,
                              selectionColor: AppColors.blueColor,
                            ),
                            SizedBox(height: 12 * heightScaleFactor),
                            ...activeSessions.map((session) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 12 * heightScaleFactor),
                                child: Center(
                                  child: CustomDashboardContainer(
                                    onTap: () => joinController.joinSession(
                                      playerId,
                                      session.joinCode,
                                    ),
                                    arrowshow: false,
                                    horizontal: 0,
                                    width2: 78,
                                    color2: AppColors.forwardColor,
                                    heading: capitalizeEachWord(session.teamTitle),
                                    text1: "Phase ${session.totalPhases}",
                                    ishow: false,
                                    text2: "Active",
                                    color1: AppColors.orangeColor,
                                    description: session.description,
                                    text7: "join_session".tr,
                                    icon3: Icons.play_arrow,
                                    color3: AppColors.forwardColor,
                                    text5:
                                    "${session.totalPlayers} ${"players".tr}",
                                    text6: (session.remainingTime != null &&
                                        session.remainingTime! > 0)
                                        ? "${session.remainingTime} min left"
                                        : "In Progress",
                                    smallImage: Appimages.timeout2,
                                  ),
                                ),
                              );
                            }),
                          ],
                          if (scheduledSessions.isNotEmpty) ...[
                            SizedBox(height: 12 * heightScaleFactor),
                            BoldText(
                              text: "scheduled_sessions".tr,
                              fontSize: 14 * heightScaleFactor,
                              selectionColor: AppColors.blueColor,
                            ),
                            SizedBox(height: 12 * heightScaleFactor),
                            ...scheduledSessions.map((session) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 12 * heightScaleFactor),
                                child: CustomDashboardContainer(
                                  onTap: () => sessionsController.selectSession(
                                    session.id,
                                    routeName: RouteName.playerLoginPlaySide,
                                  ),
                                  arrowshow: true,
                                  horizontal: 0,
                                  width2: 78,
                                  color2: AppColors.scheColor,
                                  heading: capitalizeEachWord(session.teamTitle),
                                  text1: "Phase ${session.totalPhases}",
                                  ishow: false,
                                  text2: "scheduled".tr,
                                  color1: AppColors.orangeColor,
                                  description: session.description,
                                  text7: "join_session".tr,
                                  icon3: Icons.schedule,
                                  color3: AppColors.scheColor,
                                  text5:
                                  "${session.totalPlayers} ${"players".tr}",
                                  text6: session.startTime != null
                                      ? "Starts at ${DateFormat('hh:mm a').format(session.startTime!)}"
                                      : "Starts Soon",
                                  smallImage: Appimages.timeout2,
                                ),
                              );
                            }),
                          ],
                        ],
                      );
                    }),

                    SizedBox(height: 20 * heightScaleFactor),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}























// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:scorer/constants/appcolors.dart';
// import 'package:scorer/constants/appimages.dart';
// import 'package:scorer/constants/routename.dart';
// import 'package:scorer/widgets/bold_text.dart';
// import 'package:scorer/widgets/custom_dashboard_container.dart';
// import 'package:scorer/widgets/main_text.dart';
// import 'package:scorer/widgets/setting_container.dart';
// import '../../api/api_controllers/join_session_controller.dart';
// import '../../api/api_controllers/login_controllers.dart';
// import '../../api/api_controllers/session_list_controller.dart';
// import '../../widgets/player_side_widget/join_session_wideget.dart';
// import '../FacilitateFolder/aa.dart';
//
// class PlayerDashboard extends StatelessWidget {
//   PlayerDashboard({super.key});
//
//   final LoginController authController = Get.find<LoginController>();
//   final JoinSessionController joinController = Get.put(JoinSessionController());
//   final SessionsListController sessionsController =
//   Get.put(SessionsListController());
//
//   String capitalizeEachWord(String text) {
//     if (text.isEmpty) return text;
//     return text
//         .split(' ')
//         .map((word) => word.isEmpty
//         ? word
//         : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}')
//         .join(' ');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;
//     final double screenHeight = screenSize.height;
//     final double screenWidth = screenSize.width;
//
//     final int playerId = authController.user.value!.id;
//     const double baseHeight = 812.0;
//     const double baseWidth = 414.0;
//     final double heightScaleFactor = screenHeight / baseHeight;
//     final double widthScaleFactor = screenWidth / baseWidth;
//
//     return Scaffold(
//       body: GradientBackground(
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 32 * widthScaleFactor),
//             child: Obx(() {
//               if (sessionsController.isLoading.value) {
//                 return Center(
//                   child:
//                   CircularProgressIndicator(color: AppColors.forwardColor),
//                 );
//               }
//
//               return RefreshIndicator(
//                 onRefresh: sessionsController.refreshSessions,
//                 child: SingleChildScrollView(
//                   physics: AlwaysScrollableScrollPhysics(),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // top row
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Image.asset(
//                             Appimages.player2,
//                             width: 62 * widthScaleFactor,
//                             height: 83 * heightScaleFactor,
//                           ),
//                           Row(
//                             children: [
//                               SettingContainer(icons: Icons.settings),
//                               SizedBox(width: 6 * widthScaleFactor),
//                               SettingContainer(
//                                 icons: Icons.notifications,
//                                 ishow: true,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 20 * heightScaleFactor),
//                       BoldText(
//                         text: "welcome_scoremaster".tr,
//                         fontSize: 16 * heightScaleFactor,
//                         selectionColor: AppColors.blueColor,
//                       ),
//                       MainText(
//                         text: "join_session_text".tr,
//                         fontSize: 14 * heightScaleFactor,
//                         height: 1.4,
//                       ),
//                       SizedBox(height: 20 * heightScaleFactor),
//
//                       Center(child: JoinSessionWidget(playerId: playerId)),
//
//                       SizedBox(height: 18 * heightScaleFactor),
//
//                       // Active Sessions
//                       if (sessionsController.activeSessions.isNotEmpty) ...[
//                         BoldText(
//                           text: "active_sessions".tr,
//                           fontSize: 14 * heightScaleFactor,
//                           selectionColor: AppColors.blueColor,
//                         ),
//                         SizedBox(height: 12 * heightScaleFactor),
//                         ...sessionsController.activeSessions.map((session) {
//                           return Padding(
//                             padding:
//                             EdgeInsets.only(bottom: 12 * heightScaleFactor),
//                             child: Center(
//                               child: CustomDashboardContainer(
//                                 onTap: () {
//                                   joinController.joinSession(
//                                     playerId,
//                                     session.joinCode,
//                                   );
//                                 },
//                                 arrowshow: false,
//                                 horizontal: 0,
//                                 width2: 78,
//                                 color2: AppColors.forwardColor,
//                                 heading: capitalizeEachWord(session.teamTitle),
//                                 text1: "Phase ${session.totalPhases}",
//                                 ishow: false,
//                                 text2: "Active",
//                                 color1: AppColors.orangeColor,
//                                 description: session.description,
//                                 text7: "join_session".tr,
//                                 icon3: Icons.play_arrow,
//                                 color3: AppColors.forwardColor,
//                                 text5:
//                                 "${session.totalPlayers} ${"players".tr}",
//                                 text6: (session.remainingTime != null &&
//                                     session.remainingTime! > 0)
//                                     ? "${session.remainingTime} min left"
//                                     : "In Progress",
//                                 smallImage: Appimages.timeout2,
//                               ),
//                             ),
//                           );
//                         }),
//                       ],
//
//                       // Scheduled Sessions
//                       if (sessionsController.scheduledSessions.isNotEmpty) ...[
//                         SizedBox(height: 12 * heightScaleFactor),
//                         BoldText(
//                           text: "scheduled_sessions".tr,
//                           fontSize: 14 * heightScaleFactor,
//                           selectionColor: AppColors.blueColor,
//                         ),
//                         SizedBox(height: 12 * heightScaleFactor),
//                         ...sessionsController.scheduledSessions.map((session) {
//                           return Padding(
//                             padding:
//                             EdgeInsets.only(bottom: 12 * heightScaleFactor),
//                             child: CustomDashboardContainer(
//                               onTap: () => sessionsController.selectSession(
//                                 session.id,
//                                 routeName: RouteName.playerLoginPlaySide,
//                               ),
//                               arrowshow: true,
//                               horizontal: 0,
//                               width2: 78,
//                               color2: AppColors.scheColor,
//                               heading: capitalizeEachWord(session.teamTitle),
//                               text1: "Phase ${session.totalPhases}",
//                               ishow: false,
//                               text2: "scheduled".tr,
//                               color1: AppColors.orangeColor,
//                               description: session.description,
//                               text7: "join_session".tr,
//                               icon3: Icons.schedule,
//                               color3: AppColors.scheColor,
//                               text5:
//                               "${session.totalPlayers} ${"players".tr}",
//                               text6: session.startTime != null
//                                   ? "Starts at ${DateFormat('hh:mm a').format(session.startTime!)}"
//                                   : "Starts Soon",
//
//                               smallImage: Appimages.timeout2,
//                             ),
//                           );
//                         }),
//                       ],
//
//                       // Empty State
//                       if (sessionsController.activeSessions.isEmpty &&
//                           sessionsController.scheduledSessions.isEmpty)
//                         Center(
//                           child: Padding(
//                             padding:
//                             EdgeInsets.only(top: 50 * heightScaleFactor),
//                             child: Column(
//                               children: [
//                                 Icon(
//                                   Icons.event_busy,
//                                   size: 48 * heightScaleFactor,
//                                   color: AppColors.greyColor,
//                                 ),
//                                 SizedBox(height: 12 * heightScaleFactor),
//                                 MainText(
//                                   text: "no_sessions_available".tr,
//                                   fontSize: 14 * heightScaleFactor,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       SizedBox(height: 20 * heightScaleFactor),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }
