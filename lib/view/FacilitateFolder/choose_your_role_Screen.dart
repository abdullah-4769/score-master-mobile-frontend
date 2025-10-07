import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/controllers/role_selection_controller.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/forward_button_container.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/role_selection_container.dart';
import 'package:scorer/widgets/role_text_container.dart';

import 'aa.dart';

class ChooseYourRoleScreen extends StatelessWidget {
  final RoleSelectionController controller = Get.put(RoleSelectionController());

  ChooseYourRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    const double baseHeight = 812.0;
    const double baseWidth = 414.0;
    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30 * widthScaleFactor),
                child: Column(
                  children: [
                    SizedBox(height: 20 * heightScaleFactor),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          right: 40,
                          child: Transform.rotate(
                            angle: -0.1,
                            child: RoleTextContainer(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BoldText(
                              fontSize: ResponsiveFont.getFontSizeCustom(
                                defaultSize: 22 * widthScaleFactor,
                                smallSize: 18 * widthScaleFactor,
                              ),
                              text: "choose_your".tr,
                              selectionColor: AppColors.blueColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20 * heightScaleFactor),
                    MainText(
                      height: 1.3,
                      fontSize: 16,
                      text: 'select_participation'.tr,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 19 * heightScaleFactor),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Obx(
                              () => RoleSelectionContainer(
                            onTap: () => controller.changeTab(0),
                            isSelected: controller.selectedIndex.value == 0,
                            image: Appimages.prince1,
                            image2: Appimages.admin,
                            text: "administrator".tr,
                            text2: 'admin_description'.tr,
                          ),
                        ),
                        SizedBox(height: 10 * heightScaleFactor),
                        Obx(
                              () => RoleSelectionContainer(
                            onTap: () => controller.changeTab(1),
                            isSelected: controller.selectedIndex.value == 1,
                            image: Appimages.blackman,
                            image2: Appimages.facil,
                            text: "facilitator".tr,
                            text2: 'facilitator_description'.tr,
                            width: 169,
                          ),
                        ),
                        SizedBox(height: 10 * heightScaleFactor),
                        Obx(
                              () => RoleSelectionContainer(
                            onTap: () => controller.changeTab(2),
                            isSelected: controller.selectedIndex.value == 2,
                            image: Appimages.blackgirl,
                            image2: Appimages.player,
                            text: "player".tr,
                            text2: 'player_description'.tr,
                            width: 160,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    ForwardButtonContainer(
                      onTap: () {
                        final controller = Get.find<RoleSelectionController>();

                        // Only Admin login & Facilitator login for now
                        if (controller.selectedIndex.value == 0) {
                          Get.toNamed(RouteName.adminLoginScreen);
                        } else if (controller.selectedIndex.value == 1) {
                          Get.toNamed(RouteName.facilLoginScreen);
                        } else if (controller.selectedIndex.value == 2) {
                          Get.toNamed(RouteName.playerLoginScreen);
                        } else {
                          Get.snackbar(
                            "selection_required".tr,
                            "please_select_role".tr,
                            backgroundColor: AppColors.forwardColor,
                            colorText: AppColors.whiteColor,
                          );
                        }
                      },
                    ),
                    SizedBox(height: 10 * heightScaleFactor),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
