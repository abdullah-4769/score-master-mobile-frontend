import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get.dart';
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

import '../../api/api_controllers/show_all_game_model_controller.dart';


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

    // Initialize the games controller
    final GamesController gamesController = Get.put(GamesController());

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
                            AddOneContainer(
                                icon: Icons.add,
                                onTap: () {
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
                    // Header with stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BoldText(
                              text: "Games Management",
                              fontSize: 16 * widthScaleFactor,
                              selectionColor: AppColors.blueColor,
                            ),
                            MainText(
                              text: "Manage and monitor all game formats\nand configurations.",
                              fontSize: 14 * widthScaleFactor,
                              height: 1.4,
                            ),
                          ],
                        ),
                        // Refresh button with stats
                        Obx(() => Column(
                          children: [
                            GestureDetector(
                              onTap: gamesController.isLoading.value
                                  ? null
                                  : () => gamesController.refreshGames(),
                              child: Container(
                                padding: EdgeInsets.all(8 * widthScaleFactor),
                                decoration: BoxDecoration(
                                  color: AppColors.blueColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8 * widthScaleFactor),
                                ),
                                child: gamesController.isLoading.value
                                    ? SizedBox(
                                  width: 16 * widthScaleFactor,
                                  height: 16 * heightScaleFactor,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.blueColor,
                                  ),
                                )
                                    : Icon(
                                  Icons.refresh,
                                  color: AppColors.blueColor,
                                  size: 18 * widthScaleFactor,
                                ),
                              ),
                            ),
                            SizedBox(height: 4 * heightScaleFactor),
                            Text(
                              "${gamesController.totalGames} Games",
                              style: TextStyle(
                                fontSize: 10 * widthScaleFactor,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),

                    SizedBox(height: 20 * heightScaleFactor),

                    // Games List
                    Obx(() {
                      if (gamesController.isLoading.value) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(50 * heightScaleFactor),
                            child: Column(
                              children: [
                                CircularProgressIndicator(color: AppColors.blueColor),
                                SizedBox(height: 16 * heightScaleFactor),
                                Text(
                                  "Loading games...",
                                  style: TextStyle(
                                    fontSize: 14 * widthScaleFactor,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      if (gamesController.hasError.value) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(30 * heightScaleFactor),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 48 * widthScaleFactor,
                                ),
                                SizedBox(height: 16 * heightScaleFactor),
                                Text(
                                  "Error loading games",
                                  style: TextStyle(
                                    fontSize: 16 * widthScaleFactor,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(height: 8 * heightScaleFactor),
                                Text(
                                  gamesController.errorMessage.value,
                                  style: TextStyle(
                                    fontSize: 12 * widthScaleFactor,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 16 * heightScaleFactor),
                                ElevatedButton(
                                  onPressed: () => gamesController.refreshGames(),
                                  child: Text("Try Again"),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      if (gamesController.games.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(50 * heightScaleFactor),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.games_outlined,
                                  color: Colors.grey,
                                  size: 48 * widthScaleFactor,
                                ),
                                SizedBox(height: 16 * heightScaleFactor),
                                Text(
                                  "No games found",
                                  style: TextStyle(
                                    fontSize: 16 * widthScaleFactor,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 8 * heightScaleFactor),
                                Text(
                                  "Create your first game to get started",
                                  style: TextStyle(
                                    fontSize: 12 * widthScaleFactor,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      // Display games using ListView.builder
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: gamesController.games.length,
                        itemBuilder: (context, index) {
                          final game = gamesController.games[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12 * heightScaleFactor),
                            child: GameUseAbleContainer(
                              widthScaleFactor: widthScaleFactor,
                              heightScaleFactor: heightScaleFactor,
                              game: game,
                              onTap: () {
                                print("🎮 Game tapped: ${game.displayName}");
                                // TODO: Navigate to game details or edit screen
                                Get.snackbar(
                                  'Game Selected',
                                  '${game.displayName} - ${game.totalPhases} phases',
                                  backgroundColor: AppColors.blueColor.withOpacity(0.1),
                                  colorText: AppColors.blueColor,
                                );
                              },
                            ),
                          );
                        },
                      );
                    }),

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