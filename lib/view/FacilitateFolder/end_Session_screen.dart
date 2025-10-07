







































          














































































































































































































             




























             



























             























import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/custom_session_container.dart';
import 'package:scorer/components/custom_time_row.dart';
import 'package:scorer/components/phase_breakdown_container.dart';
import 'package:scorer/components/players_Row.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';

import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/players_container.dart';
import 'package:scorer/widgets/useable_container.dart';

class EndSessionScreen extends StatelessWidget {
  const EndSessionScreen({super.key});

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 30 * widthScaleFactor,
                        top: 20 * heightScaleFactor,
                        right: 30 * widthScaleFactor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BoldText(
                            text: "Eranove Odyssey – Team A",
                            selectionColor: AppColors.blueColor,
                            fontSize: 16 * widthScaleFactor,
                          ),
                          UseableContainer(
                            text: "completed".tr,
                            color: AppColors.forwardColor,
                            width: 85 .w,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15 * heightScaleFactor),
                      child: Image.asset(
                        Appimages.house1,
                        height: 85 * heightScaleFactor,
                        width: 100 * widthScaleFactor,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30 * widthScaleFactor),
                  child: Column(
                    children: [
                      Container(
                        height: 74 * heightScaleFactor,
                        width: 337 * widthScaleFactor,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.greyColor,
                            width: 1.7 * widthScaleFactor,
                          ),
                          borderRadius: BorderRadius.circular(24 * widthScaleFactor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 17 * widthScaleFactor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BoldText(
                                text: "export_by".tr,
                                fontSize: 20 .sp,
                              ),
                              Row(
                                children: [
                                  BoldText(
                                    text: "phase".tr,
                                    fontSize: 20 .sp,
                                  ),
                                  SizedBox(width: 7 * widthScaleFactor),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: AppColors.forwardColor,
                                    size: 24 * widthScaleFactor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 13 * heightScaleFactor),
                      LoginButton(
                fontSize: 20.sp,

                        text: "export_pdf".tr,
                        ishow: true,
                        image: Appimages.export,
                        color: AppColors.selectLangugaeColor,
                        
                      ),
                      SizedBox(height: 20 * heightScaleFactor),
                      SvgPicture.asset(
                        Appimages.Crown,
                        height: 60 * heightScaleFactor,
                        width: 60 * widthScaleFactor,
                      ),
                      SizedBox(height: 21 * heightScaleFactor),
                      BoldText(
                        text: "Eranove Odyssey – Team A",
                        fontSize: 16 * widthScaleFactor,
                        selectionColor: AppColors.blueColor,
                      ),
                      SizedBox(height: 5 * heightScaleFactor),
                      MainText(
                        text: "session_completed".tr,
                        fontSize: 14 * widthScaleFactor,
                      ),
                      SizedBox(height: 21 * heightScaleFactor),
                      CustomTimeRow(heightScaleFactor: heightScaleFactor, widthScaleFactor: widthScaleFactor),
                      SizedBox(height: 33 * heightScaleFactor),
                      SvgPicture.asset(
                        Appimages.tropy,
                        height: 60 * heightScaleFactor,
                        width: 60 * widthScaleFactor,
                      ),
                      SizedBox(height: 20 * heightScaleFactor),
                      MainText(
                        text: "rewards_unlocked".tr,
                        fontSize: 16 * widthScaleFactor,
                        fontFamily: "gotham",
                      ),
                      SizedBox(height: 16 * heightScaleFactor),
                      BoldText(
                       text: "strategic_thinker".tr,
                        fontSize: 16 * widthScaleFactor,
                        selectionColor: AppColors.blueColor,
                      ),
                      SizedBox(height: 12 * heightScaleFactor),
                      Image.asset(
                        Appimages.badge,
                        height: 147 * heightScaleFactor,
                        width: 158* widthScaleFactor,
                      ),
                      SizedBox(height: 10 * heightScaleFactor),
                      BoldText(
                        text: "badge".tr,
                        fontSize: 16 * widthScaleFactor,
                        selectionColor: AppColors.blueColor,
                      ),
                      SizedBox(height: 30 * heightScaleFactor),
                      CustomSessionContainer(heightScaleFactor: heightScaleFactor, widthScaleFactor: widthScaleFactor),
                      SizedBox(height: 100 * heightScaleFactor),
                      PlayersRow(isTeamSelected: false, topThree: [],),
                      SizedBox(height: 25 * heightScaleFactor),
                      PlayersContainers(
                        text1: "2",
                        text2: "Sarah J.",
                        image: Appimages.play2,
                        icon: Icons.keyboard_arrow_down_outlined,
                        iconColor: AppColors.brownColor,
                        text4: "2,890 pts",
                        ishow: true,
                        containerColor: AppColors.greyColor,
                        leftPadding: 20 * widthScaleFactor,
                      ),
                      SizedBox(height: 10 * heightScaleFactor),
                      PlayersContainers(
                        text1: "3",
                        text2: "Mike C.",
                        image: Appimages.play5,
                        icon: Icons.keyboard_arrow_down_outlined,
                        iconColor: AppColors.brownColor,
                        text4: "2,180 pts",
                        ishow: true,
                        containerColor: AppColors.orangeColor,
                        leftPadding: 20 * widthScaleFactor,
                      ),
                      SizedBox(height: 10 * heightScaleFactor),
                      PlayersContainers(
                        text1: "1",
                        text2: "Alex M.",
                        image: Appimages.facil2,
                        icon: Icons.keyboard_arrow_up_outlined,
                        iconColor: AppColors.arrowColor,
                        text4: "2,890 pts",
                        ishow: true,
                        containerColor: AppColors.yellowColor,
                        leftPadding: 20 * widthScaleFactor,
                      ),
                      SizedBox(height: 30 * heightScaleFactor),
                      CreateContainer(
                        fontsize2: ResponsiveFont.getFontSizeCustom(
                          defaultSize: 13*widthScaleFactor,
                          smallSize: 9*widthScaleFactor
                        ),
                       text: "view_full_ranking".tr,
                       
                        width: 148 * widthScaleFactor,
                      ),
                      SizedBox(height: 20 * heightScaleFactor),
                      PhaseBreakDownContainer(widthScaleFactor: widthScaleFactor, heightScaleFactor: heightScaleFactor),
                      SizedBox(height: 41 * heightScaleFactor),
                      LoginButton(
                        onTap: () {
  Get.toNamed(RouteName.createNewSessionScreen);
},
                        text: "create_new_session".tr,
                        ishow: true,
                        fontSize: 19.sp,

                        color: AppColors.redColor,
                        icon: Icons.add,
                        imageHeight: 35 .h,
                        imageWidth: 35 .w,
                      ),
                      SizedBox(height: 13 * heightScaleFactor),
                      LoginButton(
                        fontSize: 19.sp,
                        text: "share_results".tr,
                        color: AppColors.forwardColor,
                        image: Appimages.move,
                        ishow: true,
                        
                      ),
                      SizedBox(height: 40,)
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
