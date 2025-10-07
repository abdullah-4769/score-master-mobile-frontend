// components/question_list.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../constants/appcolors.dart';
import '../../api/api_models/questions_model.dart';

class QuestionList extends StatelessWidget {
  final List<Question> questions;
  final double scaleFactor;
  final List<String> questionType;

  const QuestionList({
    Key? key,
    required this.questions,
    required this.scaleFactor,
    required this.questionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) return Container();

    final Map<QuestionType, List<Question>> groupedQuestions = {};
    for (var q in questions) {
      groupedQuestions.putIfAbsent(q.type, () => []).add(q);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: groupedQuestions.entries.map((entry) {
        return _buildQuestionGroup(entry.key, entry.value);
      }).toList(),
    );
  }

  Widget _buildQuestionGroup(QuestionType type, List<Question> questions) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8 * scaleFactor, vertical: 8 * scaleFactor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12 * scaleFactor, vertical: 8 * scaleFactor),
            decoration: BoxDecoration(
              color: AppColors.blueColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8 * scaleFactor),
            ),
            child: Row(
              children: [
                Icon(
                  _getTypeIcon(type.toString().split('.').last).icon,
                  color: AppColors.blueColor,
                  size: 18 * scaleFactor,
                ),
                SizedBox(width: 8 * scaleFactor),
                Text(
                  "${type.toString().split('.').last} Questions (${questions.length})",
                  style: TextStyle(
                    fontSize: 15 * scaleFactor,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blueColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12 * scaleFactor),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: questions.length,
            separatorBuilder: (context, index) => Divider(
              height: 16 * scaleFactor,
              color: AppColors.borderColor.withOpacity(0.3),
            ),
            itemBuilder: (context, index) => _buildQuestionCard(questions[index], index),
          ),
          SizedBox(height: 16 * scaleFactor),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(Question question, int index) {
    return Container(
      padding: EdgeInsets.all(16 * scaleFactor),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12 * scaleFactor),
        border: Border.all(color: AppColors.borderColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40 * scaleFactor,
            height: 40 * scaleFactor,
            decoration: BoxDecoration(
              color: AppColors.blueColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8 * scaleFactor),
            ),
            child: Icon(
              _getTypeIcon(question.type.toString().split('.').last).icon,
              color: AppColors.blueColor,
              size: 20 * scaleFactor,
            ),
          ),
          SizedBox(width: 12 * scaleFactor),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Q${question.order}: ${question.questionText}",
                  style: TextStyle(
                    fontSize: 14 * scaleFactor,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 8 * scaleFactor),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8 * scaleFactor, vertical: 4 * scaleFactor),
                      decoration: BoxDecoration(
                        color: AppColors.forwardColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4 * scaleFactor),
                      ),
                      child: Text(
                        "${question.point} points",
                        style: TextStyle(
                          fontSize: 11 * scaleFactor,
                          color: AppColors.blueColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (question.scenario.isNotEmpty) ...[
                      SizedBox(width: 8 * scaleFactor),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8 * scaleFactor, vertical: 4 * scaleFactor),
                        decoration: BoxDecoration(
                          color: AppColors.forwardColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(4 * scaleFactor),
                        ),
                        child: Text(
                          "Scenario",
                          style: TextStyle(
                            fontSize: 11 * scaleFactor,
                            color: AppColors.languageTextColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.snackbar(
                'Edit Question',
                'Editing question: ${question.questionText}',
                backgroundColor: AppColors.blueColor,
                colorText: Colors.white,
              );
            },
            child: Container(
              padding: EdgeInsets.all(6 * scaleFactor),
              decoration: BoxDecoration(
                color: AppColors.forwardColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6 * scaleFactor),
              ),
              child: Icon(Icons.edit, color: AppColors.blueColor, size: 16 * scaleFactor),
            ),
          ),
        ],
      ),
    );
  }

  Icon _getTypeIcon(String type) {
    switch (type.toUpperCase()) {
      case 'PUZZLE':
        return Icon(Icons.extension, color: AppColors.blueColor);
      case 'MCQ':
        return Icon(Icons.radio_button_checked, color: AppColors.blueColor);
      case 'OPEN_ENDED':
        return Icon(Icons.text_fields, color: AppColors.blueColor);
      case 'SIMULATION':
        return Icon(Icons.play_circle, color: AppColors.blueColor);
      default:
        return Icon(Icons.help, color: AppColors.blueColor);
    }
  }
}