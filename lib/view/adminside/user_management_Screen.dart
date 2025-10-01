
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/components/adminside/user_administrate_side.dart';
import 'package:scorer/components/adminside/user_facilitate_side.dart';
import 'package:scorer/components/adminside/user_managemnet_stack_container.dart';
import 'package:scorer/components/adminside/user_player_Side.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/controllers/user_managment_controller.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';
import 'package:scorer/widgets/add_one_Container.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/create_container.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/setting_container.dart';

class UserManagementScreen extends StatelessWidget {
  final UserManagmentController controller = Get.put(UserManagmentController());
  final List<String> tabs = [
  "players".tr,
  "facilitator".tr,
  "administrator".tr,
];
  final List<Widget> screens = [
    UserPlayerSide(),
    UserFacilitateSide(),
    UserAdministrateSide(),
  ];

  UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    
    
    const double baseWidth = 414.0;
    final double scaleFactor = screenWidth / baseWidth;

    return GradientBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 32 * scaleFactor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              Appimages.prince2,
                              width: 62 * scaleFactor,
                              height: 83 * scaleFactor,
                            ),
                            Row(
                              children: [
                                SettingContainer(icons: Icons.settings),
                                SizedBox(width: 6 * scaleFactor),
                                SettingContainer(
                                  icons: Icons.notifications,
                                  ishow: true,
                                ),
                                SizedBox(width: 6 * scaleFactor),
                                AddOneContainer(icon: Icons.add,
                                onTap: () => Get.toNamed(RouteName.createNewSessionHeader),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 21 * scaleFactor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(""),
                       CreateContainer(text: "add".tr)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32 * scaleFactor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BoldText(
                           text: "users_management".tr,
                          fontSize: 16 * scaleFactor,
                          selectionColor: AppColors.blueColor,
                        ),
                        MainText(
                          text: "securely_manage_roles".tr,
                          fontSize: 14 * scaleFactor,
                          height: 1.4,
                        ),
                        SizedBox(height: 23 * scaleFactor),
                        Container(
                          width: 336 * scaleFactor,
                          height: 53 * scaleFactor,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            border: Border.all(color: AppColors.searchBorder, width: 1 * scaleFactor),
                            borderRadius: BorderRadius.circular(12 * scaleFactor),
                          ),
                          child: TextFormField(
                            cursorColor: AppColors.blackColor,
                            decoration: InputDecoration(
                             hintText: "search_players".tr,
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 10 * scaleFactor),
                                child: Icon(Icons.search, color: AppColors.forwardColor),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12 * scaleFactor),
                                borderSide: BorderSide.none,
                              ),
                              hintStyle: TextStyle(fontSize: 14 * scaleFactor),
                            ),
                          ),
                        ),
                        SizedBox(height: 18 * scaleFactor),
                        Obx(() {
                          double totalWidth = screenWidth - (32 * 2 * scaleFactor);
                          double tabWidth = totalWidth / tabs.length;
                          double left = controller.selectedIndex.value * tabWidth;
                          
                          return UserManagementStackContainer(scaleFactor: scaleFactor, totalWidth: totalWidth, left: left, tabWidth: tabWidth, tabs: tabs, controller: controller);
                        }),
                      ],
                    ),
                  ),
                  Obx(
                    () => screens[controller.selectedIndex.value],
                  ),
                ],
              ),
            ),
          ),
        );
}}
