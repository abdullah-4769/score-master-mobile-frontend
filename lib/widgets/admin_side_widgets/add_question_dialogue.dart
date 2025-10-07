import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/api/api_models/questions_model.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/login_textfield.dart';
import 'package:scorer/widgets/login_button.dart';

class AddQuestionDialog extends StatefulWidget {
  final dynamic phase;
  final QuestionType questionType;
  final double scaleFactor;

  const AddQuestionDialog({
    Key? key,
    required this.phase,
    required this.questionType,
    required this.scaleFactor,
  }) : super(key: key);

  @override
  State<AddQuestionDialog> createState() => _AddQuestionDialogState();
}

class _AddQuestionDialogState extends State<AddQuestionDialog> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _scenarioController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController(text: '10');
  final List<TextEditingController> _optionsControllers = [];
  int _selectedCorrectOption = 0;
  bool _showPreview = false;

  @override
  void initState() {
    super.initState();
    if (widget.questionType == QuestionType.MCQ || widget.questionType == QuestionType.PUZZLE) {
      for (int i = 0; i < 4; i++) {
        _optionsControllers.add(TextEditingController());
      }
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    _scenarioController.dispose();
    _pointsController.dispose();
    for (final c in _optionsControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sf = widget.scaleFactor;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20 * sf, vertical: 24 * sf),
      child: Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20 * sf),
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
            _buildHeader(sf),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24 * sf),
                child: _showPreview ? _buildPreview(sf) : _buildForm(sf),
              ),
            ),
            _buildFooter(sf),
          ],
        ),
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
              _getTypeIcon(),
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
                  'Add ${widget.questionType.name} Question',
                  style: TextStyle(
                    fontSize: 18 * sf,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4 * sf),
                Text(
                  'Phase: ${widget.phase.name}',
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

  Widget _buildForm(double sf) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Points Field
        BoldText(
          text: 'Points',
          fontSize: 14 * sf,
          selectionColor: AppColors.blackColor,
        ),
        SizedBox(height: 8 * sf),
        LoginTextfield(
          text: 'Enter points (e.g., 10)',
          fontsize: 14 * sf,
          ishow: true,
          controller: _pointsController,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16 * sf),

        // Scenario Field (for Puzzle and Simulation)
        if (widget.questionType == QuestionType.PUZZLE ||
            widget.questionType == QuestionType.SIMULATION) ...[
          BoldText(
            text: 'Scenario (Optional)',
            fontSize: 14 * sf,
            selectionColor: AppColors.blackColor,
          ),
          SizedBox(height: 8 * sf),
          LoginTextfield(
            text: 'Enter scenario context...',
            fontsize: 14 * sf,
            ishow: true,
            height: 100 * sf,
            controller: _scenarioController,
          ),
          SizedBox(height: 16 * sf),
        ],

        // Question Field
        BoldText(
          text: 'Question',
          fontSize: 14 * sf,
          selectionColor: AppColors.blackColor,
        ),
        SizedBox(height: 8 * sf),
        LoginTextfield(
          text: 'Enter your question...',
          fontsize: 14 * sf,
          ishow: true,
          height: 100 * sf,
          controller: _questionController,
        ),
        SizedBox(height: 16 * sf),

        // Type-specific fields
        if (widget.questionType == QuestionType.MCQ) _buildMcqFields(sf),
        if (widget.questionType == QuestionType.PUZZLE) _buildPuzzleFields(sf),

        SizedBox(height: 20 * sf),

        // Preview Button
        Center(
          child: LoginButton(
            text: 'Preview Question',
            fontSize: 16 * sf,
            color: AppColors.forwardColor,
            onTap: () {
              if (_questionController.text.isEmpty) {
                Get.snackbar('Error', 'Please enter a question',
                    backgroundColor: Colors.red, colorText: Colors.white);
                return;
              }
              setState(() => _showPreview = true);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMcqFields(double sf) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BoldText(
          text: 'Options',
          fontSize: 14 * sf,
          selectionColor: AppColors.blackColor,
        ),
        SizedBox(height: 8 * sf),
        ..._optionsControllers.asMap().entries.map((entry) {
          final index = entry.key;
          final controller = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: 12 * sf),
            child: Row(
              children: [
                Radio<int>(
                  value: index,
                  groupValue: _selectedCorrectOption,
                  onChanged: (val) => setState(() => _selectedCorrectOption = val!),
                  activeColor: AppColors.blueColor,
                ),
                Expanded(
                  child: LoginTextfield(
                    text: 'Option ${index + 1}',
                    fontsize: 14 * sf,
                    ishow: true,
                    controller: controller,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        MainText(
          text: 'Select the correct option using radio buttons',
          fontSize: 12 * sf,
          color: AppColors.teamColor,
        ),
      ],
    );
  }

  Widget _buildPuzzleFields(double sf) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BoldText(
          text: 'Sequence Options',
          fontSize: 14 * sf,
          selectionColor: AppColors.blackColor,
        ),
        SizedBox(height: 8 * sf),
        MainText(
          text: 'Enter options in the correct order',
          fontSize: 12 * sf,
          color: AppColors.teamColor,
        ),
        SizedBox(height: 8 * sf),
        ..._optionsControllers.asMap().entries.map((entry) {
          final index = entry.key;
          final controller = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: 12 * sf),
            child: Row(
              children: [
                Container(
                  width: 30 * sf,
                  height: 30 * sf,
                  decoration: BoxDecoration(
                    color: AppColors.forwardColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: BoldText(
                      text: '${index + 1}',
                      fontSize: 14 * sf,
                      selectionColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 12 * sf),
                Expanded(
                  child: LoginTextfield(
                    text: 'Step ${index + 1}',
                    fontsize: 14 * sf,
                    ishow: true,
                    controller: controller,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildPreview(double sf) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.preview, color: AppColors.blueColor, size: 20 * sf),
            SizedBox(width: 8 * sf),
            BoldText(
              text: 'Preview',
              fontSize: 16 * sf,
              selectionColor: AppColors.blueColor,
            ),
          ],
        ),
        SizedBox(height: 16 * sf),
        _buildQuestionPreview(sf),
        SizedBox(height: 20 * sf),
        Center(
          child: LoginButton(
            text: 'Edit Question',
            fontSize: 16 * sf,
            color: AppColors.forwardColor,
            onTap: () => setState(() => _showPreview = false),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionPreview(double sf) {
    final options = _optionsControllers.map((c) => c.text).toList();

    return Container(
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
                  color: _getTypeColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4 * sf),
                ),
                child: MainText(
                  text: widget.questionType.name.toUpperCase(),
                  fontSize: 10 * sf,
                  color: _getTypeColor(),
                ),
              ),
              SizedBox(width: 8 * sf),
              MainText(
                text: '${_pointsController.text} points',
                fontSize: 10 * sf,
                color: AppColors.teamColor,
              ),
            ],
          ),
          SizedBox(height: 12 * sf),

          if (_scenarioController.text.isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12 * sf),
              decoration: BoxDecoration(
                color: AppColors.forwardColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8 * sf),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: MainText(
                text: _scenarioController.text,
                fontSize: 12 * sf,
                color: AppColors.blackColor,
              ),
            ),
            SizedBox(height: 12 * sf),
          ],

          BoldText(
            text: _questionController.text,
            selectionColor: AppColors.redColor,
            fontSize: 16 * sf,
          ),

          if (widget.questionType == QuestionType.MCQ ||
              widget.questionType == QuestionType.PUZZLE) ...[
            SizedBox(height: 12 * sf),
            ...options.asMap().entries.map((entry) {
              if (entry.value.isEmpty) return SizedBox.shrink();
              return Padding(
                padding: EdgeInsets.only(bottom: 8 * sf),
                child: Row(
                  children: [
                    if (widget.questionType == QuestionType.PUZZLE)
                      Container(
                        width: 24 * sf,
                        height: 24 * sf,
                        margin: EdgeInsets.only(right: 8 * sf),
                        decoration: BoxDecoration(
                          color: AppColors.forwardColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${entry.key + 1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12 * sf,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12 * sf),
                        decoration: BoxDecoration(
                          color: entry.key == _selectedCorrectOption &&
                              widget.questionType == QuestionType.MCQ
                              ? AppColors.blueColor.withOpacity(0.1)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8 * sf),
                          border: Border.all(
                            color: entry.key == _selectedCorrectOption &&
                                widget.questionType == QuestionType.MCQ
                                ? AppColors.blueColor
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: MainText(
                          text: entry.value,
                          fontSize: 13 * sf,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildFooter(double sf) {
    return Container(
      padding: EdgeInsets.all(20 * sf),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20 * sf),
          bottomRight: Radius.circular(20 * sf),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: LoginButton(
              text: 'Cancel',
              fontSize: 16 * sf,
              color: AppColors.greyColor,
              onTap: () => Navigator.pop(context),
            ),
          ),
          SizedBox(width: 12 * sf),
          Expanded(
            child: LoginButton(
              text: 'Save Question',
              fontSize: 16 * sf,
              color: AppColors.blueColor,
              onTap: _onSave,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getTypeIcon() {
    switch (widget.questionType) {
      case QuestionType.PUZZLE:
        return Icons.extension;
      case QuestionType.MCQ:
        return Icons.radio_button_checked;
      case QuestionType.OPEN_ENDED:
        return Icons.text_fields;
      case QuestionType.SIMULATION:
        return Icons.play_circle;
      default:
        return Icons.help;
    }
  }

  Color _getTypeColor() {
    switch (widget.questionType) {
      case QuestionType.MCQ:
        return AppColors.blueColor;
      case QuestionType.PUZZLE:
        return AppColors.orangeColor;
      case QuestionType.OPEN_ENDED:
        return AppColors.forwardColor;
      case QuestionType.SIMULATION:
        return AppColors.redColor;
      default:
        return AppColors.blueColor;
    }
  }

  void _onSave() {
    if (_questionController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Question cannot be empty',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final points = int.tryParse(_pointsController.text) ?? 10;

    Navigator.pop(context, {
      'type': widget.questionType,
      'question': _questionController.text,
      'scenario': _scenarioController.text,
      'points': points,
      'options': _optionsControllers.map((c) => c.text).toList(),
      'correctOption': _selectedCorrectOption,
    });
  }
}









// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../api/api_models/questions_model.dart';
// import '../../constants/appcolors.dart';
//
// class AddQuestionDialog extends StatefulWidget {
//   final dynamic phase;
//   final QuestionType questionType;
//   final double scaleFactor;
//
//   const AddQuestionDialog({
//     Key? key,
//     required this.phase,
//     required this.questionType,
//     required this.scaleFactor,
//   }) : super(key: key);
//
//   @override
//   State<AddQuestionDialog> createState() => _AddQuestionDialogState();
// }
//
// class _AddQuestionDialogState extends State<AddQuestionDialog> {
//   final TextEditingController _questionController = TextEditingController();
//   final List<TextEditingController> _optionsControllers = [];
//   int? _selectedCorrectOption;
//   int? _puzzleLevel;
//   int? _simulationStep;
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.questionType == QuestionType.MCQ) {
//       // initialize with 4 options
//       for (int i = 0; i < 4; i++) {
//         _optionsControllers.add(TextEditingController());
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     _questionController.dispose();
//     for (final c in _optionsControllers) {
//       c.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final sf = widget.scaleFactor;
//
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20 * sf),
//       ),
//       child: Container(
//         padding: EdgeInsets.all(24 * sf),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20 * sf),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               /// Title
//               Row(
//                 children: [
//                   Icon(Icons.help, color: AppColors.blueColor, size: 24 * sf),
//                   SizedBox(width: 12 * sf),
//                   Text(
//                     'Add ${widget.questionType.name} Question',
//                     style: TextStyle(
//                       fontSize: 18 * sf,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.blackColor,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16 * sf),
//
//               /// Question Field
//               TextField(
//                 controller: _questionController,
//                 decoration: InputDecoration(
//                   labelText: 'Question',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12 * sf),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16 * sf),
//
//               if (widget.questionType == QuestionType.MCQ) _buildMcqSection(sf),
//               if (widget.questionType == QuestionType.PUZZLE) _buildPuzzleSection(sf),
//               if (widget.questionType == QuestionType.SIMULATION) _buildSimulationSection(sf),
//
//               SizedBox(height: 24 * sf),
//
//               /// Buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: Text(
//                       'Cancel',
//                       style: TextStyle(
//                         fontSize: 14 * sf,
//                         color: AppColors.greyColor,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 12 * sf),
//                   ElevatedButton(
//                     onPressed: _onSave,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.blueColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12 * sf),
//                       ),
//                     ),
//                     child: Text(
//                       'Save',
//                       style: TextStyle(fontSize: 14 * sf, color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMcqSection(double sf) {
//     return Column(
//       children: [
//         ..._optionsControllers.asMap().entries.map((entry) {
//           final index = entry.key;
//           final controller = entry.value;
//           return Padding(
//             padding: EdgeInsets.only(bottom: 12 * sf),
//             child: TextField(
//               controller: controller,
//               decoration: InputDecoration(
//                 labelText: 'Option ${index + 1}',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12 * sf),
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//         DropdownButtonFormField<int>(
//           value: _selectedCorrectOption ?? 0, // ✅ FIX: int? → int
//           items: List.generate(
//             _optionsControllers.length,
//                 (i) => DropdownMenuItem(
//               value: i,
//               child: Text('Option ${i + 1}'),
//             ),
//           ),
//           onChanged: (val) => setState(() => _selectedCorrectOption = val),
//           decoration: InputDecoration(
//             labelText: 'Correct Option',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12 * sf),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPuzzleSection(double sf) {
//     return Column(
//       children: [
//         DropdownButtonFormField<int>(
//           value: _puzzleLevel ?? 0, // ✅ FIX: int? → int
//           items: List.generate(
//             5,
//                 (i) => DropdownMenuItem(
//               value: i,
//               child: Text('Level ${i + 1}'),
//             ),
//           ),
//           onChanged: (val) => setState(() => _puzzleLevel = val),
//           decoration: InputDecoration(
//             labelText: 'Puzzle Level',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12 * sf),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSimulationSection(double sf) {
//     return Column(
//       children: [
//         DropdownButtonFormField<int>(
//           value: _simulationStep ?? 0, // ✅ FIX: int? → int
//           items: List.generate(
//             10,
//                 (i) => DropdownMenuItem(
//               value: i,
//               child: Text('Step ${i + 1}'),
//             ),
//           ),
//           onChanged: (val) => setState(() => _simulationStep = val),
//           decoration: InputDecoration(
//             labelText: 'Simulation Step',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12 * sf),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   void _onSave() {
//     final questionText = _questionController.text.trim();
//     if (questionText.isEmpty) {
//       Get.snackbar('Error', 'Question cannot be empty',
//           snackPosition: SnackPosition.BOTTOM);
//       return;
//     }
//
//     // Save logic here (call API or pass back to parent)
//     Navigator.pop(context, {
//       'type': widget.questionType,
//       'question': questionText,
//       'options': _optionsControllers.map((c) => c.text).toList(),
//       'correct': _selectedCorrectOption ?? 0,
//       'puzzleLevel': _puzzleLevel ?? 0,
//       'simulationStep': _simulationStep ?? 0,
//     });
//   }
// }
