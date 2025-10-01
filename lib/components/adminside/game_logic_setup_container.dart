import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/use_able_game_row.dart';

class GameLogicSetupContainer extends StatelessWidget {
  const GameLogicSetupContainer({
    super.key,
    required this.scaleFactor,
  });

  final double scaleFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 336 * scaleFactor,
      height: 256 * scaleFactor,
      decoration: BoxDecoration(
        border: Border.all(
            color: AppColors.greyColor, width: 1.5 * scaleFactor),
        borderRadius: BorderRadius.circular(24 * scaleFactor),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15 * scaleFactor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 28 * scaleFactor),
            BoldText(
                text: "game_logic_setup".tr,
                fontSize: 16 * scaleFactor,
                selectionColor: AppColors.blueColor),
            SizedBox(height: 19 * scaleFactor),
            UseAbleGameRow(
              text1: 'Phase 1 - Strategy',
              text2: '3 Stage - 1h 12 minutes',
            ),
            SizedBox(height: 12 * scaleFactor),
            UseAbleGameRow(
              text1: 'Phase 2 - Strategy',
              text2: '3 Stage - 1h 12 minutes',
            ),
            SizedBox(height: 12 * scaleFactor),
            UseAbleGameRow(
              text1: 'Phase 3 - Strategy',
              text2: '3 Stage - 1h 12 minutes',
            ),
          ],
        ),
      ),
    );
  }
}

// Fixed StatefulWidget version of GameRow
class GameRow extends StatefulWidget {
  final String? text;
  final double screenHeight;
  final double screenWidth;
  final double scaleFactor;
  final bool? initialValue; // Allow setting initial value
  final Function(bool)? onToggle; // Callback to parent

  const GameRow({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    this.text,
    required this.scaleFactor,
    this.initialValue = false, // Default to false
    this.onToggle,
  });

  @override
  State<GameRow> createState() => _GameRowState();
}

class _GameRowState extends State<GameRow> {
  bool switchValue = false;

  @override
  void initState() {
    super.initState();
    switchValue = widget.initialValue ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MainText(
          text: widget.text ?? "enable_leaderboard".tr,
          fontSize: 14 * widget.scaleFactor,
        ),
        FlutterSwitch(
          value: switchValue,
          onToggle: (val) {
            setState(() {
              switchValue = val;
            });
            // Call parent callback if provided
            if (widget.onToggle != null) {
              widget.onToggle!(val);
            }
          },
          height: widget.screenHeight * 0.03,
          width: widget.screenWidth * 0.13,
          activeColor: AppColors.forwardColor,
          inactiveColor: Colors.grey,
        )
      ],
    );
  }
}