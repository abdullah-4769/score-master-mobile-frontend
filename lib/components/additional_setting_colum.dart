import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';

import '../api/api_controllers/create_game_format_controller.dart';

class AdditionalSettingColumn extends StatelessWidget {
  final double scaleFactor;
  final double widthScaleFactor;
  final Function(bool) onAllowLaterJoinChanged;
  final Function(bool) onSendInvitationChanged;
  final Function(bool) onRecordSessionChanged;

  const AdditionalSettingColumn({
    Key? key,
    required this.scaleFactor,
    required this.widthScaleFactor,
    required this.onAllowLaterJoinChanged,
    required this.onSendInvitationChanged,
    required this.onRecordSessionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateGameFormatController>();

    return Column(
      children: [
        // Allow Later Join
        Container(
          height: 76 * scaleFactor,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.greyColor, width: 1.5 * scaleFactor),
            borderRadius: BorderRadius.circular(24 * scaleFactor),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10 * scaleFactor),
            child: Row(
              children: [
                Icon(Icons.person_add, size: 30 * scaleFactor, color: AppColors.forwardColor),
                SizedBox(width: 10 * scaleFactor),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "allow_later_join".tr,
                      style: TextStyle(fontSize: 14 * scaleFactor, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "enable_late_participation".tr,
                      style: TextStyle(
                        fontSize: 11 * scaleFactor,
                        color: AppColors.teamColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Obx(() => FlutterSwitch(
                  value: controller.allowLaterJoin.value,
                  onToggle: onAllowLaterJoinChanged,
                  height: 26 * scaleFactor,
                  width: 40 * scaleFactor,
                  activeColor: AppColors.forwardColor,
                  inactiveColor: AppColors.greyColor,
                )),
              ],
            ),
          ),
        ),
        SizedBox(height: 10 * scaleFactor),
        // Send Invitation
        Container(
          height: 76 * scaleFactor,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.greyColor, width: 1.5 * scaleFactor),
            borderRadius: BorderRadius.circular(24 * scaleFactor),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10 * scaleFactor),
            child: Row(
              children: [
                Icon(Icons.email, size: 30 * scaleFactor, color: AppColors.forwardColor),
                SizedBox(width: 10 * scaleFactor),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "send_invitation".tr,
                      style: TextStyle(fontSize: 14 * scaleFactor, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "send_auto_invitations".tr,
                      style: TextStyle(
                        fontSize: 11 * scaleFactor,
                        color: AppColors.teamColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Obx(() => FlutterSwitch(
                  value: controller.sendInvitation.value,
                  onToggle: onSendInvitationChanged,
                  height: 26 * scaleFactor,
                  width: 40 * scaleFactor,
                  activeColor: AppColors.forwardColor,
                  inactiveColor: AppColors.greyColor,
                )),
              ],
            ),
          ),
        ),
        SizedBox(height: 10 * scaleFactor),
        // Record Session
        Container(
          height: 76 * scaleFactor,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.greyColor, width: 1.5 * scaleFactor),
            borderRadius: BorderRadius.circular(24 * scaleFactor),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10 * scaleFactor),
            child: Row(
              children: [
                Icon(Icons.videocam, size: 30 * scaleFactor, color: AppColors.forwardColor),
                SizedBox(width: 10 * scaleFactor),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "record_session".tr,
                      style: TextStyle(fontSize: 14 * scaleFactor, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "record_session_for_review".tr,
                      style: TextStyle(
                        fontSize: 11 * scaleFactor,
                        color: AppColors.teamColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Obx(() => FlutterSwitch(
                  value: controller.recordSession.value,
                  onToggle: onRecordSessionChanged,
                  height: 26 * scaleFactor,
                  width: 40 * scaleFactor,
                  activeColor: AppColors.forwardColor,
                  inactiveColor: AppColors.greyColor,
                )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}