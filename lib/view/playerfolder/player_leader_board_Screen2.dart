
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:scorer/components/back_stack_container.dart';
import 'package:scorer/components/players_Row.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/players_container.dart' show PlayersContainers;

class PlayerLeaderBoardScreen2 extends StatelessWidget {
  final RxBool isTeamSelected = false.obs;

  PlayerLeaderBoardScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 13,),
                    Padding(

                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,

                      ),
                      child: Row(
                        children: [
                          Image.asset(Appimages.player2, height: 63, width: 50),
                          Expanded(
                            child: Center(
                              child: BoldText(text: "team_alpha".tr, fontSize: 22),
                            ),
                          ),
                          Image.asset(Appimages.house1, height: 63, width: 80),
                        ],
                      ),
                    ),


                    SizedBox(height: screenHeight * 0.03),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BoldText(
                            text: "players".tr,
                            selectionColor: isTeamSelected.value ? AppColors.playerColo1r : AppColors.blueColor,
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
                            selectionColor: isTeamSelected.value ? AppColors.blueColor : AppColors.playerColo1r,
                            fontSize: screenWidth * 0.04,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        )
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    Obx(
                      () => CreateContainer(
                        text: isTeamSelected.value ? "your_team_rank_2nd".tr : "your_rank_2nd".tr,

                        width: isTeamSelected.value ? screenWidth * 0.45 : screenWidth * 0.33,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.1),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                      child: Column(
                        children: [
                          Obx(() => PlayersRow(isTeamSelected: isTeamSelected.value, topThree: [],)),
                          SizedBox(height: screenHeight * 0.035),
                          Obx(
                            () => PlayersContainers(
                              text1: "1",
                              text2: isTeamSelected.value ? "team_alpha".tr : "Alex M.",
                              image: Appimages.facil2,
                              icon: Icons.keyboard_arrow_up_outlined,
                              iconColor: AppColors.arrowColor,
                              text4: "2,890 pts",
                              ishow: true,
                              containerColor: AppColors.yellowColor,
                              leftPadding: screenWidth * 0.05,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.018),
                          Obx(
                            () => PlayersContainers(
                              text1: "2",
                              text2: isTeamSelected.value ? "Team Rock" : "Sarah J.",
                              image: Appimages.play2,
                              icon: Icons.keyboard_arrow_down_outlined,
                              iconColor: AppColors.brownColor,
                              text4: "2,890 pts",
                              ishow: true,
                              containerColor: AppColors.greyColor,
                              leftPadding: screenWidth * 0.05,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.018),
                          Obx(
                            () => PlayersContainers(
                              text1: "3",
                              text2: isTeamSelected.value ? "Team Beta" : "Mike C.",
                              image: Appimages.play5,
                              icon: Icons.keyboard_arrow_down_outlined,
                              iconColor: AppColors.brownColor,
                              text4: "2,180 pts",
                              ishow: true,
                              containerColor: AppColors.orangeColor,
                              leftPadding: screenWidth * 0.05,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.018),
                          PlayersContainers(
                            text1: "4",
                            text2: "Mike C.",
                            image: Appimages.play3,
                            icon: Icons.keyboard_arrow_down_outlined,
                            iconColor: AppColors.brownColor,
                            text4: "1,760 pts",
                            ishow: true,
                            containerColor: AppColors.playerColor,
                            leftPadding: screenWidth * 0.05,
                          ),
                          SizedBox(height: screenHeight * 0.018),
                          PlayersContainers(
                            text1: "5",
                            text2: "Mike C.",
                            image: Appimages.play4,
                            icon: Icons.keyboard_arrow_up_outlined,
                            iconColor: AppColors.forwardColor,
                            text4: "1,760 pts",
                            ishow: true,
                            containerColor: AppColors.playerColor,
                            leftPadding: screenWidth * 0.05,
                          ),
                          SizedBox(height: screenHeight * 0.025),
                          LoginButton(
                            fontSize: 19,

                            text: "move_to_phase_3".tr,
                            color: AppColors.forwardColor,
                            ishow: true,
                            image: Appimages.submit,
                          ),
                          SizedBox(height: screenHeight * 0.012),
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
              Positioned(

                top: screenHeight * 0.25,
                left: 0,
                child:BackStackContainer()
              ),
            ],
          ),
        ),
      ),
    );
  }
}
