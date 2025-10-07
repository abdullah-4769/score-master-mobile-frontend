import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/login_textfield.dart';
import '../../api/api_controllers/register_controller.dart';
import '../../api/api_models/registration_model.dart';
import '../FacilitateFolder/aa.dart';

class CreateNewSessionHeader extends StatefulWidget {
  const CreateNewSessionHeader({super.key});

  @override
  State<CreateNewSessionHeader> createState() => _CreateNewSessionHeaderState();
}

class _CreateNewSessionHeaderState extends State<CreateNewSessionHeader> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RegistrationController registrationController =
  Get.put(RegistrationController());

  int selectedRoleId = 2; // default facilitator
  String selectedRoleText = "facilitator";

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    const double baseWidth = 375.0;
    final double scaleFactor = screenWidth / baseWidth;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GradientBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 30 * scaleFactor),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        SizedBox(height: 20 * scaleFactor),
                        SizedBox(
                          height: 50 * scaleFactor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
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
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 22 * scaleFactor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "add_ne".tr,
                                      style: const TextStyle(
                                        color: AppColors.blueColor,
                                      ),
                                    ),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Color(0xff8DC046),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            bottomLeft: Radius.circular(30),
                                          ),
                                        ),
                                        child: Text(
                                          "w_text".tr,
                                          style: TextStyle(
                                            color: AppColors.blueColor,
                                            fontSize: 22 * scaleFactor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: AppColors.forwardColor,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 4.0,
                                            right: 10.0,
                                          ),
                                          child: Text(
                                            selectedRoleText.tr,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22 * scaleFactor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          Appimages.group,
                          width: 208 * scaleFactor,
                          height: 181 * scaleFactor,
                        ),
                        SizedBox(height: 10 * scaleFactor),

                        /// Name
                        LoginTextfield(
                          text: "enter_player_name".tr,
                          controller: nameController,
                          fontsize: 18 * scaleFactor,
                          ishow: true,
                          validator: (val) =>
                          val == null || val.isEmpty ? "name_required".tr : null,
                        ),
                        SizedBox(height: 9 * scaleFactor),

                        /// Email
                        LoginTextfield(
                          text: "enter_player_email".tr,
                          controller: emailController,
                          fontsize: 18 * scaleFactor,
                          ishow: true,
                          validator: (val) => val == null || !GetUtils.isEmail(val)
                              ? "valid_email".tr
                              : null,
                        ),
                        SizedBox(height: 9 * scaleFactor),

                        /// Password
                        LoginTextfield(
                          text: "enter_password".tr,
                          controller: passwordController,
                          fontsize: 18 * scaleFactor,
                          ishow: true,
                          validator: (val) => val == null || val.length < 6
                              ? "password_min_length".tr
                              : null,
                        ),
                        SizedBox(height: 9 * scaleFactor),

                        /// Role Dropdown
                        Center(
                          child: DropdownButtonFormField<int>(
                            value: selectedRoleId,
                            items: [
                              DropdownMenuItem(
                                value: 2,
                                child: Text("facilitator".tr),
                              ),
                              DropdownMenuItem(
                                value: 3,
                                child: Text("player".tr),
                              ),
                            ],
                            onChanged: (val) {
                              setState(() {
                                selectedRoleId = val!;
                                selectedRoleText =
                                val == 2 ? "facilitator" : "player";
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(25 * scaleFactor),
                                borderSide: BorderSide(
                                  color: AppColors.selectLangugaeColor
                                      .withOpacity(0.1),
                                  width: 2 * scaleFactor,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16 * scaleFactor,
                                vertical: 16 * scaleFactor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40 * scaleFactor),

                        /// Save button
                        Obx(
                              () => registrationController.isLoading.value
                              ? const CircularProgressIndicator()
                              : LoginButton(
                            fontSize: 20,
                            text: "save".tr,
                            ishow: true,
                            image: Appimages.save,
                                onTap: () async {
                                  if (nameController.text.isEmpty ||
                                      emailController.text.isEmpty ||
                                      passwordController.text.isEmpty) {
                                    Get.snackbar(
                                      "error".tr,
                                      "fill_all_fields".tr,
                                      backgroundColor: AppColors.forwardColor,
                                      colorText: AppColors.whiteColor,
                                    );
                                    return;
                                  }

                                  final newUser = RegistrationModel(
                                    name: nameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    roleId: selectedRoleId,
                                    role: selectedRoleText,
                                  );

                                  final success = await registrationController.register(newUser, isAdmin: true);

                                  if (success) {
                                    // Clear fields
                                    nameController.clear();
                                    emailController.clear();
                                    passwordController.clear();
                                  }
                                },

                              ),
                        ),
                        SizedBox(height: 13 * scaleFactor),

                        /// Cancel button
                        LoginButton(
                          fontSize: 20,
                          text: "cancel".tr,
                          color: AppColors.forwardColor,
                          onTap: () => Get.back(),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
