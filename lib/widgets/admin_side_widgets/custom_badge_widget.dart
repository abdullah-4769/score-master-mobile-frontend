import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/appcolors.dart';
import '../../constants/appimages.dart';

// Badge types
enum BadgeType { gold, silver, bronze }

class BadgeWidget extends StatefulWidget {
  final double scaleFactor;

  /// Callback to notify parent of changes
  final Function(BadgeType badge, String score) onChanged;

  const BadgeWidget({
    super.key,
    this.scaleFactor = 1.0,
    required this.onChanged,
  });

  @override
  State<BadgeWidget> createState() => _BadgeWidgetState();
}

class _BadgeWidgetState extends State<BadgeWidget> {
  BadgeType selectedBadge = BadgeType.gold;
  final TextEditingController scoreController = TextEditingController();

  // Badge score mapping
  final Map<BadgeType, String> badgeScores = {
    BadgeType.gold: "90+",
    BadgeType.silver: "80-89",
    BadgeType.bronze: "70-79",
  };

  @override
  void initState() {
    super.initState();
    scoreController.text = badgeScores[selectedBadge]!;
    _notifyParent();
  }

  void updateScore(BadgeType badge) {
    setState(() {
      selectedBadge = badge;
      scoreController.text = badgeScores[badge]!;
    });
    _notifyParent();
  }

  void _notifyParent() {
    widget.onChanged(selectedBadge, scoreController.text);
  }

  @override
  Widget build(BuildContext context) {
    final scale = widget.scaleFactor;

    return Column(
      children: [
        // Badge Title
        Center(
          child: Text(
            "badge_labeling",
            style: TextStyle(
              fontSize: 16 * scale,
              fontWeight: FontWeight.bold,
              color: AppColors.blueColor,
            ),
          ),
        ),
        SizedBox(height: 16 * scale),

        // Badge Image
        Center(
          child: Image.asset(
            Appimages.badge,
            width: 129 * scale,
            height: 120 * scale,
          ),
        ),
        SizedBox(height: 11 * scale),

        // Badge Name Dropdown
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.forwardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Badge Name", style: TextStyle(fontSize: 16.sp)),
              DropdownButton<BadgeType>(
                value: selectedBadge,
                underline: SizedBox(),
                items: BadgeType.values.map((badge) {
                  return DropdownMenuItem(
                    value: badge,
                    child: Text(
                      badge.name.toUpperCase(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  );
                }).toList(),
                onChanged: (badge) {
                  if (badge != null) updateScore(badge);
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 8 * scale),

        // Required Score (Editable)
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.forwardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Required Score", style: TextStyle(fontSize: 16.sp)),
              SizedBox(
                width: 80,
                child: TextField(
                  controller: scoreController,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.sp),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    _notifyParent();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
