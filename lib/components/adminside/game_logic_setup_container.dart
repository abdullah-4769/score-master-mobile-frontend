// game_logic_setup_container.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/appcolors.dart';
import '../../api/api_controllers/create_game_controller.dart';
import '../../api/api_controllers/question_controller.dart';
import '../../widgets/admin_side_widgets/phase_item_widget.dart';
import '../../widgets/admin_side_widgets/question_type_selection_dialogue.dart';

class GameLogicSetupContainer extends StatefulWidget {
  final double scaleFactor;

  const GameLogicSetupContainer({Key? key, required this.scaleFactor}) : super(key: key);

  @override
  State<GameLogicSetupContainer> createState() => _GameLogicSetupContainerState();
}

class _GameLogicSetupContainerState extends State<GameLogicSetupContainer> {
  @override
  void initState() {
    super.initState();
    // Initialize QuestionController if not registered
    if (!Get.isRegistered<QuestionController>()) {
      Get.put(QuestionController());
    }

    // Load phases if game ID exists
    final createGameController = Get.find<CreateGameController>();
    if (createGameController.currentGameId.value != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        createGameController.loadExistingGame(createGameController.currentGameId.value!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final createGameController = Get.find<CreateGameController>();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20 * widget.scaleFactor),
      decoration: BoxDecoration(
        color: AppColors.forwardColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24 * widget.scaleFactor),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(createGameController),
          SizedBox(height: 20 * widget.scaleFactor),
          Obx(() => _buildPhasesList(createGameController, context)),
        ],
      ),
    );
  }

  Widget _buildHeader(CreateGameController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "game_logic_setup".tr,
                style: TextStyle(
                  fontSize: 18 * widget.scaleFactor,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blueColor,
                ),
              ),
              Obx(() {
                if (controller.currentGameId.value != null) {
                  return Padding(
                    padding: EdgeInsets.only(top: 4 * widget.scaleFactor),
                    child: Text(
                      "Game ID: ${controller.currentGameId.value}",
                      style: TextStyle(
                        fontSize: 12 * widget.scaleFactor,
                        color: AppColors.teamColor,
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              }),
            ],
          ),
        ),
        Obx(() => GestureDetector(
          onTap: controller.isFetchingPhases.value || controller.currentGameId.value == null
              ? null
              : () => controller.loadExistingGame(controller.currentGameId.value!),
          child: Container(
            padding: EdgeInsets.all(8 * widget.scaleFactor),
            decoration: BoxDecoration(
              color: controller.currentGameId.value == null
                  ? AppColors.greyColor.withOpacity(0.1)
                  : AppColors.forwardColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8 * widget.scaleFactor),
            ),
            child: controller.isFetchingPhases.value
                ? SizedBox(
              width: 16 * widget.scaleFactor,
              height: 16 * widget.scaleFactor,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.blueColor,
              ),
            )
                : Icon(
              Icons.refresh,
              color: controller.currentGameId.value == null
                  ? AppColors.greyColor
                  : AppColors.blueColor,
              size: 18 * widget.scaleFactor,
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildPhasesList(CreateGameController controller, BuildContext context) {
    // Show loading only on initial load
    if (controller.isFetchingPhases.value && controller.phases.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(30 * widget.scaleFactor),
          child: Column(
            children: [
              CircularProgressIndicator(color: AppColors.blueColor),
              SizedBox(height: 15 * widget.scaleFactor),
              Text(
                "Loading phases...",
                style: TextStyle(
                  fontSize: 14 * widget.scaleFactor,
                  color: AppColors.languageTextColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Show empty state
    if (controller.phases.isEmpty) {
      return _buildEmptyPhasesWidget(controller);
    }

    // Show phases list
    return Column(
      children: controller.phases.asMap().entries.map((entry) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12 * widget.scaleFactor),
          child: PhaseItem(
            phase: entry.value,
            index: entry.key,
            scaleFactor: widget.scaleFactor,
            onAddQuestion: () => showQuestionTypeSelectionDialog(
              context,
              entry.value,
              scaleFactor: widget.scaleFactor,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEmptyPhasesWidget(CreateGameController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24 * widget.scaleFactor),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * widget.scaleFactor),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          Icon(
            Icons.layers_outlined,
            size: 48 * widget.scaleFactor,
            color: AppColors.greyColor,
          ),
          SizedBox(height: 12 * widget.scaleFactor),
          Text(
            controller.currentGameId.value == null
                ? "No game created yet"
                : "No phases added yet",
            style: TextStyle(
              fontSize: 16 * widget.scaleFactor,
              fontWeight: FontWeight.w600,
              color: AppColors.languageTextColor,
            ),
          ),
          SizedBox(height: 6 * widget.scaleFactor),
          Text(
            controller.currentGameId.value != null
                ? "Add phases using the 'Add Phase' button above"
                : "Create a game first, then add phases",
            style: TextStyle(
              fontSize: 12 * widget.scaleFactor,
              color: AppColors.teamColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}








// // game_logic_setup_container.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../constants/appcolors.dart';
// import '../../api/api_controllers/ai_question_controller.dart';
// import '../../api/api_controllers/create_game_controller.dart';
// import '../../api/api_controllers/question_controller.dart';
// import '../../widgets/admin_side_widgets/phase_item_widget.dart';
// import '../../widgets/admin_side_widgets/question_type_selection_dialogue.dart';
//
//
// class GameLogicSetupContainer extends StatelessWidget {
//   final double scaleFactor;
//
//   const GameLogicSetupContainer({Key? key, required this.scaleFactor}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final createGameController = Get.find<CreateGameController>();
//
//     // Initialize controllers
//     if (!Get.isRegistered<QuestionController>()) {
//       Get.put(QuestionController());
//     }
//     if (!Get.isRegistered<AIQuestionController>()) {
//       Get.put(AIQuestionController());
//     }
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20 * scaleFactor),
//       decoration: BoxDecoration(
//         color: AppColors.forwardColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(24 * scaleFactor),
//         border: Border.all(color: AppColors.borderColor),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildHeader(createGameController),
//           SizedBox(height: 20 * scaleFactor),
//           Obx(() => _buildPhasesList(createGameController, context)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHeader(CreateGameController controller) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           "game_logic_setup".tr,
//           style: TextStyle(
//             fontSize: 18 * scaleFactor,
//             fontWeight: FontWeight.bold,
//             color: AppColors.blueColor,
//           ),
//         ),
//         Obx(() => GestureDetector(
//           onTap: controller.isFetchingPhases.value ? null : controller.refreshPhases,
//           child: Container(
//             padding: EdgeInsets.all(8 * scaleFactor),
//             decoration: BoxDecoration(
//               color: AppColors.forwardColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8 * scaleFactor),
//             ),
//             child: controller.isFetchingPhases.value
//                 ? SizedBox(
//               width: 16 * scaleFactor,
//               height: 16 * scaleFactor,
//               child: CircularProgressIndicator(
//                 strokeWidth: 2,
//                 color: AppColors.blueColor,
//               ),
//             )
//                 : Icon(
//               Icons.refresh,
//               color: AppColors.blueColor,
//               size: 18 * scaleFactor,
//             ),
//           ),
//         )),
//       ],
//     );
//   }
//
//   Widget _buildPhasesList(CreateGameController controller, BuildContext context) {
//     if (controller.isFetchingPhases.value && controller.phases.isEmpty) {
//       return Center(
//         child: Padding(
//           padding: EdgeInsets.all(30 * scaleFactor),
//           child: Column(
//             children: [
//               CircularProgressIndicator(color: AppColors.blueColor),
//               SizedBox(height: 15 * scaleFactor),
//               Text(
//                 "Loading phases...",
//                 style: TextStyle(
//                   fontSize: 14 * scaleFactor,
//                   color: AppColors.languageTextColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//     if (controller.phases.isEmpty) {
//       return _buildEmptyPhasesWidget(controller);
//     }
//
//     return Column(
//       children: controller.phases.asMap().entries.map((entry) {
//         return PhaseItem(
//           phase: entry.value,
//           index: entry.key,
//           scaleFactor: scaleFactor,
//           onAddQuestion: () => showQuestionTypeSelectionDialog(context, entry.value, scaleFactor: scaleFactor),
//         );
//       }).toList(),
//     );
//   }
//
//   Widget _buildEmptyPhasesWidget(CreateGameController controller) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(24 * scaleFactor),
//       decoration: BoxDecoration(
//         color: AppColors.forwardColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(16 * scaleFactor),
//         border: Border.all(color: AppColors.borderColor),
//       ),
//       child: Column(
//         children: [
//           Icon(
//             Icons.layers_outlined,
//             size: 48 * scaleFactor,
//             color: AppColors.greyColor,
//           ),
//           SizedBox(height: 12 * scaleFactor),
//           Text(
//             "No phases added yet",
//             style: TextStyle(
//               fontSize: 16 * scaleFactor,
//               fontWeight: FontWeight.w600,
//               color: AppColors.languageTextColor,
//             ),
//           ),
//           SizedBox(height: 6 * scaleFactor),
//           Text(
//             controller.currentGameId.value != null
//                 ? "Game ID: ${controller.currentGameId.value}"
//                 : "Create a game first, then add phases",
//             style: TextStyle(
//               fontSize: 12 * scaleFactor,
//               color: AppColors.teamColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }