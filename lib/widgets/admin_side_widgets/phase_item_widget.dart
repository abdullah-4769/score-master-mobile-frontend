// lib/widgets/admin_side_widgets/phase_item_widget.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/widgets/admin_side_widgets/question_list_widget.dart';
import '../../api/api_controllers/question_controller.dart';
import '../../api/api_models/phase_model.dart';
import '../../constants/appcolors.dart';
import '../../widgets/bold_text.dart';
import '../../widgets/main_text.dart';


class PhaseItem extends StatelessWidget {
  final PhaseModel phase;
  final int index;
  final double scaleFactor;
  final VoidCallback onAddQuestion;

  const PhaseItem({
    Key? key,
    required this.phase,
    required this.index,
    required this.scaleFactor,
    required this.onAddQuestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final questionController = Get.find<QuestionController>();

    return Container(
      margin: EdgeInsets.only(bottom: 16 * scaleFactor),
      padding: EdgeInsets.all(16 * scaleFactor),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scaleFactor),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phase Header
          Row(
            children: [
              Container(
                width: 40 * scaleFactor,
                height: 40 * scaleFactor,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.blueColor, AppColors.blueColor.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10 * scaleFactor),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: 18 * scaleFactor,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12 * scaleFactor),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoldText(
                      text: phase.name,
                      fontSize: 16 * scaleFactor,
                      selectionColor: AppColors.blackColor,
                    ),
                    SizedBox(height: 4 * scaleFactor),
                    Row(
                      children: [
                        Icon(Icons.timer, size: 14 * scaleFactor, color: AppColors.teamColor),
                        SizedBox(width: 4 * scaleFactor),
                        MainText(
                          text: '${phase.timeDuration} min',
                          fontSize: 12 * scaleFactor,
                          color: AppColors.teamColor,
                        ),
                        SizedBox(width: 12 * scaleFactor),
                        Icon(Icons.layers, size: 14 * scaleFactor, color: AppColors.teamColor),
                        SizedBox(width: 4 * scaleFactor),
                        MainText(
                          text: '${phase.stagesCount} stages',
                          fontSize: 12 * scaleFactor,
                          color: AppColors.teamColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12 * scaleFactor),

          // Challenge Types
          Wrap(
            spacing: 8 * scaleFactor,
            runSpacing: 8 * scaleFactor,
            children: phase.challengeTypes.map((type) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10 * scaleFactor,
                  vertical: 6 * scaleFactor,
                ),
                decoration: BoxDecoration(
                  color: _getChallengeColor(type).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6 * scaleFactor),
                  border: Border.all(color: _getChallengeColor(type).withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getChallengeIcon(type),
                      size: 14 * scaleFactor,
                      color: _getChallengeColor(type),
                    ),
                    SizedBox(width: 4 * scaleFactor),
                    Text(
                      type,
                      style: TextStyle(
                        fontSize: 11 * scaleFactor,
                        fontWeight: FontWeight.w600,
                        color: _getChallengeColor(type),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 12 * scaleFactor),

          // Questions Section
          Obx(() {
            final phaseQuestions = questionController.getQuestionsForPhase(phase.id ?? 0);


            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.quiz, size: 16 * scaleFactor, color: AppColors.blueColor),
                        SizedBox(width: 6 * scaleFactor),
                        BoldText(
                          text: 'Questions (${phaseQuestions.length})',
                          fontSize: 14 * scaleFactor,
                          selectionColor: AppColors.blueColor,
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: onAddQuestion,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12 * scaleFactor,
                          vertical: 6 * scaleFactor,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.forwardColor,
                          borderRadius: BorderRadius.circular(8 * scaleFactor),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, size: 16 * scaleFactor, color: Colors.white),
                            SizedBox(width: 4 * scaleFactor),
                            Text(
                              'Add Question',
                              style: TextStyle(
                                fontSize: 12 * scaleFactor,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                if (phaseQuestions.isNotEmpty) ...[
                  SizedBox(height: 12 * scaleFactor),
                  QuestionList(
                    questions: phaseQuestions,
                    scaleFactor: scaleFactor,
                    questionType: phase.challengeTypes,
                  ),
                ] else ...[
                  SizedBox(height: 12 * scaleFactor),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16 * scaleFactor),
                    decoration: BoxDecoration(
                      color: AppColors.forwardColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12 * scaleFactor),
                      border: Border.all(color: AppColors.borderColor.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.quiz_outlined,
                          size: 32 * scaleFactor,
                          color: AppColors.greyColor,
                        ),
                        SizedBox(height: 8 * scaleFactor),
                        MainText(
                          text: 'No questions added yet',
                          fontSize: 13 * scaleFactor,
                          color: AppColors.languageTextColor,
                        ),
                        SizedBox(height: 4 * scaleFactor),
                        MainText(
                          text: 'Click "Add Question" to get started',
                          fontSize: 11 * scaleFactor,
                          color: AppColors.teamColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            );
          }),
        ],
      ),
    );
  }

  Color _getChallengeColor(String type) {
    switch (type.toUpperCase()) {
      case 'MCQ':
        return AppColors.blueColor;
      case 'PUZZLE':
        return AppColors.orangeColor;
      case 'OPEN_ENDED':
      case 'OPEN ENDED':
        return AppColors.forwardColor;
      case 'SIMULATION':
        return AppColors.redColor;
      default:
        return AppColors.blueColor;
    }
  }

  IconData _getChallengeIcon(String type) {
    switch (type.toUpperCase()) {
      case 'MCQ':
        return Icons.radio_button_checked;
      case 'PUZZLE':
        return Icons.extension;
      case 'OPEN_ENDED':
      case 'OPEN ENDED':
        return Icons.text_fields;
      case 'SIMULATION':
        return Icons.play_circle;
      default:
        return Icons.help;
    }
  }
}










// // widgets/admin_side_widgets/phase_item_widget.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:scorer/widgets/admin_side_widgets/question_list_widget.dart';
// import '../../constants/appcolors.dart';
// import '../../api/api_controllers/question_controller.dart';
//
// class PhaseItem extends StatelessWidget {
//   final dynamic phase;
//   final int index;
//   final double scaleFactor;
//   final VoidCallback onAddQuestion;
//
//   const PhaseItem({
//     Key? key,
//     required this.phase,
//     required this.index,
//     required this.scaleFactor,
//     required this.onAddQuestion,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           margin: EdgeInsets.only(bottom: 16 * scaleFactor),
//           padding: EdgeInsets.all(16 * scaleFactor),
//           decoration: BoxDecoration(
//             color: AppColors.forwardColor.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(16 * scaleFactor),
//             border: Border.all(color: AppColors.borderColor, width: 1),
//           ),
//           child: Row(
//             children: [
//               _buildPhaseIcon(),
//               SizedBox(width: 16 * scaleFactor),
//               _buildPhaseInfo(),
//               _buildActionButtons(context),
//             ],
//           ),
//         ),
//         Obx(() {
//           final questionController = Get.find<QuestionController>();
//           final questions = questionController.questions.where((q) => q.phaseId == phase.id).toList();
//           return QuestionList(
//             questions: questions,
//             scaleFactor: scaleFactor,
//             questionType: phase.challengeTypes,
//           );
//         }),
//       ],
//     );
//   }
//
//   Widget _buildPhaseIcon() {
//     return Container(
//       width: 40 * scaleFactor,
//       height: 40 * scaleFactor,
//       decoration: BoxDecoration(
//         color: AppColors.forwardColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(8 * scaleFactor),
//       ),
//       child: Icon(Icons.grid_view, color: AppColors.forwardColor, size: 20 * scaleFactor),
//     );
//   }
//
//   Widget _buildPhaseInfo() {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Phase ${index + 1} - ${phase.name}",
//             style: TextStyle(
//               fontSize: 16 * scaleFactor,
//               fontWeight: FontWeight.w600,
//               color: AppColors.blackColor,
//             ),
//           ),
//           SizedBox(height: 4 * scaleFactor),
//           Text(
//             "${phase.stagesCount} Stage - ${_formatDuration(phase.timeDuration)}",
//             style: TextStyle(
//               fontSize: 13 * scaleFactor,
//               color: AppColors.languageTextColor,
//             ),
//           ),
//           if (phase.challengeTypes.isNotEmpty)
//             SizedBox(height: 8 * scaleFactor),
//           if (phase.challengeTypes.isNotEmpty)
//             Wrap(
//               spacing: 4 * scaleFactor,
//               runSpacing: 4 * scaleFactor,
//               children: phase.challengeTypes.take(2).map<Widget>((type) => Container(
//                 padding: EdgeInsets.symmetric(horizontal: 6 * scaleFactor, vertical: 2 * scaleFactor),
//                 decoration: BoxDecoration(
//                   color: AppColors.forwardColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(4 * scaleFactor),
//                 ),
//                 child: Text(
//                   type,
//                   style: TextStyle(
//                     fontSize: 9 * scaleFactor,
//                     color: AppColors.blueColor,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               )).toList(),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActionButtons(BuildContext context) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: () {
//             Get.snackbar('Edit Phase', 'Editing phase: ${phase.name}');
//           },
//           child: Container(
//             width: 36 * scaleFactor,
//             height: 36 * scaleFactor,
//             decoration: BoxDecoration(
//               color: AppColors.forwardColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8 * scaleFactor),
//             ),
//             child: Icon(Icons.edit, color: AppColors.forwardColor, size: 18 * scaleFactor),
//           ),
//         ),
//         SizedBox(height: 8 * scaleFactor),
//         GestureDetector(
//           onTap: onAddQuestion,
//           child: Container(
//             width: 36 * scaleFactor,
//             height: 36 * scaleFactor,
//             decoration: BoxDecoration(
//               color: AppColors.forwardColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8 * scaleFactor),
//             ),
//             child: Icon(Icons.add_circle_outline, color: AppColors.forwardColor, size: 18 * scaleFactor),
//           ),
//         ),
//       ],
//     );
//   }
//
//   String _formatDuration(int minutes) {
//     if (minutes >= 60) {
//       int hours = minutes ~/ 60;
//       int remainingMinutes = minutes % 60;
//       return remainingMinutes == 0 ? "${hours}h" : "${hours}h ${remainingMinutes}m";
//     }
//     return "$minutes minutes";
//   }
// }