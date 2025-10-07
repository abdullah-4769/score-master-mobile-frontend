import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import '../../api/api_controllers/join_session_controller.dart';
import '../create_container.dart';


class JoinSessionWidget extends StatelessWidget {
  final JoinSessionController controller = Get.put(JoinSessionController());
  final int playerId;

  JoinSessionWidget({super.key, required this.playerId});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double baseHeight = 812.0;
    final double baseWidth = 414.0;
    final double heightScaleFactor = screenSize.height / baseHeight;
    final double widthScaleFactor = screenSize.width / baseWidth;

    return Container(
      height: 70 * heightScaleFactor,
      width: 337 * widthScaleFactor,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26 * widthScaleFactor),
        border: Border.all(
          color: AppColors.greyColor,
          width: 1.5 * widthScaleFactor,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -20 * heightScaleFactor,
            right: 0,
            child: Obx(() {
              return CreateContainer(
                text: controller.isLoading.value
                    ? "Joining...".tr
                    : "join_with_code".tr,
                width: 186 * widthScaleFactor,
                onTap: controller.isLoading.value
                    ? null
                    : () => controller.joinSession(
                  playerId,
                  controller.codeController.value,
                ),
              );
            }),
          ),
          Center(
            child: SizedBox(
              width: 200 * widthScaleFactor,
              child: TextField(
                onChanged: (val) => controller.codeController.value = val,
                decoration: InputDecoration(
                  hintText: "enter_code".tr,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10 * widthScaleFactor,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22 * heightScaleFactor,
                  fontFamily: "gotham",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
