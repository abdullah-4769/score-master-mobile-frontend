import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/controllers/game_select_controller.dart';
import 'package:scorer/api/api_models/question_for_session_model.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/components/scenerio_container.dart';
import 'package:scorer/widgets/filter_useable_container.dart';
import 'package:scorer/components/responsive_fonts.dart';

class PhaseQuestionsContainer extends StatelessWidget {
  final double heightScaleFactor;
  final double widthScaleFactor;
  final Question question;
  final GameSelectController controller;

  const PhaseQuestionsContainer({
    super.key,
    required this.heightScaleFactor,
    required this.widthScaleFactor,
    required this.question,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    print("🎯 Rendering question: ${question.id} - ${question.type} - ${question.questionText}");
    return _buildQuestionByType(question);
  }

  Widget _buildQuestionByType(Question question) {
    switch (question.type.toUpperCase()) {
      case 'MCQ':
        return _buildMcqType(question);
      case 'PUZZLE':
        return _buildPuzzleType(question);
      case 'OPENENDED':
      case 'OPEN_ENDED':
        return _buildOpenEndedType(question);
      case 'SIMULATION':
        return _buildSimulationType(question);
      default:
        return _buildDefaultType(question);
    }
  }

  Widget _buildDefaultType(Question question) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16 * widthScaleFactor),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyColor, width: 1.5),
        borderRadius: BorderRadius.circular(16 * widthScaleFactor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestionHeader(question, questionType: question.type.toUpperCase()),
          SizedBox(height: 12 * heightScaleFactor),
          BoldText(
            text: question.questionText.isNotEmpty
                ? question.questionText
                : "No question text available",
            selectionColor: AppColors.redColor,
            fontSize: 16 * heightScaleFactor,
          ),
          SizedBox(height: 15 * heightScaleFactor),
          MainText(
            text: "This question type (${question.type}) is not fully supported yet.",
            fontSize: 14 * heightScaleFactor,
            color: AppColors.teamColor,
          ),
        ],
      ),
    );
  }

  Widget _buildMcqType(Question question) {
    final options = question.mcqOptions ?? [];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16 * widthScaleFactor),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyColor, width: 1.5),
        borderRadius: BorderRadius.circular(16 * widthScaleFactor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestionHeader(question, questionType: 'MCQ'),
          SizedBox(height: 12 * heightScaleFactor),
          BoldText(
            text: question.questionText.isNotEmpty
                ? question.questionText
                : "Multiple Choice Question",
            selectionColor: AppColors.redColor,
            fontSize: 16 * heightScaleFactor,
          ),
          SizedBox(height: 15 * heightScaleFactor),
          if (options.isEmpty)
            MainText(
              text: "No options available",
              fontSize: 13 * widthScaleFactor,
              color: AppColors.teamColor,
            )
          else
            ...List.generate(options.length, (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10 * heightScaleFactor),
                child: Obx(() {
                  final selectedOption = controller.getSelectedMcqOption(question.id);
                  return FilterUseableContainer(
                    isSelected: selectedOption == index,
                    fontSze: ResponsiveFont.getFontSizeCustom(
                      defaultSize: 13 * widthScaleFactor,
                      smallSize: 10 * widthScaleFactor,
                    ),
                    text: options[index],
                    onTap: () {
                      controller.selectMcqOption(question.id, index);
                    },
                  );
                }),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildPuzzleType(Question question) {
    final options = question.sequenceOptions ?? question.mcqOptions ?? [];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16 * widthScaleFactor),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyColor, width: 1.5),
        borderRadius: BorderRadius.circular(16 * widthScaleFactor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestionHeader(question, questionType: 'PUZZLE'),
          SizedBox(height: 12 * heightScaleFactor),
          if (question.scenario.isNotEmpty) ...[
            ScenerioContainer(
              text: question.scenario,
              width: double.infinity,
              height: 130 * heightScaleFactor,
              fontsize: 12 * heightScaleFactor,
              heightScaleFactor: heightScaleFactor,
              widthScaleFactor: widthScaleFactor,
            ),
            SizedBox(height: 20 * heightScaleFactor),
          ],
          BoldText(
            text: question.questionText.isNotEmpty
                ? question.questionText
                : "Puzzle Question",
            selectionColor: AppColors.redColor,
            fontSize: 16 * heightScaleFactor,
          ),
          SizedBox(height: 5 * heightScaleFactor),
          MainText(
            text: "Select options in the correct order",
            fontSize: 12 * heightScaleFactor,
            color: AppColors.teamColor,
          ),
          SizedBox(height: 15 * heightScaleFactor),
          if (options.isEmpty)
            MainText(
              text: "No options available",
              fontSize: 13 * widthScaleFactor,
              color: AppColors.teamColor,
            )
          else
            ...List.generate(options.length, (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10 * heightScaleFactor),
                child: Obx(() {
                  final selectedSequence = controller.getPuzzleSequence(question.id);
                  final sequenceIndex = selectedSequence.indexOf(index);
                  final isSelected = sequenceIndex != -1;

                  return Row(
                    children: [
                      if (isSelected)
                        Container(
                          width: 30 * widthScaleFactor,
                          height: 30 * heightScaleFactor,
                          margin: EdgeInsets.only(right: 8 * widthScaleFactor),
                          decoration: BoxDecoration(
                            color: AppColors.forwardColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: BoldText(
                              text: "${sequenceIndex + 1}",
                              fontSize: 14 * heightScaleFactor,
                              selectionColor: Colors.white,
                            ),
                          ),
                        ),
                      Expanded(
                        child: FilterUseableContainer(
                          isSelected: isSelected,
                          fontSze: ResponsiveFont.getFontSizeCustom(
                            defaultSize: 13 * widthScaleFactor,
                            smallSize: 10 * widthScaleFactor,
                          ),
                          text: options[index],
                          onTap: () {
                            controller.toggleSequenceSelection(question.id, index);
                          },
                        ),
                      ),
                    ],
                  );
                }),
              );
            }),
          Obx(() {
            final selectedSequence = controller.getPuzzleSequence(question.id);
            if (selectedSequence.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.only(top: 15 * heightScaleFactor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoldText(
                      text: "Your Sequence",
                      fontSize: 14 * heightScaleFactor,
                      selectionColor: AppColors.blueColor,
                    ),
                    SizedBox(height: 8 * heightScaleFactor),
                    Container(
                      padding: EdgeInsets.all(12 * widthScaleFactor),
                      decoration: BoxDecoration(
                        color: AppColors.forwardColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8 * widthScaleFactor),
                      ),
                      child: MainText(
                        text: selectedSequence
                            .map((i) => "${selectedSequence.indexOf(i) + 1}. ${options[i]}")
                            .join(" → "),
                        fontSize: 12 * heightScaleFactor,
                      ),
                    ),
                    SizedBox(height: 8 * heightScaleFactor),
                    InkWell(
                      onTap: () => controller.clearPuzzleSequence(question.id),
                      child: MainText(
                        text: "Clear Sequence",
                        fontSize: 12 * heightScaleFactor,
                        color: AppColors.redColor,
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget _buildOpenEndedType(Question question) {
    final textController = TextEditingController(
      text: controller.getTextResponse(question.id) ?? '',
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16 * widthScaleFactor),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyColor, width: 1.5),
        borderRadius: BorderRadius.circular(16 * widthScaleFactor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestionHeader(question, questionType: 'OPEN-ENDED'),
          SizedBox(height: 12 * heightScaleFactor),
          BoldText(
            text: question.questionText.isNotEmpty
                ? question.questionText
                : "Open Ended Question",
            selectionColor: AppColors.redColor,
            fontSize: 16 * heightScaleFactor,
          ),
          SizedBox(height: 15 * heightScaleFactor),
          _buildInputBox(question, textController),
        ],
      ),
    );
  }

  Widget _buildSimulationType(Question question) {
    final textController = TextEditingController(
      text: controller.getTextResponse(question.id) ?? '',
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16 * widthScaleFactor),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyColor, width: 1.5),
        borderRadius: BorderRadius.circular(16 * widthScaleFactor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestionHeader(question, questionType: 'SIMULATION'),
          SizedBox(height: 12 * heightScaleFactor),
          if (question.scenario.isNotEmpty) ...[
            ScenerioContainer(
              text: question.scenario,
              width: double.infinity,
              height: 130 * heightScaleFactor,
              fontsize: 12 * heightScaleFactor,
              heightScaleFactor: heightScaleFactor,
              widthScaleFactor: widthScaleFactor,
            ),
            SizedBox(height: 20 * heightScaleFactor),
          ],
          BoldText(
            text: question.questionText.isNotEmpty
                ? question.questionText
                : "Simulation Question",
            selectionColor: AppColors.redColor,
            fontSize: 16 * heightScaleFactor,
          ),
          SizedBox(height: 15 * heightScaleFactor),
          _buildInputBox(question, textController),
        ],
      ),
    );
  }

  Widget _buildQuestionHeader(Question question, {required String questionType}) {
    Color color;
    String typeText = questionType;

    switch (questionType) {
      case 'MCQ':
        color = AppColors.blueColor;
        break;
      case 'PUZZLE':
        color = AppColors.orangeColor;
        break;
      case 'OPEN-ENDED':
        color = AppColors.forwardColor;
        break;
      case 'SIMULATION':
        color = AppColors.redColor;
        break;
      default:
        color = AppColors.greyColor;
    }

    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 8 * widthScaleFactor,
            vertical: 4 * heightScaleFactor,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4 * widthScaleFactor),
          ),
          child: MainText(
            text: typeText,
            fontSize: 10 * heightScaleFactor,
            color: color,
          ),
        ),
        SizedBox(width: 8 * widthScaleFactor),
        MainText(
          text: "${question.point} points",
          fontSize: 10 * heightScaleFactor,
          color: AppColors.teamColor,
        ),
        Spacer(),
        MainText(
          text: "ID: ${question.id}",
          fontSize: 10 * heightScaleFactor,
          color: AppColors.greyColor,
        ),
      ],
    );
  }

  Widget _buildInputBox(Question question, TextEditingController textController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 130 * heightScaleFactor,
          padding: EdgeInsets.all(12 * widthScaleFactor),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.greyColor, width: 1.5),
            borderRadius: BorderRadius.circular(12 * widthScaleFactor),
          ),
          child: TextFormField(
            controller: textController,
            cursorColor: AppColors.blackColor,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              hintText: "Share your thoughts...",
              hintStyle: TextStyle(color: AppColors.teamColor, fontSize: 14 * heightScaleFactor),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            onChanged: (value) {
              controller.saveTextResponse(question.id, value);
            },
          ),
        ),
      ],
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:scorer/constants/appcolors.dart';
// import 'package:scorer/controllers/game_select_controller.dart';
// import 'package:scorer/api/api_models/question_for_session_model.dart';
// import 'package:scorer/widgets/bold_text.dart';
// import 'package:scorer/widgets/main_text.dart';
// import 'package:scorer/components/scenerio_container.dart';
// import 'package:scorer/widgets/filter_useable_container.dart';
// import 'package:scorer/components/responsive_fonts.dart';
//
// enum PhaseType { mcq, puzzle, openEnded, simulation }
//
// class PhaseQuestionsContainer extends StatelessWidget {
//   final double heightScaleFactor;
//   final double widthScaleFactor;
//   final List<Question> questions;
//   final GameSelectController controller;
//
//   const PhaseQuestionsContainer({
//     super.key,
//     required this.heightScaleFactor,
//     required this.widthScaleFactor,
//     required this.questions,
//     required this.controller,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (questions.isEmpty) return const SizedBox.shrink();
//
//     // Sort questions by order field
//     final sortedQuestions = List<Question>.from(questions)
//       ..sort((a, b) => a.order.compareTo(b.order));
//
//     return Column(
//       children: sortedQuestions.asMap().entries.map((entry) {
//         final index = entry.key;
//         final question = entry.value;
//         return Padding(
//           padding: EdgeInsets.only(
//             bottom: 20 * heightScaleFactor,
//             top: index == 0 ? 0 : 10 * heightScaleFactor,
//           ),
//           child: _buildQuestionByType(question),
//         );
//       }).toList(),
//     );
//   }
//
//   Widget _buildQuestionByType(Question question) {
//     switch (question.type.toUpperCase()) {
//       case 'MCQ':
//         return _buildMcqType(question);
//       case 'PUZZLE':
//         return _buildPuzzleType(question);
//       case 'OPENENDED':
//       case 'OPEN_ENDED':
//         return _buildOpenEndedType(question);
//       case 'SIMULATION':
//         return _buildSimulationType(question);
//       default:
//         return const SizedBox();
//     }
//   }
//
//   // ================== MCQ Type ==================
//   Widget _buildMcqType(Question question) {
//     final options = question.mcqOptions ?? [];
//
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(16 * widthScaleFactor),
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColors.greyColor, width: 1.5),
//         borderRadius: BorderRadius.circular(16 * widthScaleFactor),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 8 * widthScaleFactor,
//                   vertical: 4 * heightScaleFactor,
//                 ),
//                 decoration: BoxDecoration(
//                   color: AppColors.blueColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(4 * widthScaleFactor),
//                 ),
//                 child: MainText(
//                   text: "MCQ",
//                   fontSize: 10 * heightScaleFactor,
//                   color: AppColors.blueColor,
//                 ),
//               ),
//               SizedBox(width: 8 * widthScaleFactor),
//               MainText(
//                 text: "${question.point} points",
//                 fontSize: 10 * heightScaleFactor,
//                 color: AppColors.teamColor,
//               ),
//             ],
//           ),
//           SizedBox(height: 12 * heightScaleFactor),
//           BoldText(
//             text: question.questionText.isNotEmpty
//                 ? question.questionText
//                 : "question".tr,
//             selectionColor: AppColors.redColor,
//             fontSize: 16 * heightScaleFactor,
//           ),
//           SizedBox(height: 10 * heightScaleFactor),
//           if (options.isEmpty)
//             MainText(
//               text: "no_options_available".tr,
//               fontSize: 13 * widthScaleFactor,
//               color: AppColors.teamColor,
//             )
//           else
//             ...List.generate(options.length, (index) {
//               return Padding(
//                 padding: EdgeInsets.only(bottom: 10 * heightScaleFactor),
//                 child: Obx(() {
//                   final selectedOption = controller.getSelectedMcqOption(question.id);
//                   return FilterUseableContainer(
//                     isSelected: selectedOption == index,
//                     fontSze: ResponsiveFont.getFontSizeCustom(
//                       defaultSize: 13 * widthScaleFactor,
//                       smallSize: 10 * widthScaleFactor,
//                     ),
//                     text: options[index],
//                     onTap: () {
//                       controller.selectMcqOption(question.id, index);
//                     },
//                   );
//                 }),
//               );
//             }),
//         ],
//       ),
//     );
//   }
//
//   // ================== Puzzle Type (Sequence Selection) ==================
//   Widget _buildPuzzleType(Question question) {
//     final options = question.sequenceOptions ?? question.mcqOptions ?? [];
//
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(16 * widthScaleFactor),
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColors.greyColor, width: 1.5),
//         borderRadius: BorderRadius.circular(16 * widthScaleFactor),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 8 * widthScaleFactor,
//                   vertical: 4 * heightScaleFactor,
//                 ),
//                 decoration: BoxDecoration(
//                   color: AppColors.orangeColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(4 * widthScaleFactor),
//                 ),
//                 child: MainText(
//                   text: "PUZZLE",
//                   fontSize: 10 * heightScaleFactor,
//                   color: AppColors.orangeColor,
//                 ),
//               ),
//               SizedBox(width: 8 * widthScaleFactor),
//               MainText(
//                 text: "${question.point} points",
//                 fontSize: 10 * heightScaleFactor,
//                 color: AppColors.teamColor,
//               ),
//             ],
//           ),
//           SizedBox(height: 12 * heightScaleFactor),
//           if (question.scenario.isNotEmpty) ...[
//             ScenerioContainer(
//               text: question.scenario,
//               width: double.infinity,
//               height: 130 * heightScaleFactor,
//               fontsize: 12 * heightScaleFactor,
//               heightScaleFactor: heightScaleFactor,
//               widthScaleFactor: widthScaleFactor,
//             ),
//             SizedBox(height: 20 * heightScaleFactor),
//           ],
//           BoldText(
//             text: question.questionText.isNotEmpty
//                 ? question.questionText
//                 : "question".tr,
//             selectionColor: AppColors.redColor,
//             fontSize: 16 * heightScaleFactor,
//           ),
//           SizedBox(height: 5 * heightScaleFactor),
//           MainText(
//             text: "select_options_in_order".tr,
//             fontSize: 12 * heightScaleFactor,
//             color: AppColors.teamColor,
//           ),
//           SizedBox(height: 10 * heightScaleFactor),
//           if (options.isEmpty)
//             MainText(
//               text: "no_options_available".tr,
//               fontSize: 13 * widthScaleFactor,
//               color: AppColors.teamColor,
//             )
//           else
//             ...List.generate(options.length, (index) {
//               return Padding(
//                 padding: EdgeInsets.only(bottom: 10 * heightScaleFactor),
//                 child: Obx(() {
//                   final selectedSequence = controller.getPuzzleSequence(question.id);
//                   final sequenceIndex = selectedSequence.indexOf(index);
//                   final isSelected = sequenceIndex != -1;
//
//                   return Row(
//                     children: [
//                       if (isSelected)
//                         Container(
//                           width: 30 * widthScaleFactor,
//                           height: 30 * heightScaleFactor,
//                           margin: EdgeInsets.only(right: 8 * widthScaleFactor),
//                           decoration: BoxDecoration(
//                             color: AppColors.forwardColor,
//                             shape: BoxShape.circle,
//                           ),
//                           child: Center(
//                             child: BoldText(
//                               text: "${sequenceIndex + 1}",
//                               fontSize: 14 * heightScaleFactor,
//                               selectionColor: Colors.white,
//                             ),
//                           ),
//                         ),
//                       Expanded(
//                         child: FilterUseableContainer(
//                           isSelected: isSelected,
//                           fontSze: ResponsiveFont.getFontSizeCustom(
//                             defaultSize: 13 * widthScaleFactor,
//                             smallSize: 10 * widthScaleFactor,
//                           ),
//                           text: options[index],
//                           onTap: () {
//                             controller.toggleSequenceSelection(question.id, index);
//                           },
//                         ),
//                       ),
//                     ],
//                   );
//                 }),
//               );
//             }),
//           Obx(() {
//             final selectedSequence = controller.getPuzzleSequence(question.id);
//             if (selectedSequence.isNotEmpty) {
//               return Padding(
//                 padding: EdgeInsets.only(top: 15 * heightScaleFactor),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     BoldText(
//                       text: "your_sequence".tr,
//                       fontSize: 14 * heightScaleFactor,
//                       selectionColor: AppColors.blueColor,
//                     ),
//                     SizedBox(height: 8 * heightScaleFactor),
//                     Container(
//                       padding: EdgeInsets.all(12 * widthScaleFactor),
//                       decoration: BoxDecoration(
//                         color: AppColors.forwardColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(8 * widthScaleFactor),
//                       ),
//                       child: MainText(
//                         text: selectedSequence
//                             .map((i) => "${selectedSequence.indexOf(i) + 1}. ${options[i]}")
//                             .join(" → "),
//                         fontSize: 12 * heightScaleFactor,
//                       ),
//                     ),
//                     SizedBox(height: 8 * heightScaleFactor),
//                     InkWell(
//                       onTap: () => controller.clearPuzzleSequence(question.id),
//                       child: MainText(
//                         text: "clear_sequence".tr,
//                         fontSize: 12 * heightScaleFactor,
//                         color: AppColors.redColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }
//             return const SizedBox.shrink();
//           }),
//         ],
//       ),
//     );
//   }
//
//   // ================== Open Ended Type ==================
//   Widget _buildOpenEndedType(Question question) {
//     final textController = TextEditingController(
//       text: controller.getTextResponse(question.id) ?? '',
//     );
//
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(16 * widthScaleFactor),
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColors.greyColor, width: 1.5),
//         borderRadius: BorderRadius.circular(16 * widthScaleFactor),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 8 * widthScaleFactor,
//                   vertical: 4 * heightScaleFactor,
//                 ),
//                 decoration: BoxDecoration(
//                   color: AppColors.forwardColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(4 * widthScaleFactor),
//                 ),
//                 child: MainText(
//                   text: "OPEN-ENDED",
//                   fontSize: 10 * heightScaleFactor,
//                   color: AppColors.forwardColor,
//                 ),
//               ),
//               SizedBox(width: 8 * widthScaleFactor),
//               MainText(
//                 text: "${question.point} points",
//                 fontSize: 10 * heightScaleFactor,
//                 color: AppColors.teamColor,
//               ),
//             ],
//           ),
//           SizedBox(height: 12 * heightScaleFactor),
//           BoldText(
//             text: question.questionText.isNotEmpty
//                 ? question.questionText
//                 : "question".tr,
//             selectionColor: AppColors.redColor,
//             fontSize: 16 * heightScaleFactor,
//           ),
//           SizedBox(height: 10 * heightScaleFactor),
//           _buildInputBox(question, textController),
//         ],
//       ),
//     );
//   }
//
//   // ================== Simulation Type ==================
//   Widget _buildSimulationType(Question question) {
//     final textController = TextEditingController(
//       text: controller.getTextResponse(question.id) ?? '',
//     );
//
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(16 * widthScaleFactor),
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColors.greyColor, width: 1.5),
//         borderRadius: BorderRadius.circular(16 * widthScaleFactor),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 8 * widthScaleFactor,
//                   vertical: 4 * heightScaleFactor,
//                 ),
//                 decoration: BoxDecoration(
//                   color: AppColors.redColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(4 * widthScaleFactor),
//                 ),
//                 child: MainText(
//                   text: "SIMULATION",
//                   fontSize: 10 * heightScaleFactor,
//                   color: AppColors.redColor,
//                 ),
//               ),
//               SizedBox(width: 8 * widthScaleFactor),
//               MainText(
//                 text: "${question.point} points",
//                 fontSize: 10 * heightScaleFactor,
//                 color: AppColors.teamColor,
//               ),
//             ],
//           ),
//           SizedBox(height: 12 * heightScaleFactor),
//           if (question.scenario.isNotEmpty) ...[
//             ScenerioContainer(
//               text: question.scenario,
//               width: double.infinity,
//               height: 130 * heightScaleFactor,
//               fontsize: 12 * heightScaleFactor,
//               heightScaleFactor: heightScaleFactor,
//               widthScaleFactor: widthScaleFactor,
//             ),
//             SizedBox(height: 20 * heightScaleFactor),
//           ],
//           BoldText(
//             text: question.questionText.isNotEmpty
//                 ? question.questionText
//                 : "question".tr,
//             selectionColor: AppColors.redColor,
//             fontSize: 16 * heightScaleFactor,
//           ),
//           SizedBox(height: 10 * heightScaleFactor),
//           _buildInputBox(question, textController),
//         ],
//       ),
//     );
//   }
//
//   // ================== Input Box ==================
//   Widget _buildInputBox(Question question, TextEditingController textController) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 10 * heightScaleFactor),
//         Container(
//           width: double.infinity,
//           height: 130 * heightScaleFactor,
//           padding: EdgeInsets.all(12 * widthScaleFactor),
//           decoration: BoxDecoration(
//             border: Border.all(color: AppColors.greyColor, width: 1.5),
//             borderRadius: BorderRadius.circular(12 * widthScaleFactor),
//           ),
//           child: TextFormField(
//             controller: textController,
//             cursorColor: AppColors.blackColor,
//             maxLines: null,
//             expands: true,
//             textAlignVertical: TextAlignVertical.top,
//             decoration: InputDecoration(
//               hintText: "share_thought_process".tr,
//               hintStyle: const TextStyle(color: AppColors.teamColor),
//               border: InputBorder.none,
//               focusedBorder: InputBorder.none,
//               enabledBorder: InputBorder.none,
//             ),
//             onChanged: (value) {
//               controller.saveTextResponse(question.id, value);
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
