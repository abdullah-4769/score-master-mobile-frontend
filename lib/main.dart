
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scorer/bottom_navigation.dart';
import 'package:scorer/constants/approutes.dart';
import 'package:scorer/controllers/facil_dashboard_controller.dart';
import 'package:scorer/localization/app_translation.dart';
import 'package:scorer/localization/translation_Service.dart';
import 'package:scorer/view/FacilitateFolder/end_Session_screen.dart';
import 'package:scorer/view/FacilitateFolder/evaluate_response_Screen.dart';
import 'package:scorer/view/FacilitateFolder/evaluate_response_Screen2.dart';
import 'package:scorer/view/FacilitateFolder/facilitator_dashboard.dart';
import 'package:scorer/view/FacilitateFolder/over_view__option_Screen.dart';
import 'package:scorer/view/FacilitateFolder/player_login_screen.dart';
import 'package:scorer/view/FacilitateFolder/splash_screen.dart';
import 'package:scorer/view/adminside/create_game_admin.dart';
import 'package:scorer/view/adminside/game_screen_Admin_Side.dart';
import 'package:scorer/view/playerfolder/player_login_play_side.dart';
import 'package:scorer/view/playerfolder/submit_response_Screen2.dart';
import 'package:get_storage/get_storage.dart';

import 'api/api_controllers/question_controller.dart';
import 'api/api_controllers/session_controller.dart';
import 'controllers/bottom_nav_controller.dart';
import 'controllers/overview_controller.dart';
void main() async {

  Get.put(QuestionController());
  Get.put(BottomNavController(), permanent: true);


  Get.put(SessionController());

  WidgetsFlutterBinding.ensureInitialized();

  final savedLocale = await TranslationService().getSavedLocale();
  runApp(MyApp(locale: savedLocale));
  await GetStorage.init();


}

class MyApp extends StatelessWidget {
  final Locale locale;
  const MyApp({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(

          debugShowCheckedModeBanner: false,
          translations: AppTranslations(),
          locale: locale,
          getPages: AppRoutes.getAppRoutes(),
          fallbackLocale: const Locale('en', 'US'),
          home: SplashScreen(),
        );
      },
    );
  }
}
