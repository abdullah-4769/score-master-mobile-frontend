import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:scorer/components/adminside/admin_team_progress.dart';
import 'package:scorer/components/complete_session_row.dart' hide BoldText;
import 'package:scorer/components/phases_strategy_column.dart';
import 'package:scorer/components/playerside/leader_stack_container.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/controllers/game_select_controller.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/pause_container.dart';
import 'package:scorer/widgets/useable_container.dart';
import 'package:scorer/api/api_controllers/question_for_sessions_controller.dart';
import 'package:scorer/shared_preferences/shared_preferences.dart';
import 'package:scorer/widgets/globalwidget/phase_question_type.dart';
import '../../api/api_controllers/player_q_submit_controller.dart';
import '../../api/api_controllers/team_view_controller.dart';

class GameStart1Screen extends StatelessWidget {
  final submitController = Get.put(PlayerQSubmitController());
  final questionController = Get.put(QuestionForSessionsController());
  final TeamViewController teamController = Get.put(TeamViewController());
  late final GameSelectController controller;

  GameStart1Screen({super.key}) {
    controller = Get.put(GameSelectController(questionController: questionController));
  }

  void _initializeData() {
    if (!teamController.isLoading.value && teamController.teamView.value == null) {
      teamController.loadTeams();
    }
    if (!questionController.isLoading.value && questionController.questionData.value == null) {
      questionController.loadQuestions(sessionId: 1, gameFormatId: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => _initializeData());

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double baseHeight = 812.0;
    final double baseWidth = 414.0;
    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;

    return Scaffold(
      body: SafeArea(
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
                        Image.asset(Appimages.player2,
                            height: 63 * heightScaleFactor,
                            width: 50 * widthScaleFactor),
                        Expanded(
                          child: Center(
                            child: FutureBuilder<String?>(
                              future: SharedPrefServices.getUserName(),
                              builder: (context, snapshot) {
                                return BoldText(
                                  text: snapshot.data ?? "Player Name",
                                  fontSize: 22 * widthScaleFactor,
                                );
                              },
                            ),
                          ),
                        ),
                        Image.asset(Appimages.house1,
                            height: 63 * heightScaleFactor,
                            width: 80 * widthScaleFactor),
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
                            child: Image.asset(Appimages.group, fit: BoxFit.contain),
                          ),
                          Positioned(
                            bottom: -2 * heightScaleFactor,
                            right: 15 * widthScaleFactor,
                            child: Obx(() => CreateContainer(
                              fontsize2: 12,
                              text:
                              "${questionController.questionData.value?.phases.length ?? 0} Phases",
                              width: 90 * widthScaleFactor,
                              height: 30 * heightScaleFactor,
                            )),
                          ),
                        ],
                      ),
                      SizedBox(height: 20 * heightScaleFactor),
                      Obx(() => BoldText(
                        text: teamController.teamView.value?.gameFormat.name ?? "Session Name",
                        fontSize: 16 * heightScaleFactor,
                        selectionColor: AppColors.blueColor,
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Appimages.person,
                              height: 18 * heightScaleFactor,
                              width: 18 * widthScaleFactor),
                          SizedBox(width: 8 * widthScaleFactor),
                          Obx(() => MainText(
                            text:
                            "Facilitator: ${teamController.teamView.value?.gameFormat.facilitators.isNotEmpty == true ? teamController.teamView.value!.gameFormat.facilitators[0].name : 'Unknown'}",
                            fontSize: 14 * widthScaleFactor,
                          )),
                        ],
                      ),
                      SizedBox(height: 17 * heightScaleFactor),

