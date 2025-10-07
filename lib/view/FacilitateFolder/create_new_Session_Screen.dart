

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:scorer/components/additional_setting_colum.dart';
import 'package:scorer/components/count_container_row.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';

import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/custom_phase_Container.dart';
import 'package:scorer/widgets/filter_useable_container.dart';
import 'package:scorer/widgets/game_Select_useable_container.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';



class CreateNewSessionScreen extends StatelessWidget {
  final bool isSelected;
  const CreateNewSessionScreen({super.key, this.isSelected = true});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    
    
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;

    
    final double baseHeight = 812.0;
     double baseWidth = 375.0;
    
    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;


    
    
    final double scaleFactor = screenWidth / baseWidth;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                 SizedBox(
                    height: 100 * scaleFactor,
                    child: Stack(
                      children: [
                     
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          
                            Padding(
                                      padding: EdgeInsets.only(left: 30 * scaleFactor), 

                              child: RichText(
                                                     text: TextSpan(
                                                       style:  TextStyle(
                                                        
                                                        
                                                      fontSize: ResponsiveFont.getFontSizeCustom(
                                                        defaultSize: 22*widthScaleFactor,
                                                        smallSize: 17*widthScaleFactor
                                                      ),  
                                                       fontWeight: FontWeight.bold),
                                                       children: [
                              TextSpan(
                               text: "create_ne".tr,   
                               
                               style: TextStyle(
                                 color: AppColors.blueColor, 
                               ),
                                                         ),
                                                         WidgetSpan(
                               alignment: PlaceholderAlignment.middle, 
                               child: Container(
                                 
                                 decoration: BoxDecoration(
                                   color: Color(0xff8DC046),
                                   borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                bottomLeft: Radius.circular(30),
                                   ),
                                 ),
                                 child:  Text(
                                  "w".tr,    
                                   style: TextStyle(
                                                color: AppColors.blueColor, 
                                                fontSize: ResponsiveFont.getFontSizeCustom(
                                                        defaultSize: 22*widthScaleFactor,
                                                        smallSize: 17*widthScaleFactor
                                                      ),  
                                                fontWeight: FontWeight.bold,
                                   ),
                                 ),
                               ),
                                                         ),
                                                         WidgetSpan(
                               alignment: PlaceholderAlignment.middle, 
                               child: Container(
                                 decoration: BoxDecoration(
                                   color: AppColors.forwardColor,
                                   borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(30),
                                                bottomRight: Radius.circular(30),
                                   ),
                                 ),
                                 child: Padding(
                                   padding:  EdgeInsets.only(left: 4.0, right: 10.0),
                                   child:  Text(
                                               "session".tr,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                   fontSize: ResponsiveFont.getFontSizeCustom(
                                                        defaultSize: 22*widthScaleFactor,
                                                        smallSize: 17*widthScaleFactor
                                                      ),  
                                                  fontWeight: FontWeight.bold,
                                                ),
                                   ),
                                 ),
                               ),
                                                         ),
                                                       ],
                                                     ),
                                                   ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10 * scaleFactor),
                              child: Image.asset(
                                Appimages.house1,
                                height: 85 * scaleFactor,
                                width: 100 * scaleFactor,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30 * scaleFactor),
                  child: Column(
                    children: [
                      
                      SizedBox(
                  height: 150 * scaleFactor, 
                  child: Image.asset(
                    Appimages.game,
                    fit: BoxFit.contain, 
                  ),
                ),
                      SizedBox(height: 40 * scaleFactor),
                      TextFormField(
                    textAlign: TextAlign.center, 
  style: TextStyle(
    fontSize: 22 * scaleFactor,
    fontWeight: FontWeight.w600,
  ),
  decoration: InputDecoration(
    hintText: "enter_session_name".tr,
    hintStyle: TextStyle(
      
fontSize:(Get.locale?.languageCode == 'fr' || Get.locale?.languageCode == 'es')? 18:22,
      
      fontWeight: FontWeight.w600,
      color: AppColors.languageTextColor
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 20 * scaleFactor,
      horizontal: 16 * scaleFactor,
    ),
    border:OutlineInputBorder(
      borderRadius: BorderRadius.circular(24 * scaleFactor),
      borderSide: BorderSide(
        color: AppColors.assignColor,
        width: 2 * scaleFactor,
      ),
    ) ,
    
    
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24 * scaleFactor),
      borderSide: BorderSide(
        color: AppColors.assignColor,
        width: 2 * scaleFactor,
      ),
    ) ,
  ),
),
                      SizedBox(height: 50 * scaleFactor),
                      BoldText(
                text:   "select_game_format".tr, 
                        selectionColor: AppColors.blueColor,
                        fontSize: 16 * scaleFactor,
                      ),
                      SizedBox(height: 30 * scaleFactor),
                      GameSelectUseableContainer(
                        
fontSize:ResponsiveFont.getFontSizeCustom(defaultSize: 13*widthScaleFactor,smallSize: 10*widthScaleFactor),
                       text1: "odyssee_des_okr".tr,
  text2: "strategic_goal_workshop".tr,
                        isSelected: isSelected,
                      ),
                      SizedBox(height: 10 * scaleFactor),
                      GameSelectUseableContainer(

fontSize:ResponsiveFont.getFontSizeCustom(defaultSize: 13*widthScaleFactor,smallSize: 10*widthScaleFactor),

                      text1: "feedloop".tr,
  text2: "feedback_collab_game".tr,
                        isSelected: false,
                      ),
                      SizedBox(height: 10 * scaleFactor),
                      GameSelectUseableContainer(


fontSize:ResponsiveFont.getFontSizeCustom(defaultSize: 13*widthScaleFactor,smallSize: 10*widthScaleFactor),

                      text1: "innovation_challenge".tr,
  text2: "creative_problem_workshop".tr,
                        isSelected: isSelected,
                      ),
                      SizedBox(height: 31 * scaleFactor),
                      BoldText(
                        
  text: "number_of_phases".tr,
                        fontSize: 16 * scaleFactor,
                        selectionColor: AppColors.blueColor,
                      ),
                      SizedBox(height: 14 * scaleFactor),
                      MainText(
  text: "phase_structure_adapts".tr,
                        color: AppColors.teamColor,
                        textAlign: TextAlign.center,
                        height: 1.4,
                        fontSize: 15 * scaleFactor,
                      ),
                      SizedBox(height: 29 * scaleFactor),
                      CountContainerRow(scaleFactor: scaleFactor),
                      SizedBox(height: 30 * scaleFactor),
                      BoldText(
                        text: "enter_details_phase_1".tr,
                        selectionColor: AppColors.blueColor,
                        fontSize: 16 * scaleFactor,
                      ),
                      SizedBox(height: 25 * scaleFactor),
CustomPhaseContainer(text1: "name_phase_1".tr, text2: "Strategy"),
                      SizedBox(height: 9 * scaleFactor),
CustomPhaseContainer(text1: "no_of_stages".tr, text2: "03"),
                      SizedBox(height: 9 * scaleFactor),
CustomPhaseContainer(text1: "duration".tr, text2: "15 min"),
                      SizedBox(height: 30 * scaleFactor),
                     BoldText(
  text: "phase_1_stages".tr,
  selectionColor: AppColors.blueColor,
  fontSize: 16 * scaleFactor,
),
                      SizedBox(height: 25 * scaleFactor),
FilterUseableContainer(
  
  isSelected: true, text: "mcq".tr, onTap: () {}),
                      SizedBox(height: 10 * scaleFactor),
FilterUseableContainer(isSelected: false, text: "open_ended".tr, onTap: () {}),
                      SizedBox(height: 10 * scaleFactor),
FilterUseableContainer(isSelected: true, text: "puzzle".tr, onTap: () {}),
                      SizedBox(height: 10 * scaleFactor),
FilterUseableContainer(isSelected: false, text: "simulation".tr, onTap: () {}),
                      SizedBox(height: 24 * scaleFactor),
                      LoginButton(
                        text: "move_to_phase2".tr,
                        height: 45 * scaleFactor,
                        color: AppColors.forwardColor,
                        radius: 12 * scaleFactor,
                        fontSize: 14 * scaleFactor,
                        fontFamily: "refsan",
                      ),
                      SizedBox(height: 50 * scaleFactor),
                      BoldText(
                        text: "player_capacity".tr,
                        selectionColor: AppColors.blueColor,
                        fontSize: 16 * scaleFactor,
                      ),
                      SizedBox(height: 30 * scaleFactor),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Image.asset(Appimages.pas, width: 100 * scaleFactor, height: 86 * scaleFactor),
                              SizedBox(height: 10 * scaleFactor),
                              BoldText(text: "5-10", fontSize: 16 * scaleFactor, selectionColor: AppColors.blueColor),
MainText(text: "small".tr, fontSize: 14 * scaleFactor, height: 1.7, color: AppColors.teamColor),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(Appimages.pas, width: 100 * scaleFactor, height: 86 * scaleFactor),
                              SizedBox(height: 10 * scaleFactor),
                              BoldText(text: "10-20", fontSize: 16 * scaleFactor, selectionColor: AppColors.forwardColor),
MainText(text: "medium".tr, fontSize: 14 * scaleFactor, height: 1.7, color: AppColors.forwardColor),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(Appimages.pas, width: 100 * scaleFactor, height: 86 * scaleFactor),
                              SizedBox(height: 10 * scaleFactor),
                              BoldText(text: "20-50", fontSize: 16 * scaleFactor, selectionColor: AppColors.blueColor),
MainText(text: "large".tr, fontSize: 14 * scaleFactor, height: 1.7, color: AppColors.teamColor),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 31 * scaleFactor),
                      Container(
                        height: 50 * scaleFactor,
                        width: 334 * scaleFactor,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12 * scaleFactor),
                          border: Border.all(color: AppColors.greyColor, width: 1.5 * scaleFactor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10 * scaleFactor),
                          child: TextFormField(
                            cursorColor: AppColors.languageTextColor,
                            decoration: InputDecoration(
                              hintText: "enter_custom_number".tr,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 16 * scaleFactor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12 * scaleFactor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40 * scaleFactor),
                      BoldText(
                        text: "badge_labeling".tr,
                        fontSize: 16 * scaleFactor,
                        selectionColor: AppColors.blueColor,
                      ),
                      SizedBox(height: 16 * scaleFactor),
                      Image.asset(Appimages.badge, width: 129 * scaleFactor, height: 120 * scaleFactor),
                      SizedBox(height: 11 * scaleFactor),
                      CustomPhaseContainer(
                        text1: "badge_name".tr,
                        text2: "Gold Achiever",
                        fontSize: 16 * scaleFactor,
                        color: AppColors.forwardColor,
                      ),
                      SizedBox(height: 8 * scaleFactor),
                      CustomPhaseContainer(
                        text1:  "required_score".tr,
                        text2: "90+",
                        fontSize: 16 * scaleFactor,
                        color: AppColors.forwardColor,
                      ),
                      SizedBox(height: 16 * scaleFactor),
                      LoginButton(
                        text:  "add_more_badges".tr,
                        height: 45 * scaleFactor,
                        color: AppColors.forwardColor,
                        radius: 12 * scaleFactor,
                        fontSize: 14 * scaleFactor,
                        fontFamily: "refsan",
                      ),
                      SizedBox(height: 18 * scaleFactor),
                      Container(
                        width: 337 * scaleFactor,
                        height: 76 * scaleFactor,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.greyColor, width: 1.5 * scaleFactor),
                          borderRadius: BorderRadius.circular(24 * scaleFactor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3 * scaleFactor),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Image.asset(Appimages.ai2, width: 45 * scaleFactor, height: 40 * scaleFactor),
                                  SizedBox(width: 2 * scaleFactor),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    MainText(text: "ai_scoring".tr, fontSize: 14 * scaleFactor),
MainText(text: "enable_ai_scoring".tr, fontSize: 11 * scaleFactor, color: AppColors.teamColor, height: 1.2),
                               ],
                                  ),
                                ],
                              ),
                              Expanded(
                                child: FlutterSwitch(
                                  value: true,
                                  onToggle: (val) {},
                                  height: 26 * scaleFactor,
                                  width: 40 * scaleFactor,
                                  activeColor: AppColors.forwardColor,
                                  inactiveColor: AppColors.forwardColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30 * scaleFactor),
AdditionalSettingColumn(scaleFactor: scaleFactor, widthScaleFactor: widthScaleFactor),                      SizedBox(height: 30 * scaleFactor),
                      LoginButton(
                fontSize: 19,
                        
                        text: "start_immediately".tr,
                        ishow: true,
                        icon: Icons.play_arrow_rounded,
                        imageHeight: 30 * scaleFactor,
                        imageWidth: 30 * scaleFactor,
                      ),
                      SizedBox(height: 13 * scaleFactor),
                      LoginButton(
                fontSize: 19,

                   text:      "schedule_for_later".tr, 
                        image: Appimages.calender,
                        ishow: true,
                        color: AppColors.forwardColor,
                      ),
                      SizedBox(height: 50 * scaleFactor), 
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

