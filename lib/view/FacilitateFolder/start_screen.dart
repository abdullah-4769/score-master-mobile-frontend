
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/controllers/language_Selection_controller.dart';
import 'package:scorer/widgets/forward_button_container.dart';
import 'package:scorer/widgets/language_selection_container.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';

class StartScreen extends StatelessWidget {
  final controller = Get.put(LanguageSelectionController());
  StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    const double baseWidth = 375.0;
    final double scaleFactor = screenWidth / baseWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 26 * scaleFactor),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: screenHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      SizedBox(height: 30 * scaleFactor),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                Appimages.language,
                                height: 24 * scaleFactor,
                                width: 24 * scaleFactor,
                              ),
                              SizedBox(width: 5 * scaleFactor),
                              MainText(
                                text: 'select_language'.tr,
                                fontSize: 16 * scaleFactor,
                              ),
                            ],
                          ),
                          ForwardButtonContainer(
                            onTap: () {
                              Get.toNamed(RouteName.startScreen1);
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 17 * scaleFactor),
                        child: Column(
                          children: [
                            LanguageSelectionContainer(
                              text: "English",
                              image: Appimages.uk,
                              isSelected: controller.selectLangauge.value == 0,
                              onTap: () => controller.select(0),
                            ),
                            SizedBox(height: 9 * scaleFactor),
                            LanguageSelectionContainer(
                              text: "Spanish",
                              image: Appimages.spain,
                              isSelected: controller.selectLangauge.value == 1,
                              onTap: () => controller.select(1),
                            ),
                            SizedBox(height: 9 * scaleFactor),
                            LanguageSelectionContainer(
                              text: "French",
                              image: Appimages.france,
                              isSelected: controller.selectLangauge.value == 2,
                              onTap: () => controller.select(2),
                            ),
                            SizedBox(height: 9 * scaleFactor),
                            LanguageSelectionContainer(
                              text: "Germany",
                              image: Appimages.germany,
                              isSelected: controller.selectLangauge.value == 3,
                              onTap: () => controller.select(3),
                            ),
                            SizedBox(height: 9 * scaleFactor),
                            LanguageSelectionContainer(
                              text: "Italy",
                              image: Appimages.italy,
                              isSelected: controller.selectLangauge.value == 4,
                              onTap: () => controller.select(4),
                            ),
                            SizedBox(height: 9 * scaleFactor),
                            LanguageSelectionContainer(
                              text: "Arabic",
                              image: Appimages.saudi,
                              isSelected: controller.selectLangauge.value == 5,
                              onTap: () => controller.select(5),
                            ),
                            SizedBox(height: 9 * scaleFactor),
                            LanguageSelectionContainer(
                              text: "South Africa",
                              image: Appimages.southAfrica,
                              isSelected: controller.selectLangauge.value == 6,
                              onTap: () => controller.select(6),
                            ),
                          ],
                        ),
                      ),

                      
                      Spacer(),

                      SvgPicture.asset(
                        Appimages.bottom,
                        width: 104 * scaleFactor,
                        height: 32 * scaleFactor,
                      ),
                      SizedBox(height: 40 * scaleFactor),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
