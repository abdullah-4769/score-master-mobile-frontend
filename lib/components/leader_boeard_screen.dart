import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:scorer/components/metrices_Container.dart';
import 'package:scorer/components/players_Row.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/players_container.dart';
import '../api/api_controllers/player_leadrboard_controller.dart';
import '../api/api_controllers/team_leaderboard_controller.dart';

class LeaderBoardScreen extends StatefulWidget {
  LeaderBoardScreen({super.key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  final RxBool isTeamSelected = false.obs;

  final playerController = Get.put(PlayerLeaderboardController());

  final teamController = Get.put(TeamLeaderboardController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.025),

            // 🔹 Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: screenWidth * 0.035,
                      height: screenWidth * 0.035,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.visitingColor,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    MainText(
                      text: "live_updates".tr,
                      color: AppColors.visitingColor,
                      fontSize: screenWidth * 0.035,
                    ),
                  ],
                ),
                CreateContainer(
                  containerColor: AppColors.forwardColor.withOpacity(0.3),
                  text: "overall".tr,
                  width: screenWidth * 0.18,
                  textColor: AppColors.forwardColor,
                  borderColor: AppColors.forwardColor,
                  ishow: false,
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.04),

            // 🔹 Player/Team toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                      () => Row(
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
                        onToggle: (val) {
                          isTeamSelected.value = val;
                        },
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
                GestureDetector(
                  onTap: () {
                    showCustomBottomSheet(context: context);
                  },
                  child: CreateContainer(
                    text: "use_filter".tr,
                    width: screenWidth * 0.22,
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.08),

            // 🔹 Dynamic Leaderboard Section (based on sessionId)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              child: Column(
                children: [
                  // 🔸 Top 3 Section
                  Obx(() {
                    if (isTeamSelected.value
                        ? teamController.isLoading.value
                        : playerController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
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

                  // 🔸 Full leaderboard list
                  Obx(() {
                    if (isTeamSelected.value
                        ? teamController.isLoading.value
                        : playerController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
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
                          padding:
                          EdgeInsets.only(bottom: screenHeight * 0.018),
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
                ],
              ),
            ),

            // 🔹 Metrices + Buttons (unchanged)
            MetricesContainer(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            SizedBox(height: screenHeight * 0.03),

            LoginButton(
              fontSize: 18,
              onTap: () {
                Get.toNamed(RouteName.endSessionScreen);
              },
              text: "end_session".tr,
              color: AppColors.redColor,
              icon: Icons.square_sharp,
              ishow: true,
            ),
            SizedBox(height: screenHeight * 0.015),
            LoginButton(
              text: "share_results".tr,
              fontSize: 18,
              color: AppColors.forwardColor,
              image: Appimages.move,
              ishow: true,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}




















// import 'package:flutter/material.dart';
// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:get/get.dart';
// import 'package:scorer/components/metrices_Container.dart';
// import 'package:scorer/components/players_Row.dart';
// import 'package:scorer/constants/appcolors.dart';
// import 'package:scorer/constants/appimages.dart';
// import 'package:scorer/constants/routename.dart';
// import 'package:scorer/widgets/bold_text.dart';
// import 'package:scorer/widgets/create_container.dart';
// import 'package:scorer/widgets/login_button.dart';
// import 'package:scorer/widgets/main_text.dart';
// import 'package:scorer/widgets/players_container.dart';
//
// class LeaderBoeardScreen extends StatelessWidget {
//   LeaderBoeardScreen({super.key});
//
//   final RxBool isTeamSelected = false.obs;
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
//       child: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           children: [
//             SizedBox(height: screenHeight * 0.025),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       width: screenWidth * 0.035,
//                       height: screenWidth * 0.035,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: AppColors.visitingColor,
//                       ),
//                     ),
//                     SizedBox(width: screenWidth * 0.02),
//                     MainText(
//                       text: "live_updates".tr,
//                       color: AppColors.visitingColor,
//                       fontSize: screenWidth * 0.035,
//                     ),
//                   ],
//                 ),
//                 CreateContainer(
//                   containerColor: AppColors.forwardColor.withOpacity(0.3),
//                   text: "overall".tr,
//                   width: screenWidth * 0.18,
//                   textColor: AppColors.forwardColor,
//                   borderColor: AppColors.forwardColor,
//                   ishow: false,
//                 ),
//               ],
//             ),
//             SizedBox(height: screenHeight * 0.04),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Obx(
//                   () => Row(
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
//                         onToggle: (val) {
//                           isTeamSelected.value = val;
//                         },
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
//                 GestureDetector(
//                   onTap: () {
//                     showCustomBottomSheet(context: context);
//                   },
//                   child: CreateContainer(
//                     text: "use_filter".tr,
//                     width: screenWidth * 0.22,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: screenHeight * 0.1),
//             Obx(
//               () => PlayersRow(
//                 isTeamSelected: isTeamSelected.value,
//                 topThree: [],
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.04),
//             Obx(
//               () => PlayersContainers(
//                 text1: "1",
//                 text2: isTeamSelected.value ? "team_alpha".tr : "Alex M.",
//                 image: Appimages.facil2,
//                 icon: Icons.keyboard_arrow_up_outlined,
//                 iconColor: AppColors.arrowColor,
//                 text4: "2,890 pts",
//                 ishow: true,
//                 containerColor: AppColors.yellowColor,
//                 leftPadding: screenWidth * 0.05,
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.018),
//             Obx(
//               () => PlayersContainers(
//                 text1: "2",
//                 text2: isTeamSelected.value ? "Team Rock" : "Sarah J.",
//                 image: Appimages.play2,
//                 icon: Icons.keyboard_arrow_down_outlined,
//                 iconColor: AppColors.brownColor,
//                 text4: "2,890 pts",
//                 ishow: true,
//                 containerColor: AppColors.greyColor,
//                 leftPadding: screenWidth * 0.05,
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.018),
//             Obx(
//               () => PlayersContainers(
//                 text1: "3",
//                 text2: isTeamSelected.value ? "Team Beta" : "Mike C.",
//                 image: Appimages.play5,
//                 icon: Icons.keyboard_arrow_down_outlined,
//                 iconColor: AppColors.brownColor,
//                 text4: "2,180 pts",
//                 ishow: true,
//                 containerColor: AppColors.orangeColor,
//                 leftPadding: screenWidth * 0.05,
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.018),
//             PlayersContainers(
//               text1: "4",
//               text2: "Mike C.",
//               image: Appimages.play3,
//               icon: Icons.keyboard_arrow_down_outlined,
//               iconColor: AppColors.brownColor,
//               text4: "1,760 pts",
//               ishow: true,
//               containerColor: AppColors.playerColor,
//               leftPadding: screenWidth * 0.05,
//             ),
//             SizedBox(height: screenHeight * 0.018),
//             PlayersContainers(
//               text1: "5",
//               text2: "Mike C.",
//               image: Appimages.play4,
//               icon: Icons.keyboard_arrow_up_outlined,
//               iconColor: AppColors.forwardColor,
//               text4: "1,760 pts",
//               ishow: true,
//               containerColor: AppColors.playerColor,
//               leftPadding: screenWidth * 0.05,
//             ),
//             SizedBox(height: screenHeight * 0.025),
//             MetricesContainer(
//               screenWidth: screenWidth,
//               screenHeight: screenHeight,
//             ),
//             SizedBox(height: screenHeight * 0.03),
//             LoginButton(
//               fontSize: 18,
//
//               onTap: () {
//                 Get.toNamed(RouteName.endSessionScreen);
//               },
//               text: "end_session".tr,
//               color: AppColors.redColor,
//               icon: Icons.square_sharp,
//               ishow: true,
//             ),
//             SizedBox(height: screenHeight * 0.015),
//             LoginButton(
//               text: "share_results".tr,
//               fontSize: 18,
//               color: AppColors.forwardColor,
//               image: Appimages.move,
//               ishow: true,
//             ),
//             SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }
// }
