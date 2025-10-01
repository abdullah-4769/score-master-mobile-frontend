

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/abcd_container.dart';
import 'package:scorer/components/device_connect_note.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/players_container.dart';
// import 'package:scorer/widgets/gradient_background.dart';


class PlayerDashboardScreen2 extends StatelessWidget {
  const PlayerDashboardScreen2({super.key});

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
                            text: "team_alpha".tr,
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
                SizedBox(height: 10* heightScaleFactor,),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32 * widthScaleFactor,
                  ),
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SizedBox(
                             height: 170 * heightScaleFactor,
                              // width: 209 * widthScaleFactor,
                            child: Image.asset(
                              Appimages.group,
                             fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            bottom: -2* heightScaleFactor,
                            right: 15 * widthScaleFactor,
                            child: CreateContainer(fontsize2: 12,
                              text: "5 Phases",
                              width: 90 * widthScaleFactor,
                              height: 30 * heightScaleFactor, // Assuming a default height
                              // fontSize: 14 * widthScaleFactor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20*heightScaleFactor,),
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
                            text: "Facilitator: Sarah Johnson",
                            fontSize: 14 * widthScaleFactor,
                          )
                        ],
                      ),
                      SizedBox(height: 30 * heightScaleFactor),
                      ABCDContainer(widthScaleFactor: widthScaleFactor, heightScaleFactor: heightScaleFactor),
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

                      PlayersContainers(
                        color: AppColors.forwardColor,
                        text3: "joined".tr,
                        text1: "1",
                        text2: "You",
                        image: Appimages.play1,
                        // scaleFactor: widthScaleFactor,
                      ),
                      SizedBox(height: 15 * heightScaleFactor),
                      PlayersContainers(
                        color: AppColors.forwardColor,
                        text3: "joined".tr,
                        text1: "2",
                        text2: "Sarah J.",
                        image: Appimages.play2,
                        // scaleFactor: widthScaleFactor,
                      ),
                      SizedBox(height: 15 * heightScaleFactor),
                      PlayersContainers(
                        color: AppColors.forwardColor,
                        text3:"joined".tr,
                        text1: "3",
                        text2: "Mike C.",
                        image: Appimages.play3,
                        // scaleFactor: widthScaleFactor,
                      ),
                      SizedBox(height: 15 * heightScaleFactor),
                      PlayersContainers(
                        color: AppColors.forwardColor,
                        text3: "joined".tr,
                        text1: "4",
                        text2: "David B.",
                        image: Appimages.play4,
                        // scaleFactor: widthScaleFactor,
                      ),
                      SizedBox(height: 15 * heightScaleFactor),
                      PlayersContainers(
                        color: AppColors.forwardColor,
                        text3: "joined".tr,
                        text1: "5",
                        text2: "Lisa G.",
                        image: Appimages.play5,
                        // scaleFactor: widthScaleFactor,
                      ),
                      SizedBox(height: 15 * heightScaleFactor),
                      DeviceConnectNote(widthScaleFactor: widthScaleFactor, heightScaleFactor: heightScaleFactor),
                      SizedBox(height: 15 * heightScaleFactor),
                      LoginButton(
                        onTap: ()=>Get.toNamed(RouteName.gameStart1Screen),
                        text:"leave_session".tr,
                        ishow: true,
                        image: Appimages.leave,
                        color: AppColors.redColor,
                        height: 50 * heightScaleFactor, // Assuming a default height for this button
                        fontSize: 16 * widthScaleFactor,
                      ),
                      SizedBox(height: 60 * heightScaleFactor)
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
