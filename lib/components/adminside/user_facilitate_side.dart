import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/widgets/all_players_container.dart';

class UserFacilitateSide extends StatelessWidget {
  const UserFacilitateSide({super.key});
@override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    // A base height and width to scale from, e.g., a common phone (iPhone 11)
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
          // 🔍 Search Bar
                  SizedBox(height: 20 * heightScaleFactor),

          // Player Container
          AllPlayersContainer(
            onTap: () => Get.toNamed(RouteName.userFacilitateDetailedScree),

            fontSize2: 12,
            text: "Alex Martinez",
            text2: "john.smith@company.com",
            image: Appimages.facil2,
          ),
                  SizedBox(height: 7 * heightScaleFactor),
                    AllPlayersContainer(
            onTap: () => Get.toNamed(RouteName.userFacilitateDetailedScree),

                      text3: "inactive".tr,
                      color: AppColors.orangeColor,
                      width: 60,
            fontSize2: 12,
            text: "Alex Martinez",
            text2: "john.smith@company.com",
            image: Appimages.facil2,
          ),
            SizedBox(height: 7 * heightScaleFactor),
                    AllPlayersContainer(
                      text3: "pending".tr,
            onTap: () => Get.toNamed(RouteName.userFacilitateDetailedScree),

                      color: AppColors.redColor,
                      width: 70,
            fontSize2: 12,
            text: "Alex Martinez",
            text2: "john.smith@company.com",
            image: Appimages.facil2,
          ),
            SizedBox(height: 7 * heightScaleFactor),
                    AllPlayersContainer(
            onTap: () => Get.toNamed(RouteName.userFacilitateDetailedScree),

            fontSize2: 12,
            text: "Alex Martinez",
            text2: "john.smith@company.com",
            image: Appimages.facil2,
          ),
            SizedBox(height: 7 * heightScaleFactor),
                    AllPlayersContainer(
            onTap: () => Get.toNamed(RouteName.userFacilitateDetailedScree),

            fontSize2: 12,
            text: "Alex Martinez",
            text2: "john.smith@company.com",
            image: Appimages.facil2,
          ),
            SizedBox(height: 7 * heightScaleFactor),
                    AllPlayersContainer(
            onTap: () => Get.toNamed(RouteName.userFacilitateDetailedScree),

            fontSize2: 12,
            text: "Alex Martinez",
            text2: "john.smith@company.com",
            image: Appimages.facil2,
          ),
            SizedBox(height: 7 * heightScaleFactor),
                    AllPlayersContainer(
            onTap: () => Get.toNamed(RouteName.userFacilitateDetailedScree),

            fontSize2: 12,
            text: "Alex Martinez",
            text2: "john.smith@company.com",
            image: Appimages.facil2,
          ),
             SizedBox(height: 30,)
          
          

        ],
      ),
    );
  }
}
