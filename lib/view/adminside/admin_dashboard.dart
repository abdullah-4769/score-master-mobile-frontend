import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/components/adminside/admin_Container_tack_container.dart';
import 'package:scorer/components/adminside/admin_active_Session.dart';
import 'package:scorer/components/adminside/admin_schedule_session.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/controllers/facil_dashboard_controller.dart';
import 'package:scorer/api/api_controllers/active_schedule_controller.dart';
import 'package:scorer/api/api_controllers/session_action_controller.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/setting_container.dart';
import 'package:scorer/shared_preferences/shared_preferences.dart';

class AdminDashboard extends StatelessWidget {
  final FacilDashboardController controller = Get.put(FacilDashboardController());
  final ActiveAndSessionController activeSessionController = Get.put(ActiveAndSessionController());
  final SessionActionController sessionActionController = Get.put(SessionActionController());

  AdminDashboard({super.key});

  final List<Widget> screens = [
    const AdminActiveSession(),
    const AdminScheduleSession(),
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    const double baseHeight = 812.0;
    const double baseWidth = 414.0;
    final double heightScaleFactor = screenHeight / baseHeight;
    final double widthScaleFactor = screenWidth / baseWidth;

    return GradientBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top header
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 32 * widthScaleFactor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      Appimages.prince2,
                      width: 62 * widthScaleFactor,
                      height: 83 * heightScaleFactor,
                    ),
                    Row(
                      children: [
                        SettingContainer(icons: Icons.settings),
                        SizedBox(width: 6 * widthScaleFactor),
                        SettingContainer(
                          icons: Icons.notifications,
                          ishow: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20 * heightScaleFactor),

              /// Welcome texts + stacked container (contains TabBar)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 32 * widthScaleFactor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<String?>(
                      future: SharedPrefServices.getUserName(),
                      builder: (context, snapshot) {
                        final name = snapshot.data ?? "Admin";
                        return Row(
                          children: [
                            BoldText(
                              text: "hello_admin".tr,
                              fontSize: 16 * heightScaleFactor,
                              selectionColor: AppColors.blueColor,
                            ),
                            BoldText(
                              text: ", ${name.capitalizeFirst}!",
                              fontSize: 16 * heightScaleFactor,
                              selectionColor: AppColors.blueColor,
                            ),
                          ],
                        );
                      },
                    ),
                    MainText(
                      text: "welcome_admin".tr,
                      fontSize: 14 * heightScaleFactor,
                      height: 1.4,
                    ),
                    SizedBox(height: 23 * heightScaleFactor),

                    // This component already contains the TabBar
                    AdminContainerStackContainer(
                      heightScaleFactor: heightScaleFactor,
                      widthScaleFactor: widthScaleFactor,
                      controller: controller,
                    ),
                  ],
                ),
              ),

              /// Display the selected screen based on tab
              Obx(() => screens[controller.selectedIndex.value]),
            ],
          ),
        ),
      ),
    );
  }
}