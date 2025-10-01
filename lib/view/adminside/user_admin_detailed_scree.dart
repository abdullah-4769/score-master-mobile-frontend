

















































        


























        






        













































































































                        















                         































          
                    















































     

      
      
      
        







import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/account_info_column.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/custom_dashboard_container.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/useable_container.dart';
import 'package:scorer/widgets/useable_textrow.dart';

class UserAdminDetailedScree extends StatelessWidget {
  const UserAdminDetailedScree({super.key});

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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * widthScaleFactor),
              child: Column(
                children: [
                  SizedBox(height: 20 * heightScaleFactor),
                  SizedBox(
                    height: 135 * heightScaleFactor,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 0,
                          top: 20 * heightScaleFactor,
                          child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: SvgPicture.asset(
                                Appimages.arrowback,
                                colorFilter: ColorFilter.mode(
                                    AppColors.forwardColor, BlendMode.srcIn),
                                width: 24 .w,
                                height: 20 .h,
                              ),
                            ),
                        ),
                        Center(
                          child: Image.asset(
                            Appimages.prince2,
                            width: 101 * widthScaleFactor,
                            height: 135 * heightScaleFactor,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BoldText(
                    text: "John Smith",
                    fontSize: 16 * widthScaleFactor,
                    selectionColor: AppColors.blueColor,
                  ),
                  MainText(
                    text: "john.smith@company.com",
                    fontSize: 14 * widthScaleFactor,
                    height: 1.4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MainText(
                                            text: "last_login".tr,

                        fontSize: 14 * widthScaleFactor,
                        color: AppColors.redColor,
                      ),
                      SizedBox(width: 3 * widthScaleFactor),
                      Container(
                        width: 9 * widthScaleFactor,
                        height: 9 * widthScaleFactor,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.redColor,
                        ),
                      ),
                      SizedBox(width: 3 * widthScaleFactor),
                      MainText(
                        text: "Jan 15, 2025",
                        fontSize: 14 * widthScaleFactor,
                        color: AppColors.redColor,
                      ),
                    ],
                  ),
                  UseableContainer(
                                      text: "active".tr,

                    
                    color: AppColors.forwardColor,
                    height: 20* heightScaleFactor,
                  ),
                  SizedBox(height: 24 * heightScaleFactor),
                  Padding(
                    
                    padding: EdgeInsets.symmetric(horizontal: 12 * widthScaleFactor),

                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: 105,
                            height: 116 * heightScaleFactor, 
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.greyColor, width: 1.7 * widthScaleFactor),
                              borderRadius: BorderRadius.circular(24 * widthScaleFactor),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BoldText(
                                  text: "47",
                                  selectionColor: AppColors.redColor,
                                  fontSize: 0.06 * screenWidth,
                                ),
                                BoldText(
                                  textAlign: TextAlign.center,
                                                                                                 text: "sessions_led".tr,

                                  fontSize: 0.04 * screenWidth,
                                  selectionColor: AppColors.blueColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10 * widthScaleFactor),
                        Expanded(
                          child: Container(
                             width: 105,
                            height: 116 * heightScaleFactor, 
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.greyColor, width: 1.7 * widthScaleFactor),
                              borderRadius: BorderRadius.circular(24 * widthScaleFactor),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BoldText(
                                  text: "285",
                                  selectionColor: AppColors.forwardColor,
                                  fontSize: 0.06 * screenWidth,
                                ),
                                BoldText(
                                  textAlign: TextAlign.center,
                                                                                        text:  "manage_players".tr,

                                  fontSize: 0.04 * screenWidth,
                                  selectionColor: AppColors.blueColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10 * widthScaleFactor),
                        Expanded(
                          child: Container(
                             width: 105,
                            height: 116 * heightScaleFactor,  
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.greyColor, width: 1.7 * widthScaleFactor),
                              borderRadius: BorderRadius.circular(24 * widthScaleFactor),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BoldText(
                                  text: "96%",
                                  selectionColor: AppColors.redColor,
                                  fontSize: 0.06 * screenWidth,
                                ),
                                BoldText(
                                  textAlign: TextAlign.center,
                                                                                                 text: "success_rate".tr,

                                  fontSize: 0.04 * screenWidth,
                                  selectionColor: AppColors.blueColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 33 * heightScaleFactor),
                AccountInfoClumn(widthScaleFactor: widthScaleFactor, heightScaleFactor: heightScaleFactor) , SizedBox(height: 20 * heightScaleFactor),


                  Container(
                    height: 183,
                    width: 376,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.greyColor,width: 1.5),
                      borderRadius: BorderRadius.circular(24)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
SizedBox(height: 20,),
MainText(text: "recent_activity".tr,fontSize: 14,),
SizedBox(height: 10,),

 UseableTextrow(
                                    height: 1,
                    color: AppColors.forwardColor,
                    text: "Alex submitted response • 1m ago"),
                    SizedBox(height: 7,),
                     UseableTextrow(
                                    height: 1,
                    color: AppColors.forwardColor2,
                    text: "Sarah joined team discussion • 2m ago"),
                      SizedBox(height: 7,),
                     UseableTextrow(
                                    height: 1,
                    color: AppColors.forwardColor3,
                    text: "Mike went inactive • 5m ago"),


                          
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 20 * heightScaleFactor),
                    Container(
                    height: 183,
                    width: 376,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.greyColor,width: 1.5),
                      borderRadius: BorderRadius.circular(24)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
SizedBox(height: 20,),
MainText(text:  "current_permissions".tr,fontSize: 14,),
SizedBox(height: 10,),

 UseableTextrow(
                           ishow: true,         height: 1,
                    color: AppColors.forwardColor,
                     text: "manage_users".tr,),
                    SizedBox(height: 7,),
                     UseableTextrow(ishow: true,
                                    height: 1,
                    color: AppColors.forwardColor2,
                   text: "create_sessions".tr,),
                      SizedBox(height: 7,),
                     UseableTextrow(ishow: true,
                                    height: 1,
                    color: AppColors.forwardColor3,
                     text: "view_analytics".tr,),


                          
                        ],
                      ),
                    ),
                  ),
                 
                  SizedBox(height: 20 * heightScaleFactor),

                  BoldText(
                                                       text:  "recent_sessions".tr,

                    selectionColor: AppColors.blueColor,
                    fontSize: 16 * widthScaleFactor,
                  ),
                  SizedBox(height: 20 * heightScaleFactor),

                  CustomDashboardContainer(
                    mainWidth: 376 * widthScaleFactor,
                    right: 10 * widthScaleFactor,
                    mainHeight: 228 * heightScaleFactor,
                    color2: AppColors.forwardColor,
                    color1: AppColors.orangeColor,
                    heading: "Team Building Workshop",
                    text1: "Phase 2",
                    height: 5* heightScaleFactor,
                    text2: "active".tr,
                    text6: "2nd Position",
                    smallImage: Appimages.Crown,
                    description: "Eranove Odyssey sessions immerse teams in fast-paced, collaborative challenges with real-time scoring and progression.",
                    icon1: Icons.play_arrow,
                    text5: "12 Players",
                    isshow: true,
                  ),
                  SizedBox(height: 12 * heightScaleFactor),
                  CustomDashboardContainer(
                    mainWidth: 376 * widthScaleFactor,
                    right: 10 * widthScaleFactor,
                    mainHeight: 228 * heightScaleFactor,
                    color2: AppColors.forwardColor,
                    color1: AppColors.orangeColor,
                    heading: "Team Building Workshop",
                    text1: "Phase 2",
                    height: 5 * heightScaleFactor,
                    text2: "active".tr,
                    text6: "2nd Position",
                    smallImage: Appimages.Crown,
                    description: "Eranove Odyssey sessions immerse teams in fast-paced, collaborative challenges with real-time scoring and progression.",
                    icon1: Icons.play_arrow,
                    text5: "12 Players",
                    isshow: true,
                  ),
                  SizedBox(height: 42 * heightScaleFactor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
