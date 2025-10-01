
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:scorer/components/adminside/admin_team_progress.dart';
import 'package:scorer/components/complete_session_row.dart';
import 'package:scorer/components/phases_strategy_column.dart';
import 'package:scorer/components/playerside/leader_stack_container.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/components/scenerio_container.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/controllers/game_select_controller.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/custom_stratgy_container.dart';
import 'package:scorer/widgets/filter_useable_container.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/pause_container.dart';
import 'package:scorer/widgets/useable_container.dart';

class GameStart1Screen extends StatelessWidget {
  final GameSelectController controller = Get.put(GameSelectController());
  GameStart1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;

    // A more direct way to get scaling factors
    final double baseHeight = 812.0;
    final double baseWidth = 414.0;
    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.07,
                        vertical: screenHeight * 0.02,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Column(
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
                      ),   SizedBox(height: 17*heightScaleFactor,),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 13 * widthScaleFactor,
                          ),
                          child: Container(
                            height: 390 * heightScaleFactor,
                            width: 376 * widthScaleFactor,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.greyColor,
                                width: 1.5,
                              ),
                              borderRadius:
                                  BorderRadius.circular(24 * widthScaleFactor),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 17 * heightScaleFactor,
                                right: 21 * widthScaleFactor,
                                left: 20 * widthScaleFactor,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                        BoldText(
  text: "current_phase".tr,
  fontSize: 16 * heightScaleFactor,
  selectionColor: AppColors.blueColor,
),
                                          SizedBox(height: 5 * heightScaleFactor),
                                          Row(
                                            children: [
                                              UseableContainer(
                                                width: 70,
                                                height: 25,
                                                
                                                text: "Phase 2",
                                                color: AppColors.orangeColor,
                                                fontSize:
                                                    10 * heightScaleFactor,
                                              ),
                                              SizedBox(
                                                  width: 10 * widthScaleFactor),
                                              MainText(
                                               text: "strategy_building".tr,
  // fontSize:(Get.locale?.languageCode == 'fr' || Get.locale?.languageCode == 'es')? 11 : 14 
                                          fontSize: ResponsiveFont.getFontSizeCustom(
defaultSize: 14*widthScaleFactor,
smallSize: 11*widthScaleFactor

                                          ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      CircularPercentIndicator(
                                        radius: 40.0 * widthScaleFactor,
                                        lineWidth: 4.0 * widthScaleFactor,
                                        percent: 0.7,
                                        animation: true,
                                        animationDuration: 500,
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        backgroundColor: Colors.transparent,
                                        progressColor: AppColors.forwardColor,
                                        center: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            BoldText(
                                                text: "12:32",
                                                fontSize: screenWidth * 0.04,
                                                selectionColor:
                                                    AppColors.blueColor),
                                            MainText(
                                                text: "remaining".tr,
                                                fontSize: screenWidth * 0.02,
                                                height: 1),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20 * heightScaleFactor),
                                 MainText(
  text: "team_collab_phase".tr,
  fontSize: 14 * heightScaleFactor,
),
                                  SizedBox(height: 15 * heightScaleFactor),
                                  // Obx(
                                  //   () => Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.center,
                                  //     children: [
                                  //       _buildPhaseCircle(
                                  //         isCompleted: true,
                                  //         phaseNumber: 1,
                                  //         widthScaleFactor: widthScaleFactor,
                                  //       ),
                                  //       _buildPhaseLine(
                                  //         isCompleted: true,
                                  //         widthScaleFactor: widthScaleFactor,
                                  //       ),
                                  //       _buildPhaseCircle(
                                  //         isCompleted:
                                  //             controller.currentPhase.value >= 1,
                                  //         phaseNumber: 2,
                                  //         widthScaleFactor: widthScaleFactor,
                                  //       ),
                                  //       _buildPhaseLine(
                                  //         isCompleted:
                                  //             controller.currentPhase.value >= 2,
                                  //         widthScaleFactor: widthScaleFactor,
                                  //       ),
                                  //       _buildPhaseCircle(
                                  //         isCompleted:
                                  //             controller.currentPhase.value >= 2,
                                  //         phaseNumber: 3,
                                  //         widthScaleFactor: widthScaleFactor,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
          //                         Obx(() => Row(
          //   children: [
          //     // First circle
          //     Container(
          // height: 20,
          // width: 20,
          // decoration: BoxDecoration(
          //   shape: BoxShape.circle,
          //   color: AppColors.forwardColor,
          // ),
          // child: Center(
          //   child: Icon(Icons.check, size: 17, color: AppColors.whiteColor),
          // ),
          //     ),
          //     SizedBox(width: 7),
          //     Container(
          // width: 100,
          // height: 4,
          // decoration: BoxDecoration(
          //   color: AppColors.forwardColor,
          //   borderRadius: BorderRadius.circular(20),
          // ),
          //     ),
          //     SizedBox(width: 7),
          
          //     // Second circle
          //     controller.currentPhase.value >= 1  
          //   ? Container(
          //       height: 20,
          //       width: 20,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: AppColors.forwardColor,
          //       ),
          //       child: Center(
          //         child: Icon(Icons.check, size: 17, color: AppColors.whiteColor),
          //       ),
          //     )
          //   : Container(
          //       height: 20,
          //       width: 20,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: AppColors.orangeColor,
          //       ),
          //       child: Center(
          //         child: MainText(text: "2", color: AppColors.whiteColor, fontSize: 11),
          //       ),
          //     ),
          //     SizedBox(width: 7),
          //     Container(
          // width: 100,
          // height: 4,
          // decoration: BoxDecoration(
          //   color: controller.currentPhase.value >= 2 ? AppColors.forwardColor : AppColors.greyColor,
          //   borderRadius: BorderRadius.circular(20),
          // ),
          //     ),
          //     SizedBox(width: 7),
          
          //     // Third circle
          //     controller.currentPhase.value >= 2
          //   ? Container(
          //       height: 20,
          //       width: 20,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: AppColors.forwardColor,
          //       ),
          //       child: Center(
          //         child: Icon(Icons.check, size: 17, color: AppColors.whiteColor),
          //       ),
          //     )
          //   : Container(
          //       height: 20,
          //       width: 20,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: AppColors.greyColor,
          //       ),
          //       child: Center(
          //         child: MainText(text: "3", color: AppColors.whiteColor, fontSize: 11),
          //       ),
          //     ),
          //   ],
          // )),
          Obx(() {
  final screenWidth = MediaQuery.of(context).size.width;
  final double baseWidth = 414.0;
  final double widthScaleFactor = screenWidth / baseWidth;

  return CompleteSessionRow(widthScaleFactor: widthScaleFactor, controller: controller);
}),
          
                                  SizedBox(height: 16 * heightScaleFactor),
                                  Obx(() => CustomStratgyContainer(
                                        flex1: controller.isCompleted.value ? 0 : 1,
                                        flex: controller.isCompleted.value ? 4 : 3,
                                        borderColor: controller.isCompleted.value
                                            ? AppColors.forwardColor
                                            : AppColors.selectLangugaeColor,
                                        iconContainer: controller.isCompleted.value
                                            ? AppColors.forwardColor
                                            : AppColors.selectLangugaeColor,
                                        icon: Icons.play_arrow_sharp,
                                        text1: "Stage 2",
                                        text2: controller.isCompleted.value
                                            ? "Active • 30 min"
                                            : "Time Left 30 min",
                                        text3: "active".tr,
                                        smallContainer: controller.isCompleted.value
                                            ? AppColors.forwardColor
                                            : AppColors.selectLangugaeColor,
                                        largeConatiner: controller.isCompleted.value
                                            ? AppColors.forwardColor
                                            : AppColors.selectLangugaeColor,
                                      )),
                                  SizedBox(height: 20 * heightScaleFactor),
                                  Obx(() {
                                    bool showBack = controller.clickCount.value >= 2;
                                    return Center(
                                      child: showBack
                                          ? PauseContainer(
                                            width: double.infinity,
                                            // width: 335*widthScaleFactor,
                                              onTap: () => controller.back(),
                                              text: "back".tr,
                                              color: AppColors.selectLangugaeColor,
                                              height: 35 * heightScaleFactor,
                                              // width: double.infinity,
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: PauseContainer(
                                                    onTap: () => controller.pause(),
                                                    text: "pause".tr,
                                                    color: AppColors.selectLangugaeColor,
                                                    height: 35 * heightScaleFactor,
                                                    // width: 140 * widthScaleFactor,
                                                  ),
                                                ),
                                                SizedBox(width: 20 * widthScaleFactor),
                                                Expanded(
                                                  child: PauseContainer(
                                                    onTap: () => controller.nextPhase(),
                                                    text: "next_phase".tr,
                                                    icon: Icons.fast_forward,
                                                    color: controller.isCompleted.value
                                                        ? AppColors.forwardColor
                                                        : AppColors.assignColor,
                                                    height: 35 * heightScaleFactor,
                                                    // width: 140 * widthScaleFactor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                    );
                                  })
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 17,),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30 * widthScaleFactor,
                      ),
                      child: Column(
                        children: [
                          ScenerioContainer(heightScaleFactor: heightScaleFactor, widthScaleFactor: widthScaleFactor),
                          SizedBox(height: 20 * heightScaleFactor),
                          Obx(() {
                            return FilterUseableContainer(
                              isSelected: controller.gamevalue.value == 0,
                          fontSze: ResponsiveFont.getFontSizeCustom(
                                  defaultSize: 13*widthScaleFactor,
                                  smallSize: 10*widthScaleFactor
                                ),
                              text: "mountain_resort".tr,
                              onTap: () {
                                controller.gameSelect(0);
                              },
                            );
                          }),
                          SizedBox(height: 10 * heightScaleFactor),
                          Obx(() => FilterUseableContainer(
                                isSelected: controller.gamevalue.value == 1,
                               fontSze: ResponsiveFont.getFontSizeCustom(
                                  defaultSize: 13*widthScaleFactor,
                                  smallSize: 10*widthScaleFactor
                                ),
                                text: "beach_hotel".tr,
                                onTap: () {
                                  controller.gameSelect(1);
                                },
                              )),
                          SizedBox(height: 10 * heightScaleFactor),
                          Obx(() => FilterUseableContainer(
                                isSelected: controller.gamevalue.value == 2,
                                // fontSze: 13 * heightScaleFactor,
                                fontSze: ResponsiveFont.getFontSizeCustom(
                                  defaultSize: 13*widthScaleFactor,
                                  smallSize: 10*widthScaleFactor
                                ),
                                
                                text: "city_conference_center".tr,
                                onTap: () {
                                  controller.gameSelect(2);
                                },
                              )),
                          SizedBox(height: 10 * heightScaleFactor),
                          Container(
                            width: double.infinity,
                            height: 202 * heightScaleFactor,
                            padding: EdgeInsets.all(12 * widthScaleFactor),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.greyColor,
                                width: 1.5,
                              ),
                              borderRadius:
                                  BorderRadius.circular(24 * widthScaleFactor),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10,),
                                BoldText(
                                  text:  "explain_reasoning".tr,
                                  fontSize: 16 * heightScaleFactor,
                                  selectionColor: AppColors.blueColor,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    cursorColor: AppColors.blackColor,
                                    maxLines: null,
                                    expands: true,
                                    textAlignVertical: TextAlignVertical.top,
                                    decoration: InputDecoration(
                                      hintText:
                                          "share_thought_process".tr,
                                      hintStyle:
                                          TextStyle(color: AppColors.teamColor),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 13 * widthScaleFactor,
                      ),
                      child: AdminTeamProgress(
                        contentWidth: screenWidth * 0.9,
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        verticalSpacing: screenHeight * 0.02,
                      ),
                    ),
                    SizedBox(height: 17,),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30 * widthScaleFactor,
                      ),
                      child: Obx(
                        () => Column(
                          children: [
                         PhaseStrategyColumn(widthScaleFactor: widthScaleFactor, heightScaleFactor: heightScaleFactor, controller: controller),
                            SizedBox(height: 43 * heightScaleFactor),
                            if (controller.currentPhase.value >= 2)
                              LoginButton(
                                fontSize: 20,
                                text: "previous".tr,
                                color: AppColors.redColor,
                              )
                            else
                              SizedBox(),
                            SizedBox(height: controller.currentPhase.value >= 2 ? 12 * heightScaleFactor : 0),
                            Obx(() => LoginButton(
                              onTap: ()=>Get.toNamed(RouteName.submitResponseScreen),
                                  ishow: true,
                                  fontSize: 20,
                                  image: Appimages.submit,
                                  text: "submit_response".tr,
                                  color: controller.currentPhase.value >= 1
                                      ? AppColors.forwardColor
                                      : AppColors.assignColor,
                                )),
                            SizedBox(height: 43 * heightScaleFactor),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                right: 0,
                top: screenHeight * 0.35,
                child: LeaderStackContainer(),
              ),
            ],
          ),
        ),
      ),
    );
  }

 

 
}
