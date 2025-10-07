import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:scorer/api/api_controllers/player_leadrboard_controller.dart';
import 'package:scorer/api/api_controllers/team_leaderboard_controller.dart';
import 'package:scorer/components/players_Row.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/players_container.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';

class PlayerLeaderboardScreen extends StatefulWidget {
  const PlayerLeaderboardScreen({super.key});

  @override
  State<PlayerLeaderboardScreen> createState() =>
      _PlayerLeaderboardScreenState();
}

class _PlayerLeaderboardScreenState extends State<PlayerLeaderboardScreen>
    with WidgetsBindingObserver {
  final RxBool isTeamSelected = false.obs;

  // ✅ Use Get.put once globally (permanent)
  final PlayerLeaderboardController playerController =
  Get.put(PlayerLeaderboardController(), permanent: true);
  final TeamLeaderboardController teamController =
  Get.put(TeamLeaderboardController(), permanent: true);

  static const int sessionId = 1; // fixed as per requirement

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadLeaderboards(); // load once initially
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Refresh when app comes back to foreground
    if (state == AppLifecycleState.resumed) {
      _loadLeaderboards();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _loadLeaderboards() async {
    await Future.wait([
      playerController.loadLeaderboard(sessionId),
      teamController.loadLeaderboard(sessionId),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 13),
                // 🔹 Header Row
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Row(
                    children: [
                      Image.asset(Appimages.player2, height: 63, width: 50),
                      Expanded(
                        child: Center(
                          child: BoldText(
                            text: "team_alpha".tr,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Image.asset(Appimages.house1, height: 63, width: 80),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                // 🔹 Switch for Players/Teams
                Obx(
                      () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BoldText(
                        text: "players".tr,
                        selectionColor: isTeamSelected.value
                            ? AppColors.playerColo1r
                            : AppColors.blueColor,
                        fontSize: screenWidth * 0.04,
                      ),
                      SizedBox(width: screenWidth * 0.025),
                      FlutterSwitch(
                        value: isTeamSelected.value,
                        onToggle: (val) => isTeamSelected.value = val,
                        height: screenHeight * 0.03,
                        width: screenWidth * 0.1,
                        activeColor: AppColors.forwardColor,
                        inactiveColor: AppColors.forwardColor,
                      ),
                      SizedBox(width: screenWidth * 0.025),
                      BoldText(
                        text: "teams".tr,
                        selectionColor: isTeamSelected.value
                            ? AppColors.blueColor
                            : AppColors.playerColo1r,
                        fontSize: screenWidth * 0.04,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                // 🔹 Live update indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenWidth * 0.035,
                      height: screenWidth * 0.035,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.visitingColor,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    MainText(
                      text: "live_updates".tr,
                      color: AppColors.visitingColor,
                      fontSize: screenWidth * 0.035,
                    )
                  ],
                ),

                SizedBox(height: screenHeight * 0.025),

                // 🔹 Current Rank Container
                Obx(
                      () => CreateContainer(
                    text: isTeamSelected.value
                        ? "your_team_rank_2nd".tr
                        : "your_rank_2nd".tr,
                    width: isTeamSelected.value
                        ? screenWidth * 0.466
                        : screenWidth * 0.347,
                  ),
                ),

                SizedBox(height: screenHeight * 0.08),

                // 🔹 Leaderboard Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  child: Column(
                    children: [
                      // 🔸 Top 3 (Show localized loader only for leaderboard)
                      Obx(() {
                        if (isTeamSelected.value
                            ? teamController.isLoading.value
                            : playerController.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final topThree = isTeamSelected.value
                            ? teamController.top3
                            .map((t) => {
                          "rank": t.rank,
                          "name": t.sessionDescription,
                          "points": t.totalPoints,
                        })
                            .toList()
                            : playerController.top3
                            .map((p) => {
                          "rank": p.rank,
                          "name": p.playerName,
                          "points": p.totalPoints,
                        })
                            .toList();

                        return PlayersRow(
                          isTeamSelected: isTeamSelected.value,
                          topThree: topThree,
                        );
                      }),

                      SizedBox(height: screenHeight * 0.035),

                      // 🔸 Full leaderboard list (includes top 3 now)
                      Obx(() {
                        if (isTeamSelected.value
                            ? teamController.isLoading.value
                            : playerController.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final list = isTeamSelected.value
                            ? [
                          ...teamController.top3,
                          ...teamController.remaining,
                        ].map((t) {
                          return {
                            "rank": t.rank,
                            "name": t.sessionDescription,
                            "points": t.totalPoints,
                          };
                        }).toList()
                            : [
                          ...playerController.top3,
                          ...playerController.remaining,
                        ].map((p) {
                          return {
                            "rank": p.rank,
                            "name": p.playerName,
                            "points": p.totalPoints,
                          };
                        }).toList();

                        return Column(
                          children: List.generate(list.length, (index) {
                            final data = list[index];
                            final rank = data["rank"];

                            // 🎨 Rank-based colors
                            Color bgColor;
                            Color arrowColor;
                            IconData arrowIcon;

                            if (rank == 1) {
                              bgColor = AppColors.yellowColor;
                              arrowColor = AppColors.forwardColor;
                              arrowIcon = Icons.arrow_drop_up;
                            } else if (rank == 2) {
                              bgColor = AppColors.newggrey;
                              arrowColor = AppColors.redColor;
                              arrowIcon = Icons.arrow_drop_down;
                            } else if (rank == 3) {
                              bgColor = AppColors.orangeColor;
                              arrowColor = AppColors.redColor;
                              arrowIcon = Icons.arrow_drop_down;
                            } else {
                              bgColor = AppColors.playerColor;
                              arrowColor = AppColors.forwardColor;
                              arrowIcon = Icons.arrow_drop_up;
                            }

                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom: screenHeight * 0.018),
                              child: PlayersContainers(
                                text1: data["rank"].toString(),
                                text2: data["name"] as String,
                                image: Appimages.play2,
                                icon: arrowIcon,
                                iconColor: arrowColor,
                                text4: "${data["points"]} pts",
                                ishow: true,
                                containerColor: bgColor,
                                leftPadding: screenWidth * 0.05,
                              ),
                            );
                          }),
                        );
                      }),

                      SizedBox(height: screenHeight * 0.025),

                      // 🔹 Buttons
                      LoginButton(
                        fontSize: 19,
                        text: "share_results".tr,
                        ishow: true,
                        color: AppColors.redColor,
                        image: Appimages.move,
                      ),
                      SizedBox(height: screenHeight * 0.012),
                      LoginButton(
                        fontSize: 19,
                        text: "export_data".tr,
                        ishow: true,
                        image: Appimages.export,
                      ),
                      SizedBox(height: screenHeight * 0.04),
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































// import 'package:flutter/material.dart';
// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:get/get.dart';
// import 'package:scorer/api/api_controllers/player_leadrboard_controller.dart';
// import 'package:scorer/api/api_controllers/team_leaderboard_controller.dart';
// import 'package:scorer/components/players_Row.dart';
// import 'package:scorer/constants/appcolors.dart';
// import 'package:scorer/constants/appimages.dart';
// import 'package:scorer/widgets/bold_text.dart';
// import 'package:scorer/widgets/create_container.dart';
// import 'package:scorer/widgets/login_button.dart';
// import 'package:scorer/widgets/main_text.dart';
// import 'package:scorer/widgets/players_container.dart';
// import 'package:scorer/view/FacilitateFolder/aa.dart';
//
// class PlayerLeaderboardScreen extends StatefulWidget {
//   const PlayerLeaderboardScreen({super.key});
//
//   @override
//   State<PlayerLeaderboardScreen> createState() =>
//       _PlayerLeaderboardScreenState();
// }
//
// class _PlayerLeaderboardScreenState extends State<PlayerLeaderboardScreen>
//     with WidgetsBindingObserver {
//   final RxBool isTeamSelected = false.obs;
//
//   // ✅ Use Get.find to prevent duplicate controller instances
//   final PlayerLeaderboardController playerController =
//   Get.put(PlayerLeaderboardController(), permanent: true);
//   final TeamLeaderboardController teamController =
//   Get.put(TeamLeaderboardController(), permanent: true);
//
//   static const int sessionId = 1; // fixed as per requirement
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _loadLeaderboards(); // load once initially
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     // Refresh when app comes back to foreground
//     if (state == AppLifecycleState.resumed) {
//       _loadLeaderboards();
//     }
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   Future<void> _loadLeaderboards() async {
//     await Future.wait([
//       playerController.loadLeaderboard(sessionId),
//       teamController.loadLeaderboard(sessionId),
//     ]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       body: GradientBackground(
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 const SizedBox(height: 13),
//                 // 🔹 Header Row
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//                   child: Row(
//                     children: [
//                       Image.asset(Appimages.player2, height: 63, width: 50),
//                       Expanded(
//                         child: Center(
//                           child: BoldText(
//                             text: "team_alpha".tr,
//                             fontSize: 22,
//                           ),
//                         ),
//                       ),
//                       Image.asset(Appimages.house1, height: 63, width: 80),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: screenHeight * 0.03),
//
//                 // 🔹 Switch for Players/Teams
//                 Obx(
//                       () => Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       BoldText(
//                         text: "players".tr,
//                         selectionColor: isTeamSelected.value
//                             ? AppColors.playerColo1r
//                             : AppColors.blueColor,
//                         fontSize: screenWidth * 0.04,
//                       ),
//                       SizedBox(width: screenWidth * 0.025),
//                       FlutterSwitch(
//                         value: isTeamSelected.value,
//                         onToggle: (val) => isTeamSelected.value = val,
//                         height: screenHeight * 0.03,
//                         width: screenWidth * 0.1,
//                         activeColor: AppColors.forwardColor,
//                         inactiveColor: AppColors.forwardColor,
//                       ),
//                       SizedBox(width: screenWidth * 0.025),
//                       BoldText(
//                         text: "teams".tr,
//                         selectionColor: isTeamSelected.value
//                             ? AppColors.blueColor
//                             : AppColors.playerColo1r,
//                         fontSize: screenWidth * 0.04,
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: screenHeight * 0.02),
//
//                 // 🔹 Live update indicator
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: screenWidth * 0.035,
//                       height: screenWidth * 0.035,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: AppColors.visitingColor,
//                       ),
//                     ),
//                     SizedBox(width: screenWidth * 0.02),
//                     MainText(
//                       text: "live_updates".tr,
//                       color: AppColors.visitingColor,
//                       fontSize: screenWidth * 0.035,
//                     )
//                   ],
//                 ),
//
//                 SizedBox(height: screenHeight * 0.025),
//
//                 // 🔹 Current Rank Container
//                 Obx(
//                       () => CreateContainer(
//                     text: isTeamSelected.value
//                         ? "your_team_rank_2nd".tr
//                         : "your_rank_2nd".tr,
//                     width: isTeamSelected.value
//                         ? screenWidth * 0.466
//                         : screenWidth * 0.347,
//                   ),
//                 ),
//
//                 SizedBox(height: screenHeight * 0.08),
//
//                 // 🔹 Leaderboard Section
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
//                   child: Column(
//                     children: [
//                       // 🔸 Top 3 (Show localized loader only for leaderboard)
//                       Obx(() {
//                         if (isTeamSelected.value
//                             ? teamController.isLoading.value
//                             : playerController.isLoading.value) {
//                           return const Center(
//                             child: CircularProgressIndicator(),
//                           );
//                         }
//
//                         final topThree = isTeamSelected.value
//                             ? teamController.top3
//                             .map((t) => {
//                           "rank": t.rank,
//                           "name": t.sessionDescription,
//                           "points": t.totalPoints,
//                         })
//                             .toList()
//                             : playerController.top3
//                             .map((p) => {
//                           "rank": p.rank,
//                           "name": p.playerName,
//                           "points": p.totalPoints,
//                         })
//                             .toList();
//
//                         return PlayersRow(
//                           isTeamSelected: isTeamSelected.value,
//                           topThree: topThree,
//                         );
//                       }),
//
//                       SizedBox(height: screenHeight * 0.035),
//
//                       // 🔸 Remaining list
//                       Obx(() {
//                         if (isTeamSelected.value
//                             ? teamController.isLoading.value
//                             : playerController.isLoading.value) {
//                           return const Center(
//                             child: CircularProgressIndicator(),
//                           );
//                         }
//
//                         final list = isTeamSelected.value
//                             ? teamController.remaining.map((t) {
//                           return {
//                             "rank": t.rank,
//                             "name": t.sessionDescription,
//                             "points": t.totalPoints,
//                           };
//                         }).toList()
//                             : playerController.remaining.map((p) {
//                           return {
//                             "rank": p.rank,
//                             "name": p.playerName,
//                             "points": p.totalPoints,
//                           };
//                         }).toList();
//
//                         return Column(
//                           children: List.generate(list.length, (index) {
//                             final data = list[index];
//                             final rank = data["rank"];
//
//                             // 🎨 Rank-based colors
//                             Color bgColor;
//                             Color arrowColor;
//                             IconData arrowIcon;
//
//                             if (rank == 1) {
//                               bgColor = AppColors.yellowColor;
//                               arrowColor = AppColors.forwardColor;
//                               arrowIcon = Icons.arrow_drop_up;
//                             } else if (rank == 2) {
//                               bgColor = AppColors.newggrey;
//                               arrowColor = AppColors.redColor;
//                               arrowIcon = Icons.arrow_drop_down;
//                             } else if (rank == 3) {
//                               bgColor = AppColors.orangeColor;
//                               arrowColor = AppColors.redColor;
//                               arrowIcon = Icons.arrow_drop_down;
//                             } else {
//                               bgColor = AppColors.playerColor;
//                               arrowColor = AppColors.forwardColor;
//                               arrowIcon = Icons.arrow_drop_up;
//                             }
//
//                             return Padding(
//                               padding: EdgeInsets.only(
//                                   bottom: screenHeight * 0.018),
//                               child: PlayersContainers(
//                                 text1: data["rank"].toString(),
//                                 text2: data["name"] as String,
//                                 image: Appimages.play2,
//                                 icon: arrowIcon,
//                                 iconColor: arrowColor,
//                                 text4: "${data["points"]} pts",
//                                 ishow: true,
//                                 containerColor: bgColor,
//                                 leftPadding: screenWidth * 0.05,
//                               ),
//                             );
//                           }),
//                         );
//                       }),
//
//                       SizedBox(height: screenHeight * 0.025),
//
//                       // 🔹 Buttons
//                       LoginButton(
//                         fontSize: 19,
//                         text: "share_results".tr,
//                         ishow: true,
//                         color: AppColors.redColor,
//                         image: Appimages.move,
//                       ),
//                       SizedBox(height: screenHeight * 0.012),
//                       LoginButton(
//                         fontSize: 19,
//                         text: "export_data".tr,
//                         ishow: true,
//                         image: Appimages.export,
//                       ),
//                       SizedBox(height: screenHeight * 0.04),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
