


























              



































              


              







                

































              

































      


      












































































import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/team_Alpha_Container.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/widgets/all_players_container.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/useable_textrow.dart';

class PlayersScreen extends StatelessWidget {
  const PlayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    
    final activeInactiveBoxWidth = screenWidth * 0.28;
    final activeInactiveBoxHeight = screenHeight * 0.14;
    final topBoxSpacing = screenWidth * 0.03;
    final topPadding = screenWidth * 0.08;
    final verticalSpacing = screenHeight * 0.03;
    final sectionPadding = screenWidth * 0.08;
    final allPlayersContainerSpacing = screenHeight * 0.01;
    final teamDistributionBoxWidth = screenWidth * 0.9;
    final teamDistributionBoxHeight = screenHeight * 0.22;
    final buttonHeight = screenHeight * 0.06;
    final positionedBoxWidth = screenWidth * 0.38;
    final positionedBoxHeight = screenHeight * 0.07;
    final positionedIconImageWidth = screenWidth * 0.15;
    final positionedIconImageHeight = screenHeight * 0.14;
    final positionedTextPadding = screenWidth * 0.1;
    final positionedTextFontSize = screenWidth * 0.035;

    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.05,
                right: topPadding,
                left: topPadding * 0.4,
              ),
              child: Row(
                children: [
                  Image.asset(
                    Appimages.group,
                    width: screenWidth * 0.3,
                  ),
                  SizedBox(width: topBoxSpacing),
                  Expanded(
                    child: Container(
                      height: activeInactiveBoxHeight,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.greyColor, width: 1.7),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BoldText(
                            text: "12",
                            selectionColor: AppColors.forwardColor,
                            fontSize: screenWidth * 0.06,
                          ),
                       BoldText(
                        textAlign: TextAlign.center,
  text: "active".tr,
  fontSize: screenWidth * 0.04,
  selectionColor: AppColors.blueColor,
),
  BoldText(
                        textAlign: TextAlign.center,
  text: "players".tr,
  fontSize: screenWidth * 0.04,
  selectionColor: AppColors.blueColor,
),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: topBoxSpacing),
                  Expanded(
                    child: Container(
                      height: activeInactiveBoxHeight,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.greyColor, width: 1.7),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BoldText(
                            text: "02",
                            selectionColor: AppColors.redColor,
                            fontSize: screenWidth * 0.06,
                          ),
                         BoldText(
                        textAlign: TextAlign.center,
                          
  text: "inactive_players".tr,
  fontSize: screenWidth * 0.04,
  selectionColor: AppColors.blueColor,
),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: verticalSpacing),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sectionPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     BoldText(
  text: "all_players".tr,
  fontSize: screenWidth * 0.04,
  selectionColor: AppColors.blueColor,
),
                      Row(
                        children: [
                          SvgPicture.asset(Appimages.filter),
                          SizedBox(width: screenWidth * 0.015),
                          BoldText(
  text: "filter".tr,
  fontSize: screenWidth * 0.04,
  selectionColor: AppColors.blueColor,
),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: allPlayersContainerSpacing),
                  AllPlayersContainer(text: "Alex Martinez", text2: "Joined 2:35 PM", image: Appimages.play3),
                  SizedBox(height: allPlayersContainerSpacing),
                  CreateContainer(
                    right: screenWidth * 0.08,
                    width: screenWidth * 0.25,
                    text: "team_alpha".tr
                  ),
                  SizedBox(height: allPlayersContainerSpacing * 2),
                  AllPlayersContainer(text: "Sarah Johnson", text2: "Joined 2:35 PM", image: Appimages.player2),
                  SizedBox(height: allPlayersContainerSpacing),
                  CreateContainer(
                    textColor: AppColors.purpleColor,
                    borderColor: AppColors.purpleColor,
                    containerColor: AppColors.lightPurpleColor,
                    right: screenWidth * 0.08,
                    width: screenWidth * 0.25,
                    text: "team_beta".tr
                  ),
                  SizedBox(height: allPlayersContainerSpacing * 2),
                  AllPlayersContainer(text: "Sarah Johnson", text2: "Joined 2:35 PM", image: Appimages.prince2),
                  SizedBox(height: allPlayersContainerSpacing),
                  CreateContainer(
                    textColor: AppColors.orangeColor,
                    borderColor: AppColors.orangeColor,
                    containerColor: AppColors.lightOrangeColor.withOpacity(0.5),
                    right: screenWidth * 0.08,
                    width: screenWidth * 0.25,
                    text: "team_gamma".tr
                  ),
                  SizedBox(height: allPlayersContainerSpacing * 2),
                  AllPlayersContainer(text: "Alex Martinez", text2: "Joined 2:35 PM", image: Appimages.play3),
                  SizedBox(height: allPlayersContainerSpacing),
                  CreateContainer(
                    right: screenWidth * 0.08,
                    width: screenWidth * 0.25,
                    text: "team_alpha".tr
                  ),
                  
                  SizedBox(height: allPlayersContainerSpacing * 2),
        
                  Container(
                    width: screenWidth * 0.9,
                    height: teamDistributionBoxHeight,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.greyColor, width: 1.7),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.01,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                         BoldText(
  text: "team_distribution".tr,
  selectionColor: AppColors.blueColor,
  fontSize: screenWidth * 0.04,
),
                          SizedBox(height: screenHeight * 0.005),
                          UseableTextrow(
                            color: AppColors.forwardColor,
                            text:"team_beta".tr,
                            text1: "4 Players",
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          UseableTextrow(
                            color: AppColors.forwardColor2,
                            text: "team_gamma".tr,
                            text1: "4 Players",
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          UseableTextrow(
                            color: AppColors.forwardColor3,
                            text: "team_alpha".tr,
                            text1: "4 Players",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: verticalSpacing),
                  Center(child: LoginButton(
                    fontSize: 18,
                    text: "add_player".tr, image: Appimages.personadd, ishow: true)),
                  SizedBox(height: allPlayersContainerSpacing),
                  Center(
                    child: LoginButton(
                      onTap: () {
                        Get.toNamed(RouteName.viewResponsesScreen);
                      },
                      fontSize: 18,
                      text: "view_responses".tr,
                      image: Appimages.eye,
                      color: AppColors.forwardColor,
                      ishow: true,
                    ),
                  ),
                  SizedBox(height: allPlayersContainerSpacing),
                  Center(
                    child: LoginButton(
                      fontSize: 18,
                      text: "send_alert".tr,
                      image: Appimages.noti,
                      color: AppColors.redColor,
                      ishow: true,
                    ),
                  ),
                  SizedBox(height: allPlayersContainerSpacing),
                ],
              ),
            ),
          ],
        ),
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
          Positioned(
          right: 0,
          top: screenHeight * 0.2,
          child: TeamAlphaContainer(screenWidth: screenWidth, screenHeight: screenHeight),
        ),

        
      
      
      ],
    );
  }
} 