import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/api_models/questions_model.dart';
import '../../constants/appcolors.dart';
import '../../widgets/bold_text.dart';
import '../../widgets/main_text.dart';
import 'add_question_dialogue.dart';
import 'ai_question_dialogue.dart';

class QuestionTypeSelectionDialog extends StatelessWidget {
  final dynamic phase;
  final double scaleFactor;

  const QuestionTypeSelectionDialog({
    Key? key,
    required this.phase,
    required this.scaleFactor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final questionTypes = List<String>.from(phase.challengeTypes);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: 20 * scaleFactor,
        vertical: 24 * scaleFactor,
      ),
      child: Container(
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(scaleFactor, context),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24 * scaleFactor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainText(
                      text: 'Select how you want to add your question:',
                      fontSize: 14 * scaleFactor,
                      color: AppColors.languageTextColor,
                    ),
                    SizedBox(height: 16 * scaleFactor),

                    // AI Generation Option (Featured)
                    _buildAIOption(context, scaleFactor),

                    SizedBox(height: 16 * scaleFactor),

                    Row(
                      children: [
                        Expanded(child: Divider(color: AppColors.greyColor)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12 * scaleFactor),
                          child: MainText(
                            text: 'OR',
                            fontSize: 12 * scaleFactor,
                            color: AppColors.teamColor,
                          ),
                        ),
                        Expanded(child: Divider(color: AppColors.greyColor)),
                      ],
                    ),

                    SizedBox(height: 16 * scaleFactor),

                    BoldText(
                      text: 'Add Manually',
                      fontSize: 14 * scaleFactor,
                      selectionColor: AppColors.blackColor,
                    ),
                    SizedBox(height: 12 * scaleFactor),

                    // Manual Question Type Options
                    ...questionTypes.asMap().entries.map((entry) {
                      final type = entry.value;
                      return _buildQuestionTypeCard(
                        type,
                        context,
                        scaleFactor,
                        isLast: entry.key == questionTypes.length - 1,
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(double sf, BuildContext context) {
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
              Icons.add_circle,
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
                  'Add Question',
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
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close, color: Colors.white, size: 24 * sf),
          ),
        ],
      ),
    );
  }

  Widget _buildAIOption(BuildContext context, double sf) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Get.to(() => AIQuestionDialog(
          phase: phase,
          scaleFactor: scaleFactor,
        ));
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20 * sf),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.blueColor,
              AppColors.blueColor.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16 * sf),
          boxShadow: [
            BoxShadow(
              color: AppColors.blueColor.withOpacity(0.3),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50 * sf,
              height: 50 * sf,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12 * sf),
              ),
              child: Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 28 * sf,
              ),
            ),
            SizedBox(width: 16 * sf),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'AI Generate',
                        style: TextStyle(
                          fontSize: 16 * sf,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 6 * sf),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6 * sf,
                          vertical: 2 * sf,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.forwardColor,
                          borderRadius: BorderRadius.circular(4 * sf),
                        ),
                        child: Text(
                          'RECOMMENDED',
                          style: TextStyle(
                            fontSize: 8 * sf,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4 * sf),
                  Text(
                    'Let AI create contextual questions for you',
                    style: TextStyle(
                      fontSize: 12 * sf,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 18 * sf,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionTypeCard(
      String type,
      BuildContext context,
      double sf, {
        bool isLast = false,
      }) {
    final color = _getTypeColor(type);
    final icon = _getTypeIcon(type);
    final description = _getTypeDescription(type);

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12 * sf),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          Get.to(() => AddQuestionDialog(
            phase: phase,
            questionType: _stringToQuestionType(type),
            scaleFactor: scaleFactor,
          ));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16 * sf),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12 * sf),
            border: Border.all(color: color.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 45 * sf,
                height: 45 * sf,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10 * sf),
                ),
                child: Icon(icon, color: color, size: 24 * sf),
              ),
              SizedBox(width: 12 * sf),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoldText(
                      text: type,
                      fontSize: 15 * sf,
                      selectionColor: AppColors.blackColor,
                    ),
                    SizedBox(height: 2 * sf),
                    MainText(
                      text: description,
                      fontSize: 11 * sf,
                      color: AppColors.languageTextColor,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16 * sf,
                color: AppColors.greyColor,
              ),
            ],
          ),
        ),
      ),
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

  String _getTypeDescription(String type) {
    switch (type.toUpperCase()) {
      case 'MCQ':
        return 'Multiple choice with single correct answer';
      case 'PUZZLE':
        return 'Sequence-based challenge questions';
      case 'OPEN_ENDED':
        return 'Free text response questions';
      case 'SIMULATION':
        return 'Scenario-based practical questions';
      default:
        return 'Custom question type';
    }
  }

  QuestionType _stringToQuestionType(String type) {
    switch (type.toUpperCase()) {
      case 'PUZZLE':
        return QuestionType.PUZZLE;
      case 'MCQ':
        return QuestionType.MCQ;
      case 'OPEN_ENDED':
        return QuestionType.OPEN_ENDED;
      case 'SIMULATION':
        return QuestionType.SIMULATION;
      default:
        return QuestionType.OPEN_ENDED;
    }
  }
}

