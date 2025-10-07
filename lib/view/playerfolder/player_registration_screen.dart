import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/responsive_fonts.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import '../../api/api_controllers/register_controller.dart';
import '../../api/api_models/registration_model.dart';
import '../../utils/validator.dart';
import '../../widgets/bold_text.dart';
import '../../widgets/login_button.dart';
import '../../widgets/login_textfield.dart';
import '../FacilitateFolder/aa.dart';

class PlayerRegistrationScreen extends StatelessWidget {
  PlayerRegistrationScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RegistrationController regController = Get.put(RegistrationController());

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
                              colorFilter: ColorFilter.mode(AppColors.forwardColor, BlendMode.srcIn),
                            ),
                          ),
                        ),
                        Center(
                          child: BoldText(
                            text: "player_registration".tr,
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
                    text: "enter_full_name".tr,
                    controller: nameController,
                    validator: Validators.isRequired,
                    ishow: true,
                  ),
                  SizedBox(height: 9 * heightScaleFactor),
                  LoginTextfield(
                    text: "enter_email".tr,
                    controller: emailController,
                    validator: Validators.email,
                    ishow: true,
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

                  Obx(() => regController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : LoginButton(
                    text: "register".tr,
                    fontSize: 20.sp,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        final user = RegistrationModel(
                          name: nameController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          role: "player",
                          roleId: 3,
                        );
                        regController.register(user);
                      }
                    },
                  )),
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
