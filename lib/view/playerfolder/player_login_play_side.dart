import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart' show Appimages;
import 'package:scorer/constants/routename.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/login_textfield.dart';
import '../../api/api_controllers/player_team_controller.dart';
import '../../shared_preferences/shared_preferences.dart';
import '../FacilitateFolder/aa.dart';

class PlayerLoginPlaySide extends StatefulWidget {
  const PlayerLoginPlaySide({super.key});

  @override
  State<PlayerLoginPlaySide> createState() => _PlayerLoginPlaySideState();
}

class _PlayerLoginPlaySideState extends State<PlayerLoginPlaySide> {
  final TextEditingController nicknameController = TextEditingController();
  final PlayerTeamController teamController = Get.put(PlayerTeamController());

  Future<void> _createTeamAndProceed() async {
    final nickname = nicknameController.text.trim();

    if (nickname.isEmpty) {
      Get.snackbar("Error", "Please enter a nickname");
      return;
    }

    // ✅ Get gameFormatId from join session response stored in SharedPrefs
    final gameFormatId = await SharedPrefServices.getGameId();
    if (gameFormatId == null) {
      Get.snackbar("Error", "Game Format ID missing. Cannot create team.");
      return;
    }

    // Call API
    await teamController.createTeam(
      nickname: nickname,
      gameFormatId: gameFormatId,
    );

    if (teamController.team.value != null) {
      await SharedPrefServices.saveTeamId(teamController.team.value!.id);
      Get.toNamed(RouteName.playerDashboardScreen2);
    } else {
      Get.snackbar("Error", "Failed to create/join team. Try again.");
    }
  }

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
                          onTap: () => Get.back(),
                          child: SvgPicture.asset(
                            Appimages.arrowback,
                            colorFilter: ColorFilter.mode(
                              AppColors.forwardColor,
                              BlendMode.srcIn,
                            ),
                            width: 24.w,
                            height: 20.h,
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
                  controller: nicknameController,
                  ishow: false,
                  fontsize: ResponsiveFont.getFontSizeCustom(
                    defaultSize: 21 * widthScaleFactor,
                    smallSize: 18 * widthScaleFactor,
                  ),
                  text: "enter_nickname".tr,
                ),
                SizedBox(height: 23 * heightScaleFactor),
                Obx(() {
                  return LoginButton(
                    onTap: _createTeamAndProceed,
                    text: teamController.isLoading.value
                        ? "Loading..."
                        : "continue".tr,
                    color: AppColors.forwardColor,
                    height: 50 * heightScaleFactor,
                    width: double.infinity,
                    fontSize: 16 * widthScaleFactor,
                    radius: 12 * widthScaleFactor,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
