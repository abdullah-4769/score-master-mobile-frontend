import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/useable_container.dart';

import '../../api/api_models/show_all_game_model.dart';

class GameUseAbleContainer extends StatelessWidget {
  final double widthScaleFactor;
  final double heightScaleFactor;
  final GameModel game;
  final VoidCallback? onTap;

  const GameUseAbleContainer({
    super.key,
    required this.widthScaleFactor,
    required this.heightScaleFactor,
    required this.game,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Debug print when building each container to verify time value at UI level
    print("🎨 Building GameUseAbleContainer for '${game.displayName}' → timeDuration: ${game.timeDuration} | Formatted: ${_formatTimeDuration(game.timeDuration)} | Is Empty: ${game.isEmpty} | Phases: ${game.totalPhases}");

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 184 * heightScaleFactor,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.greyColor,
            width: 1.5 * widthScaleFactor,
          ),
          borderRadius: BorderRadius.circular(12 * widthScaleFactor),
          color: AppColors.forwardColor.withOpacity(0.1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 10 * heightScaleFactor,
              left: -20 * widthScaleFactor,
              child: Image.asset(
                Appimages.game,
                width: 55 * widthScaleFactor,
                height: 55 * heightScaleFactor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 40 * widthScaleFactor,
                right: 20 * widthScaleFactor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 17 * heightScaleFactor),

                  // Game Name
                  MainText(
                    text: game.displayName,
                    fontSize: 14 * widthScaleFactor,
                    fontWeight: FontWeight.w600,
                  ),

                  SizedBox(height: 5 * heightScaleFactor),

                  // Game Description
                  MainText(
                    text: game.displayDescription,
                    fontSize: 12 * widthScaleFactor,
                    height: 1.3,
                    color: AppColors.teamColor,
                    // maxLines: 2,
                    // overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 8 * heightScaleFactor),

                  // Status badges
                  Row(
                    children: [
                      UseableContainer(
                        fontSize: 9,
                        height: 26,
                        text: game.scoringTypeDisplay,
                        color: _getScoringTypeColor(game.scoringType),
                        width: 75 * widthScaleFactor,
                      ),
                      SizedBox(width: 7 * widthScaleFactor),
                      UseableContainer(
                        fontSize: 9,
                        text: game.statusText,
                        height: 26,
                        color: game.isActive ? AppColors.forwardColor : Colors.grey,
                      ),
                      SizedBox(width: 7 * widthScaleFactor),
                      UseableContainer(
                        fontSize: 9,
                        text: game.modeDisplayText,
                        height: 26,
                        color: game.mode == 'team' ? AppColors.blueColor : AppColors.orangeColor,
                      ),
                    ],
                  ),

                  SizedBox(height: 18 * heightScaleFactor),

                  // Game stats
                  Row(
                    children: [
                      // Phases count
                      Row(
                        children: [
                          Image.asset(
                            Appimages.player2,
                            height: 28 * heightScaleFactor,
                            width: 26 * widthScaleFactor,
                          ),
                          MainText(
                            text: "${game.totalPhases} Phases",
                            fontSize: 12 * widthScaleFactor,
                          ),
                        ],
                      ),
                      SizedBox(width: 9 * widthScaleFactor),

                      // Time duration indicator (replaced mode text with time from backend)
                      Row(
                        children: [
                          Image.asset(
                            Appimages.timeout2,
                            height: 28 * heightScaleFactor,
                            width: 26 * widthScaleFactor,
                          ),
                          SizedBox(width: 6 * widthScaleFactor),
                          MainText(
                            text: _formatTimeDuration(game.timeDuration),
                            fontSize: 12 * widthScaleFactor,
                            color: AppColors.redColor, // You can adjust color as needed
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),

            // Active status indicator
            if (game.isActive)
              Positioned(
                top: 12 * heightScaleFactor,
                right: 12 * widthScaleFactor,
                child: Container(
                  width: 8 * widthScaleFactor,
                  height: 8 * widthScaleFactor,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Helper method to format the time duration from backend (assumes minutes)
  String _formatTimeDuration(int durationInMinutes) {
    final formatted = durationInMinutes <= 0 ? 'No time limit' : '${durationInMinutes} min';
    print("⏱️ _formatTimeDuration DEBUG → Input: $durationInMinutes → Output: $formatted");
    return formatted;
  }

  Color _getScoringTypeColor(String scoringType) {
    switch (scoringType) {
      case 'AUTOMATIC':
        return AppColors.orangeColor;
      case 'AI':
        return AppColors.orangeColor;
      case 'MANUAL':
        return AppColors.blueColor;
      case 'HYBRID':
        return AppColors.forwardColor;
      default:
        return AppColors.greyColor;
    }
  }
}