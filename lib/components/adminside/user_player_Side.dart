




















































































          
          







import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/controllers/user_managment_controller.dart';
import 'package:scorer/widgets/all_players_container.dart';

class UserPlayerSide extends StatelessWidget {
  UserPlayerSide({super.key});
  
  final UserManagmentController userController = Get.find<UserManagmentController>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    
    const double baseHeight = 812.0;
    const double baseWidth = 414.0;
    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 32 * widthScaleFactor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20 * heightScaleFactor),

          
          AllPlayersContainer(
            onTap: () => Get.toNamed(
              RouteName.userPlayerDetailedScree,
              arguments: {'userId': userController.getCurrentUserId()},
            ),
            fontSize2: 12 * widthScaleFactor,
            text: "Alex Martinez",
            text2: "john.smith@company.com",
            image: Appimages.player2,
          ),
          SizedBox(height: 7 * heightScaleFactor),
          AllPlayersContainer(
            onTap: () => Get.toNamed(
              RouteName.userPlayerDetailedScree,
              arguments: {'userId': userController.getCurrentUserId()},
            ),
            text3: "inactive".tr,
            color: AppColors.orangeColor,
            width: 65 * widthScaleFactor,
            fontSize2: 12 * widthScaleFactor,
            text: "Alex Martinez",
            text2: "john.smith@company.com",
            image: Appimages.player2,
          ),
          SizedBox(height: 7 * heightScaleFactor),
          AllPlayersContainer(
            onTap: () => Get.toNamed(RouteName.userPlayerDetailedScree),

            text3: "pending".tr,
            color: AppColors.redColor,
            width: 80 * widthScaleFactor,
            fontSize2: 12 * widthScaleFactor,
            text: "Alex Martinez",
            text2: "john.smith@company.com",
            image: Appimages.player2,
          ),
          SizedBox(height: 7 * heightScaleFactor),
          AllPlayersContainer(
            onTap: () => Get.toNamed(RouteName.userPlayerDetailedScree),

            fontSize2: 12 * widthScaleFactor,
            text: "Alex Martinez",
            text2: "john.smith@company.com",
            image: Appimages.player2,
          ),
          SizedBox(height: 7 * heightScaleFactor),
          AllPlayersContainer(
            onTap: () => Get.toNamed(RouteName.userPlayerDetailedScree),

            fontSize2: 12 * widthScaleFactor,
            text: "Alex Martinez",
            text2: "john.smith@company.com",
            image: Appimages.player2,
          ),
          SizedBox(height: 7 * heightScaleFactor),
          AllPlayersContainer(
            onTap: () => Get.toNamed(RouteName.userPlayerDetailedScree),

            fontSize2: 12 * widthScaleFactor,
            text: "Alex Martinez",
            text2: "john.smith@company.com",
            image: Appimages.player2,
          ),
          SizedBox(height: 7 * heightScaleFactor),
          AllPlayersContainer(
            onTap: () => Get.toNamed(RouteName.userPlayerDetailedScree),

            fontSize2: 12 * widthScaleFactor,
            text: "Alex Martinez",
            text2: "john.smith@company.com",
            image: Appimages.player2,
          ),
          SizedBox(height: 7 * heightScaleFactor),
          AllPlayersContainer(
            onTap: () => Get.toNamed(
              RouteName.userPlayerDetailedScree,
              arguments: {'userId': userController.getCurrentUserId()},
            ),
            fontSize2: 12 * widthScaleFactor,
            text: "Alex Martinez",
            text2: "john.smith@company.com",
            image: Appimages.player2,
          ),
          SizedBox(height: 30,)
        ],
      ),
    );
  }
}