                      // Current Phase Container
                      Obx(() {
                        if (questionController.isLoading.value || teamController.isLoading.value) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (questionController.errorMessage.value.isNotEmpty) {
                          return Center(child: Text(questionController.errorMessage.value));
                        }

                        final phase = controller.getCurrentPhase();
                        final currentQuestion = controller.getCurrentQuestion();
                        final challengeTypes = controller.getCurrentChallengeTypes();

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 13 * widthScaleFactor),
                          child: Container(
                            width: 376 * widthScaleFactor,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.greyColor, width: 1.5),
                              borderRadius: BorderRadius.circular(24 * widthScaleFactor),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 17 * heightScaleFactor,
                                right: 21 * widthScaleFactor,
                                left: 20 * widthScaleFactor,
                                bottom: 17 * heightScaleFactor,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                                text: phase != null
                                                    ? "Phase ${controller.currentPhase.value + 1}"
                                                    : "Phase 1",
                                                color: AppColors.orangeColor,
                                                fontSize: 10 * heightScaleFactor,
                                              ),
                                              SizedBox(width: 10 * widthScaleFactor),
                                              MainText(
                                                text: phase?.name.tr ?? "strategy_building".tr,
                                                fontSize: ResponsiveFont.getFontSizeCustom(
                                                  defaultSize: 14 * widthScaleFactor,
                                                  smallSize: 11 * widthScaleFactor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Obx(() => CircularPercentIndicator(
                                        radius: 40.0 * widthScaleFactor,
                                        lineWidth: 4.0 * widthScaleFactor,
                                        percent: controller.timeProgress.value,
                                        animation: true,
                                        animationDuration: 500,
                                        circularStrokeCap: CircularStrokeCap.round,
                                        backgroundColor: Colors.transparent,
                                        progressColor: AppColors.forwardColor,
                                        center: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            BoldText(
                                              text: controller.remainingTime.value,
                                              fontSize: screenWidth * 0.04,
                                              selectionColor: AppColors.blueColor,
                                            ),
                                            MainText(
                                              text: "remaining".tr,
                                              fontSize: screenWidth * 0.02,
                                              height: 1,
                                            ),
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                  SizedBox(height: 15 * heightScaleFactor),

                                  // Challenge Types
                                  if (challengeTypes.isNotEmpty)
                                    Column(
                                      children: [
                                        MainText(
                                          text: "Challenge Types: ${challengeTypes.join(", ")}",
                                          fontSize: 14 * heightScaleFactor,
                                        ),
                                        SizedBox(height: 15 * heightScaleFactor),
                                      ],
                                    ),

                                  // Phase Description
                                  if (phase?.description != null && phase!.description.isNotEmpty)
                                    Column(
                                      children: [
                                        MainText(
                                          text: phase.description,
                                          fontSize: 12 * heightScaleFactor,
                                        ),
                                        SizedBox(height: 15 * heightScaleFactor),
                                      ],
                                    ),

                                  // Current Question Progress
                                  if (currentQuestion != null)
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            MainText(
                                              text: "Question ${controller.currentQuestionIndex.value + 1} of ${controller.getCurrentPhaseQuestions().length}",
                                              fontSize: 12 * heightScaleFactor,
                                              color: AppColors.blueColor,
                                            ),
                                            MainText(
                                              text: "${currentQuestion.point} points",
                                              fontSize: 12 * heightScaleFactor,
                                              color: AppColors.teamColor,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10 * heightScaleFactor),

                                        // Question Type Indicator
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12 * widthScaleFactor,
                                            vertical: 6 * heightScaleFactor,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _getQuestionTypeColor(currentQuestion.type).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8 * widthScaleFactor),
                                          ),
                                          child: MainText(
                                            text: "Type: ${currentQuestion.type.toUpperCase()}",
                                            fontSize: 12 * heightScaleFactor,
                                            color: _getQuestionTypeColor(currentQuestion.type),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),

                      SizedBox(height: 20 * heightScaleFactor),

                      // Current Question
                      Obx(() {
                        if (questionController.isLoading.value) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        final currentQuestion = controller.getCurrentQuestion();
                        if (currentQuestion == null) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30 * widthScaleFactor),
                            child: Container(
                              padding: EdgeInsets.all(20 * widthScaleFactor),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.greyColor),
                                borderRadius: BorderRadius.circular(16 * widthScaleFactor),
                              ),
                              child: Center(
                                child: MainText(
                                  text: controller.isCurrentPhaseComplete()
                                      ? "Phase Completed! 🎉"
                                      : "No questions available",
                                  fontSize: 16 * heightScaleFactor,
                                  color: AppColors.teamColor,
                                ),
                              ),
                            ),
                          );
                        }

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30 * widthScaleFactor),
                          child: PhaseQuestionsContainer(
                            heightScaleFactor: heightScaleFactor,
                            widthScaleFactor: widthScaleFactor,
                            question: currentQuestion,
                            controller: controller,
                          ),
                        );
                      }),

                      SizedBox(height: 20 * heightScaleFactor),

                      // Submit Question Button
                      Obx(() {
                        final currentQuestion = controller.getCurrentQuestion();
                        if (currentQuestion == null) return const SizedBox.shrink();

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30 * widthScaleFactor),
                          child: LoginButton(
                            onTap: controller.canSubmitQuestion() ? () async {
                              await controller.submitCurrentQuestion();
                            } : null,
                            ishow: true,
                            fontSize: 16,
                            image: Appimages.submit,
                            text: "submit_question".tr,
                            color: controller.canSubmitQuestion()
                                ? AppColors.forwardColor
                                : AppColors.greyColor,
                          ),
                        );
                      }),

                      SizedBox(height: 20 * heightScaleFactor),

                      // Team Progress
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13 * widthScaleFactor),
                        child: AdminTeamProgress(
                          contentWidth: screenWidth * 0.9,
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          verticalSpacing: screenHeight * 0.02,
                        ),
                      ),

                      SizedBox(height: 17 * heightScaleFactor),

                      // Phase Strategy Column
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30 * widthScaleFactor),
                        child: Column(
                          children: [
                            PhaseStrategyColumn(
                              widthScaleFactor: widthScaleFactor,
                              heightScaleFactor: heightScaleFactor,
                              controller: controller,
                              questionController: questionController,
                            ),
                            SizedBox(height: 20 * heightScaleFactor),

                            // Next Phase Button (only show when current phase is complete)
                            Obx(() {
                              final isPhaseComplete = controller.isCurrentPhaseComplete();
                              final isLastPhase = controller.isLastPhase();

                              if (isPhaseComplete && !isLastPhase) {
                                return LoginButton(
                                  onTap: () {
                                    controller.moveToNextPhase();
                                  },
                                  ishow: true,
                                  fontSize: 18,
                                  image: Appimages.forward,
                                  text: "next_phase".tr,
                                  color: AppColors.forwardColor,
                                );
                              }
                              return const SizedBox.shrink();
                            }),

                            SizedBox(height: 43 * heightScaleFactor),
                          ],
                        ),
                      ),
                    ],
                  ),
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
    );
  }

  Color _getQuestionTypeColor(String type) {
    switch (type.toUpperCase()) {
      case 'MCQ':
        return AppColors.blueColor;
      case 'PUZZLE':
        return AppColors.orangeColor;
      case 'OPENENDED':
      case 'OPEN_ENDED':
        return AppColors.forwardColor;
      case 'SIMULATION':
        return AppColors.redColor;
      default:
        return AppColors.greyColor;
    }
  }
}







