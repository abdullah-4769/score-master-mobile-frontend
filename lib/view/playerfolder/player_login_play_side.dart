import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart' show Appimages, aa;
import 'package:scorer/constants/routename.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/login_textfield.dart';



class PlayerLoginPlaySide extends StatelessWidget {
  const PlayerLoginPlaySide({super.key});

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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32 * widthScaleFactor),
            child: Column(
              children: [
                SizedBox(height: 20 * heightScaleFactor),
                SizedBox(
                  height: 50 * heightScaleFactor,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
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
  child: BoldText(
    text: "player_nickname".tr,
    selectionColor: AppColors.blueColor,
    fontSize: 24 * widthScaleFactor,
  ),
),
                    ],
                  ),
                ),
                SizedBox(height: 50 * heightScaleFactor), 
                Image.asset(
                  Appimages.player2,
                  width: 150 * widthScaleFactor, 
                  height: 150 * heightScaleFactor, 
                ),
                SizedBox(height: 23 * heightScaleFactor),
               
LoginTextfield(
  ishow: false,
  fontsize: ResponsiveFont.getFontSizeCustom(
    defaultSize: 21*widthScaleFactor,
    smallSize: 18*widthScaleFactor
  ),
  text: "enter_nickname".tr,
),

SizedBox(height: 9 * heightScaleFactor),

LoginTextfield(
  fontsize: ResponsiveFont.getFontSizeCustom(
    defaultSize: 21*widthScaleFactor,

    smallSize: 18*widthScaleFactor
  ),
  text: "enter_team_nickname".tr, ishow: false,
),               SizedBox(height: 23 * heightScaleFactor),
                LoginButton(
                  onTap: ()=>Get.toNamed(RouteName.playerDashboardScreen2),
                  text: "continue".tr,
                  color: AppColors.forwardColor,
                  height: 50 * heightScaleFactor, 
                  width: double.infinity,
                  fontSize: 16 * widthScaleFactor, 
                  radius: 12 * widthScaleFactor, 
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}