void showQuestionTypeSelectionDialog(
    BuildContext context,
    dynamic phase, {
      required double scaleFactor,
    }) {
  showDialog(
    context: context,
    builder: (_) => QuestionTypeSelectionDialog(
      phase: phase,
      scaleFactor: scaleFactor,
    ),
  );
}








// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../api/api_models/questions_model.dart';
// import '../../constants/appcolors.dart';
// import 'add_question_dialogue.dart';
// import 'ai_question_dialogue.dart';
//
// class QuestionTypeSelectionDialog extends StatelessWidget {
//   final dynamic phase; // Note: Should ideally be PhaseModel, adjust if possible
//   final double scaleFactor;
//
//   const QuestionTypeSelectionDialog({
//     Key? key,
//     required this.phase,
//     required this.scaleFactor,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final questionTypes = List<String>.from(phase.challengeTypes);
//
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20 * scaleFactor)),
//       child: Container(
//         padding: EdgeInsets.all(24 * scaleFactor),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20 * scaleFactor),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.add_circle, color: AppColors.blueColor, size: 24 * scaleFactor),
//                 SizedBox(width: 12 * scaleFactor),
//                 Text(
//                   'Add Question to ${phase.name}',
//                   style: TextStyle(
//                     fontSize: 18 * scaleFactor,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.blackColor,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16 * scaleFactor),
//             Text(
//               'Select question type:',
//               style: TextStyle(
//                 fontSize: 14 * scaleFactor,
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.languageTextColor,
//               ),
//             ),
//             SizedBox(height: 16 * scaleFactor),
//             ...questionTypes.asMap().entries.map((entry) {
//               final type = entry.value;
//               return Column(
//                 children: [
//                   ListTile(
//                     leading: Container(
//                       width: 40 * scaleFactor,
//                       height: 40 * scaleFactor,
//                       decoration: BoxDecoration(
//                         color: AppColors.blueColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(10 * scaleFactor),
//                       ),
//                       child: _getTypeIcon(type),
//                     ),
//                     title: Text(
//                       type,
//                       style: TextStyle(
//                         fontSize: 15 * scaleFactor,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.blackColor,
//                       ),
//                     ),
//                     trailing: Icon(Icons.arrow_forward_ios, size: 16 * scaleFactor, color: AppColors.greyColor),
//                     onTap: () {
//                       Navigator.pop(context);
//                       Get.to(() => AddQuestionDialog(
//                         phase: phase,
//                         questionType: _stringToQuestionType(type),
//                         scaleFactor: scaleFactor,
//                       ));
//                     },
//                     contentPadding: EdgeInsets.symmetric(vertical: 4 * scaleFactor),
//                   ),
//                   if (entry.key < questionTypes.length - 1)
//                     Divider(height: 1, color: AppColors.borderColor),
//                 ],
//               );
//             }).toList(),
//             SizedBox(height: 16 * scaleFactor),
//             Container(
//               width: double.infinity,
//               child: OutlinedButton.icon(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   Get.to(() => AIQuestionDialog(phase: phase, scaleFactor: scaleFactor));
//                 },
//                 icon: Icon(Icons.auto_awesome, color: AppColors.blueColor, size: 18 * scaleFactor),
//                 label: Text(
//                   'Ask AI to Generate Questions',
//                   style: TextStyle(
//                     fontSize: 14 * scaleFactor,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.blueColor,
//                   ),
//                 ),
//                 style: OutlinedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 12 * scaleFactor),
//                   side: BorderSide(color: AppColors.blueColor),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scaleFactor)),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Icon _getTypeIcon(String type) {
//     switch (type.toUpperCase()) {
//       case 'PUZZLE':
//         return Icon(Icons.extension, color: AppColors.blueColor);
//       case 'MCQ':
//         return Icon(Icons.radio_button_checked, color: AppColors.blueColor);
//       case 'OPEN_ENDED':
//         return Icon(Icons.text_fields, color: AppColors.blueColor);
//       case 'SIMULATION':
//         return Icon(Icons.play_circle, color: AppColors.blueColor);
//       default:
//         return Icon(Icons.help, color: AppColors.blueColor);
//     }
//   }
//
//   QuestionType _stringToQuestionType(String type) {
//     switch (type.toUpperCase()) {
//       case 'PUZZLE':
//         return QuestionType.PUZZLE;
//       case 'MCQ':
//         return QuestionType.MCQ;
//       case 'OPEN_ENDED':
//         return QuestionType.OPEN_ENDED;
//       case 'SIMULATION':
//         return QuestionType.SIMULATION;
//       default:
//         return QuestionType.OPEN_ENDED; // Default fallback
//     }
//   }
// }
//
// void showQuestionTypeSelectionDialog(BuildContext context, dynamic phase, {required double scaleFactor}) {
//   showDialog(
//     context: context,
//     builder: (_) => QuestionTypeSelectionDialog(phase: phase, scaleFactor: scaleFactor),
//   );
// }