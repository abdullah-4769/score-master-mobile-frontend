import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/login_textfield.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';
import '../../api/api_controllers/login_controllers.dart';
import '../../utils/validator.dart';
import '../../constants/routename.dart';

class PlayerLoginScreen extends StatelessWidget {
  PlayerLoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final LoginController authController = Get.put(LoginController());

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
            padding: EdgeInsets.symmetric(horizontal: 32 * widthScaleFactor),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40 * heightScaleFactor),

                  // Back Arrow + Title
                  SizedBox(
                    height: 50,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () => Get.back(),
                            child: SvgPicture.asset(
                              Appimages.arrowback,
                              width: 24.w,
                              height: 20.h,
                              colorFilter: ColorFilter.mode(
                                  AppColors.forwardColor, BlendMode.srcIn),
                            ),
                          ),
                        ),
                        Center(
                          child: BoldText(
                            text: "player_login".tr,
                            fontSize: ResponsiveFont.getFontSizeCustom(
                              defaultSize: 22 * widthScaleFactor,
                              smallSize: 17 * widthScaleFactor,
                            ),
                            selectionColor: AppColors.blueColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20 * heightScaleFactor),
                  Image.asset(Appimages.player2, height: 180 * heightScaleFactor),
                  SizedBox(height: 23 * heightScaleFactor),

                  LoginTextfield(
                    text: "enter_email".tr,
                    controller: emailController,
                    ishow: true,
                    validator: Validators.email,
                  ),
                  SizedBox(height: 9 * heightScaleFactor),
                  LoginTextfield(
                    text: "enter_password".tr,
                    controller: passwordController,
                    ishow: true,
                    isPassword: true,
                    validator: Validators.password,
                  ),

                  SizedBox(height: 30 * heightScaleFactor),
                  Obx(() => authController.isLoading.value
                      ? Center(child: const CircularProgressIndicator())
                      : LoginButton(
                    text: "login".tr,
                    fontSize: 20.sp,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        authController.login(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                      }
                    },
                  )),

                  SizedBox(height: 15 * heightScaleFactor),

                  // "Don't have an account? Sign Up"
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteName.playerRegistrationScreen);
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "dont_have_account".tr + " ", // Translation key
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: "signup".tr, // Translation key
                              style: TextStyle(
                                color: AppColors.forwardColor, // green
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
