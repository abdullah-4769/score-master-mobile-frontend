import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/api_models/ai_questions_model.dart';
import '../../api/api_models/questions_model.dart';
import '../../constants/appcolors.dart';
import '../../api/api_controllers/question_controller.dart';
import '../../widgets/bold_text.dart';
import '../../widgets/main_text.dart';
import '../../widgets/login_textfield.dart';
import '../../widgets/login_button.dart';

class AIQuestionDialog extends StatelessWidget {
  final dynamic phase;
  final double scaleFactor;

  const AIQuestionDialog({
    Key? key,
    required this.phase,
    required this.scaleFactor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topicController = TextEditingController();
    final questionController = Get.find<QuestionController>();

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: 20 * scaleFactor,
        vertical: 24 * scaleFactor,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20 * scaleFactor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(scaleFactor),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24 * scaleFactor),
                child: questionController.isGeneratingAI.value
                    ? _buildLoadingState(scaleFactor)
                    : questionController.aiGeneratedQuestion.value != null
                    ? _buildGeneratedQuestionPreview(
                  questionController.aiGeneratedQuestion.value!,
                  questionController,
                  phase.id,
                  context,
                  scaleFactor,
                )
                    : _buildInputForm(
                  topicController,
                  phase.challengeTypes,
                  questionController,
                  context,
                  scaleFactor,
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget _buildHeader(double sf) {
    return Container(
      padding: EdgeInsets.all(20 * sf),
      decoration: BoxDecoration(
        color: AppColors.blueColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20 * sf),
          topRight: Radius.circular(20 * sf),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10 * sf),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10 * sf),
            ),
            child: Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 24 * sf,
            ),
          ),
          SizedBox(width: 12 * sf),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Question Generator',
                  style: TextStyle(
                    fontSize: 18 * sf,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4 * sf),
                Text(
                  'Phase: ${phase.name}',
                  style: TextStyle(
                    fontSize: 12 * sf,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Get.find<QuestionController>().clearAIGeneratedQuestion();
              Get.back();
            },
            icon: Icon(Icons.close, color: Colors.white, size: 24 * sf),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(double sf) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(40 * sf),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80 * sf,
              height: 80 * sf,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blueColor.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.blueColor),
                  strokeWidth: 4,
                ),
              ),
            ),
            SizedBox(height: 30 * sf),
            BoldText(
              text: 'AI is generating your question...',
              fontSize: 16 * sf,
              selectionColor: AppColors.blackColor,
            ),
            SizedBox(height: 12 * sf),
            MainText(
              text: 'This may take a few seconds',
              fontSize: 13 * sf,
              color: AppColors.languageTextColor,
            ),
            SizedBox(height: 30 * sf),
            Container(
              padding: EdgeInsets.all(16 * sf),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12 * sf),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.tips_and_updates,
                      color: AppColors.forwardColor,
                      size: 20 * sf),
                  SizedBox(width: 8 * sf),
                  Flexible(
                    child: MainText(
                      text: 'AI is crafting a contextual question based on your topic',
                      fontSize: 12 * sf,
                      color: AppColors.teamColor,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneratedQuestionPreview(
      AIQuestionResponse question,
      QuestionController controller,
      int phaseId,
      BuildContext context,
      double sf,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.preview, color: AppColors.blueColor, size: 20 * sf),
            SizedBox(width: 8 * sf),
            BoldText(
              text: 'Generated Question Preview',
              fontSize: 16 * sf,
              selectionColor: AppColors.blueColor,
            ),
          ],
        ),
        SizedBox(height: 16 * sf),

        // Question Preview Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16 * sf),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.greyColor, width: 1.5),
            borderRadius: BorderRadius.circular(16 * sf),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8 * sf,
                      vertical: 4 * sf,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.blueColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4 * sf),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.auto_awesome,
                            color: AppColors.blueColor,
                            size: 12 * sf),
                        SizedBox(width: 4 * sf),
                        MainText(
                          text: 'AI GENERATED',
                          fontSize: 10 * sf,
                          color: AppColors.blueColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8 * sf),
                  MainText(
                    text: '${question.point} points',
                    fontSize: 10 * sf,
                    color: AppColors.teamColor,
                  ),
                ],
              ),
              SizedBox(height: 12 * sf),

              if (question.scenario.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12 * sf),
                  decoration: BoxDecoration(
                    color: AppColors.forwardColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8 * sf),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.description,
                              color: AppColors.forwardColor,
                              size: 14 * sf),
                          SizedBox(width: 6 * sf),
                          BoldText(
                            text: 'Scenario',
                            fontSize: 12 * sf,
                            selectionColor: AppColors.forwardColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 6 * sf),
                      MainText(
                        text: question.scenario,
                        fontSize: 12 * sf,
                        color: AppColors.blackColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12 * sf),
              ],

              BoldText(
                text: question.questionText,
                selectionColor: AppColors.redColor,
                fontSize: 16 * sf,
              ),
            ],
          ),
        ),

        SizedBox(height: 20 * sf),

        // Action Buttons
        Row(
          children: [
            Expanded(
              child: LoginButton(
                text: 'Generate Another',
                fontSize: 14 * sf,
                color: AppColors.forwardColor,
                onTap: () => controller.clearAIGeneratedQuestion(),
              ),
            ),
            SizedBox(width: 12 * sf),
            Expanded(
              child: Obx(() => LoginButton(
                text: controller.isAdding.value ? 'Adding...' : 'Add to Phase',
                fontSize: 14 * sf,
                color: AppColors.blueColor,
                onTap: controller.isAdding.value
                    ? null
                    : () async {
                  final nextOrder = controller.getNextOrderForPhase(phaseId);
                  await controller.addAIGeneratedQuestion(
                    question,
                    phaseId,
                    nextOrder,
                  );
                  Get.back();
                },
              )),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInputForm(
      TextEditingController topicController,
      List<String> challengeTypes,
      QuestionController controller,
      BuildContext context,
      double sf,
      ) {
    final selectedType = RxString(
      challengeTypes.isNotEmpty ? challengeTypes.first : '',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Information Card
        Container(
          padding: EdgeInsets.all(16 * sf),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12 * sf),
            border: Border.all(color: AppColors.blueColor.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline,
                  color: AppColors.blueColor,
                  size: 20 * sf),
              SizedBox(width: 12 * sf),
              Expanded(
                child: MainText(
                  text: 'AI will generate a contextual question based on your topic and game phase',
                  fontSize: 12 * sf,
                  color: AppColors.languageTextColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20 * sf),

        // Topic Field
        BoldText(
          text: 'Topic',
          fontSize: 14 * sf,
          selectionColor: AppColors.blackColor,
        ),
        SizedBox(height: 8 * sf),
        LoginTextfield(
          text: 'e.g., Leadership in crisis situations',
          fontsize: 14 * sf,
          ishow: true,
          height: 100 * sf,
          controller: topicController,
        ),
        SizedBox(height: 16 * sf),

        // Question Type Dropdown
        BoldText(
          text: 'Question Type',
          fontSize: 14 * sf,
          selectionColor: AppColors.blackColor,
        ),
        SizedBox(height: 8 * sf),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 12 * sf,
            vertical: 4 * sf,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(12 * sf),
          ),
          child: DropdownButtonHideUnderline(
            child: Obx(() => DropdownButton<String>(
              value: selectedType.value.isEmpty ? null : selectedType.value,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: AppColors.blueColor),
              items: challengeTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Row(
                    children: [
                      Icon(
                        _getTypeIcon(type),
                        size: 18 * sf,
                        color: _getTypeColor(type),
                      ),
                      SizedBox(width: 8 * sf),
                      Text(
                        type,
                        style: TextStyle(fontSize: 14 * sf),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  selectedType.value = newValue;
                }
              },
            )),
          ),
        ),
        SizedBox(height: 24 * sf),

        // Generate Button
        Center(
          child: LoginButton(
            text: 'Generate Question',
            fontSize: 16 * sf,
            icon: Icons.auto_awesome,
            color: AppColors.blueColor,
            onTap: () {
              if (topicController.text.isEmpty) {
                Get.snackbar(
                  'Error',
                  'Please enter a topic',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }
              if (selectedType.value.isEmpty) {
                Get.snackbar(
                  'Error',
                  'Please select a question type',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }
              controller.generateAIQuestion(
                topic: topicController.text,
                type: selectedType.value,
                gameName: "Leadership Game",
                phaseName: phase.name,
              );
            },
          ),
        ),
      ],
    );
  }

  IconData _getTypeIcon(String type) {
    switch (type.toUpperCase()) {
      case 'PUZZLE':
        return Icons.extension;
      case 'MCQ':
        return Icons.radio_button_checked;
      case 'OPEN_ENDED':
        return Icons.text_fields;
      case 'SIMULATION':
        return Icons.play_circle;
      default:
        return Icons.help;
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toUpperCase()) {
      case 'MCQ':
        return AppColors.blueColor;
      case 'PUZZLE':
        return AppColors.orangeColor;
      case 'OPEN_ENDED':
        return AppColors.forwardColor;
      case 'SIMULATION':
        return AppColors.redColor;
      default:
        return AppColors.blueColor;
    }
  }
}













// // lib/widgets/admin_side_widgets/ai_question_dialog.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../api/api_models/ai_questions_model.dart';
// import '../../constants/appcolors.dart';
// import '../../api/api_controllers/question_controller.dart';
//
//
// class AIQuestionDialog extends StatelessWidget {
//   final dynamic phase;
//   final double scaleFactor;
//
//   const AIQuestionDialog({Key? key, required this.phase, required this.scaleFactor}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final topicController = TextEditingController();
//     final questionController = Get.find<QuestionController>();
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20 * scaleFactor)),
//       child: Container(
//         padding: EdgeInsets.all(24 * scaleFactor),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20 * scaleFactor),
//         ),
//         child: Obx(() => Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.auto_awesome, color: AppColors.blueColor, size: 24 * scaleFactor),
//                 SizedBox(width: 12 * scaleFactor),
//                 Text(
//                   'AI Question Generator',
//                   style: TextStyle(
//                     fontSize: 18 * scaleFactor,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.blackColor,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20 * scaleFactor),
//             if (questionController.isGeneratingAI.value)
//               _buildLoadingState(scaleFactor)
//             else if (questionController.aiGeneratedQuestion.value != null)
//               _buildGeneratedQuestionPreview(questionController.aiGeneratedQuestion.value!, questionController, phase.id, context, scaleFactor)
//             else
//               _buildInputForm(topicController, phase.challengeTypes, questionController, context, scaleFactor),
//           ],
//         )),
//       ),
//     );
//   }
//
//   Widget _buildLoadingState(double scaleFactor) {
//     return Center(
//       child: Column(
//         children: [
//           SizedBox(height: 40 * scaleFactor),
//           CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(AppColors.blueColor),
//             strokeWidth: 3,
//           ),
//           SizedBox(height: 20 * scaleFactor),
//           Text(
//             'AI is generating your question...',
//             style: TextStyle(
//               fontSize: 14 * scaleFactor,
//               color: AppColors.languageTextColor,
//             ),
//           ),
//           SizedBox(height: 10 * scaleFactor),
//           Text(
//             'This may take a few seconds',
//             style: TextStyle(
//               fontSize: 12 * scaleFactor,
//               color: AppColors.greyColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildGeneratedQuestionPreview(AIQuestionResponse question, QuestionController controller, int phaseId, BuildContext context, double scaleFactor) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Generated Question Preview',
//           style: TextStyle(
//             fontSize: 16 * scaleFactor,
//             fontWeight: FontWeight.bold,
//             color: AppColors.blackColor,
//           ),
//         ),
//         SizedBox(height: 16 * scaleFactor),
//         Container(
//           padding: EdgeInsets.all(16 * scaleFactor),
//           decoration: BoxDecoration(
//             color: AppColors.forwardColor.withOpacity(0.05),
//             borderRadius: BorderRadius.circular(12 * scaleFactor),
//             border: Border.all(color: AppColors.borderColor),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 question.questionText,
//                 style: TextStyle(
//                   fontSize: 14 * scaleFactor,
//                   fontWeight: FontWeight.w500,
//                   color: AppColors.blackColor,
//                 ),
//               ),
//               if (question.scenario.isNotEmpty) ...[
//                 SizedBox(height: 8 * scaleFactor),
//                 Text(
//                   'Scenario: ${question.scenario}',
//                   style: TextStyle(
//                     fontSize: 12 * scaleFactor,
//                     color: AppColors.languageTextColor,
//                     fontStyle: FontStyle.italic,
//                   ),
//                 ),
//               ],
//               SizedBox(height: 8 * scaleFactor),
//               Text(
//                 'Points: ${question.point}',
//                 style: TextStyle(
//                   fontSize: 12 * scaleFactor,
//                   color: AppColors.blueColor,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 20 * scaleFactor),
//         Row(
//           children: [
//             Expanded(
//               child: OutlinedButton(
//                 onPressed: () => controller.clearAIGeneratedQuestion(),
//                 style: OutlinedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 12 * scaleFactor),
//                   side: BorderSide(color: AppColors.greyColor),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scaleFactor)),
//                 ),
//                 child: Text(
//                   'Generate Another',
//                   style: TextStyle(
//                     fontSize: 14 * scaleFactor,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.greyColor,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: 12 * scaleFactor),
//             Expanded(
//               child: Obx(() => ElevatedButton(
//                 onPressed: controller.isAdding.value
//                     ? null
//                     : () async {
//                   final nextOrder = controller.getNextOrderForPhase(phaseId);
//                   await controller.addAIGeneratedQuestion(question, phaseId, nextOrder);
//                   Get.back();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.blueColor,
//                   padding: EdgeInsets.symmetric(vertical: 12 * scaleFactor),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scaleFactor)),
//                 ),
//                 child: controller.isAdding.value
//                     ? SizedBox(
//                   width: 20 * scaleFactor,
//                   height: 20 * scaleFactor,
//                   child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
//                 )
//                     : Text(
//                   'Add to Phase',
//                   style: TextStyle(
//                     fontSize: 14 * scaleFactor,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               )),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildInputForm(TextEditingController topicController, List<String> challengeTypes, QuestionController controller, BuildContext context, double scaleFactor) {
//     final selectedType = RxString(challengeTypes.isNotEmpty ? challengeTypes.first : '');
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Topic',
//           style: TextStyle(
//             fontSize: 14 * scaleFactor,
//             fontWeight: FontWeight.w600,
//             color: AppColors.blackColor,
//           ),
//         ),
//         SizedBox(height: 8 * scaleFactor),
//         TextField(
//           controller: topicController,
//           decoration: InputDecoration(
//             hintText: 'Enter topic for question generation...',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12 * scaleFactor),
//               borderSide: BorderSide(color: AppColors.borderColor),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12 * scaleFactor),
//               borderSide: BorderSide(color: AppColors.blueColor),
//             ),
//             contentPadding: EdgeInsets.all(16 * scaleFactor),
//           ),
//           maxLines: 2,
//         ),
//         SizedBox(height: 16 * scaleFactor),
//         Text(
//           'Question Type',
//           style: TextStyle(
//             fontSize: 14 * scaleFactor,
//             fontWeight: FontWeight.w600,
//             color: AppColors.blackColor,
//           ),
//         ),
//         SizedBox(height: 8 * scaleFactor),
//         Container(
//           width: double.infinity,
//           padding: EdgeInsets.symmetric(horizontal: 12 * scaleFactor),
//           decoration: BoxDecoration(
//             border: Border.all(color: AppColors.borderColor),
//             borderRadius: BorderRadius.circular(12 * scaleFactor),
//           ),
//           child: DropdownButtonHideUnderline(
//             child: Obx(() => DropdownButton<String>(
//               value: selectedType.value.isEmpty ? null : selectedType.value,
//               isExpanded: true,
//               icon: Icon(Icons.arrow_drop_down, color: AppColors.blueColor),
//               items: challengeTypes.map((String type) {
//                 return DropdownMenuItem<String>(
//                   value: type,
//                   child: Text(type, style: TextStyle(fontSize: 14 * scaleFactor)),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 if (newValue != null) {
//                   selectedType.value = newValue;
//                 }
//               },
//             )),
//           ),
//         ),
//         SizedBox(height: 24 * scaleFactor),
//         Row(
//           children: [
//             Expanded(
//               child: OutlinedButton(
//                 onPressed: () => Get.back(),
//                 style: OutlinedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 12 * scaleFactor),
//                   side: BorderSide(color: AppColors.greyColor),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scaleFactor)),
//                 ),
//                 child: Text(
//                   'Cancel',
//                   style: TextStyle(
//                     fontSize: 14 * scaleFactor,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.greyColor,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: 12 * scaleFactor),
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (topicController.text.isEmpty) {
//                     Get.snackbar('Error', 'Please enter a topic', backgroundColor: Colors.red);
//                     return;
//                   }
//                   if (selectedType.value.isEmpty) {
//                     Get.snackbar('Error', 'Please select a question type', backgroundColor: Colors.red);
//                     return;
//                   }
//                   controller.generateAIQuestion(
//                     topic: topicController.text,
//                     type: selectedType.value,
//                     gameName: "Leadership Game", // Hardcoded for now; adjust if dynamic
//                     phaseName: phase.name,
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.blueColor,
//                   padding: EdgeInsets.symmetric(vertical: 12 * scaleFactor),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scaleFactor)),
//                 ),
//                 child: Text(
//                   'Generate',
//                   style: TextStyle(
//                     fontSize: 14 * scaleFactor,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }