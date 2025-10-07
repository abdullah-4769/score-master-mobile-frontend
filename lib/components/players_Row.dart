// lib/components/players_Row.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';

class PlayersRow extends StatelessWidget {
  final bool isTeamSelected;
  final List<Map<String, dynamic>> topThree;

  const PlayersRow({
    super.key,
    required this.isTeamSelected,
    required this.topThree,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Defensive defaults if fewer than 3 items provided
    final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(
      topThree.length >= 3
          ? topThree
          : List.generate(3, (i) => {
        "rank": i + 1,
        "name": "",
        "points": 0,
      }),
    );

    // Pick by rank so we always show 1st in center, 2nd left, 3rd right
    Map<String, dynamic> first = data.firstWhere((d) => d["rank"] == 1,
        orElse: () => data.length > 0 ? data[0] : {"rank": 1, "name": "", "points": 0});
    Map<String, dynamic> second = data.firstWhere((d) => d["rank"] == 2,
        orElse: () => data.length > 1 ? data[1] : {"rank": 2, "name": "", "points": 0});
    Map<String, dynamic> third = data.firstWhere((d) => d["rank"] == 3,
        orElse: () => data.length > 2 ? data[2] : {"rank": 3, "name": "", "points": 0});

    final ordered = [second, first, third]; // left, center, right

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(3, (i) {
        final player = ordered[i];
        final isCenter = i == 1;

        // Responsive sizes
        final avatarSize = isCenter ? screenWidth * 0.28 : screenWidth * 0.18;
        final rankCircleSize = avatarSize * 0.28;

        return Expanded(
          flex: isCenter ? 12 : 10, // center slightly wider
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              // Avatar + crown + rank indicator
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: avatarSize,
                    width: avatarSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(Appimages.bg), // placeholder avatar
                        fit: BoxFit.cover,
                      ),
                      border: isCenter
                          ? null
                          : Border.all(color: AppColors.newggrey, width: 4),
                    ),
                  ),

                  // rank circle positioned overlapping bottom of avatar
                  Positioned(
                    bottom: -rankCircleSize * 0.55,
                    left: (avatarSize / 2) - (rankCircleSize / 2),
                    child: Container(
                      height: rankCircleSize,
                      width: rankCircleSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCenter ? AppColors.yellowColor : AppColors.orangeColor,
                        border: Border.all(color: AppColors.newborder, width: 3),
                      ),
                      child: Center(
                        child: Text(
                          "${player["rank"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.blueColor,
                            fontSize: rankCircleSize * 0.55,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // crown for center player
                  if (isCenter)
                    Positioned(
                      top: -avatarSize * 0.48,
                      child: SvgPicture.asset(
                        Appimages.Crown,
                        height: avatarSize * 0.38,
                      ),
                    ),
                ],
              ),

              SizedBox(height: avatarSize * 0.12),

              // Name (constrained, no overflow)
              LayoutBuilder(builder: (context, constraints) {
                // name area uses most of slot width but stays responsive
                final nameWidth = constraints.maxWidth * 0.9;
                return SizedBox(
                  width: nameWidth,
                  child: Text(
                    player["name"] ?? "",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // prevents overflow
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isCenter ? 16 : 14,
                      color: AppColors.blueColor,
                    ),
                  ),
                );
              }),

              const SizedBox(height: 6),

              // Points
              Text(
                "${player["points"] ?? 0} pts",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: isCenter ? 15 : 13,
                  color: AppColors.forwardColor,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}







// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:scorer/constants/appcolors.dart';
// import 'package:scorer/constants/appimages.dart';
// import 'package:scorer/widgets/bold_text.dart';
// import 'package:scorer/widgets/main_text.dart';
//
// class PlayersRow extends StatelessWidget {
//   final bool isTeamSelected;
//   final List<Map<String, dynamic>> topThree;
//
//   const PlayersRow({
//     super.key,
//     required this.isTeamSelected,
//     required this.topThree,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // Defensive: Ensure we have exactly 3 items
//     final data = topThree.length >= 3
//         ? topThree
//         : List.generate(3, (i) => {"name": "", "points": 0, "rank": i + 1});
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: List.generate(3, (i) {
//         final player = data[i];
//         final isCenter = i == 1;
//
//         return Column(
//           children: [
//             Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Container(
//                   height: isCenter ? 125 : 80,
//                   width: isCenter ? 125 : 80,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       image: AssetImage(Appimages.bg), // placeholder image
//                       fit: BoxFit.cover,
//                     ),
//                     border: isCenter
//                         ? null
//                         : Border.all(color: AppColors.newggrey, width: 5),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: -18,
//                   left: isCenter ? 48 : 25,
//                   child: Container(
//                     height: 30,
//                     width: 30,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: isCenter
//                           ? AppColors.yellowColor
//                           : AppColors.orangeColor,
//                       border: Border.all(
//                         color: AppColors.newborder,
//                         width: 3,
//                       ),
//                     ),
//                     child: Center(
//                         child:
//                         MainText(text: "${player["rank"]}", fontSize: 14)),
//                   ),
//                 ),
//                 if (isCenter)
//                   Positioned(
//                     top: -75,
//                     left: 15,
//                     child: SvgPicture.asset(Appimages.Crown),
//                   ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             BoldText(
//               text: player["name"],
//               selectionColor: AppColors.blueColor,
//               fontSize: 16,
//             ),
//             BoldText(
//               text: "${player["points"]} pts",
//               selectionColor: AppColors.forwardColor,
//               fontSize: 18,
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
//
//
//
