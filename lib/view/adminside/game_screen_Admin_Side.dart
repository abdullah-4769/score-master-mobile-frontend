
















































































          













                  





































    


             


























         





            
          

          


















import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:scorer/components/adminside/game_use_able_Container.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';
import 'package:scorer/widgets/add_one_Container.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/setting_container.dart';
import 'package:scorer/widgets/useable_container.dart';

class GameScreenAdminSide extends StatelessWidget {
  const GameScreenAdminSide({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    const double baseWidth = 414.0;
    const double baseHeight = 812.0;
    final double widthScaleFactor = screenWidth / baseWidth;
    final double heightScaleFactor = screenHeight / baseHeight;

    return GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30 * widthScaleFactor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            Appimages.prince2,
                            width: 62 * widthScaleFactor,
                            height: 83 * heightScaleFactor,
                          ),
                          Row(
                            children: [
                              SettingContainer(icons: Icons.settings),
                              SizedBox(width: 6 * widthScaleFactor),
                              SettingContainer(
                                icons: Icons.notifications,
                                ishow: true,
                              ),
                              SizedBox(width: 6 * widthScaleFactor),
                              AddOneContainer(icon: Icons.add,
                              onTap:(){
                                 Get.toNamed(RouteName.game2Screen);
                              }
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 30 * widthScaleFactor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(""),
                      CreateContainer(
                        text: "Create New",
                        width: 100 * widthScaleFactor,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30 * widthScaleFactor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BoldText(
                        text: "Users Management",
                        fontSize: 16 * widthScaleFactor,
                        selectionColor: AppColors.blueColor,
                      ),
                      MainText(
                        text: "Securely manage roles, permissions,\nand access.",
                        fontSize: 14 * widthScaleFactor,
                        height: 1.4,
                      ),
                      SizedBox(height: 40 * heightScaleFactor),
                      GameUseAbleContainer(
                        widthScaleFactor: widthScaleFactor,
                        heightScaleFactor: heightScaleFactor,
                      ),
                      SizedBox(height: 12 * heightScaleFactor),
                      GameUseAbleContainer(
                        widthScaleFactor: widthScaleFactor,
                        heightScaleFactor: heightScaleFactor,
                      ),
                      SizedBox(height: 12 * heightScaleFactor),
                      GameUseAbleContainer(
                        widthScaleFactor: widthScaleFactor,
                        heightScaleFactor: heightScaleFactor,
                      ),
                      SizedBox(height: 12 * heightScaleFactor),
                      GameUseAbleContainer(
                        widthScaleFactor: widthScaleFactor,
                        heightScaleFactor: heightScaleFactor,
                      ),
                      SizedBox(height: 12 * heightScaleFactor),
                      GameUseAbleContainer(
                        widthScaleFactor: widthScaleFactor,
                        heightScaleFactor: heightScaleFactor,
                      ),
                      SizedBox(height: 52 * heightScaleFactor),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
}

