import 'package:get/get_navigation/get_navigation.dart';
import 'package:scorer/bottom_navigation.dart';
import 'package:scorer/constants/routename.dart';
import 'package:scorer/view/FacilitateFolder/admin_login_screen.dart';
import 'package:scorer/view/FacilitateFolder/choose_your_role_Screen.dart';
import 'package:scorer/view/FacilitateFolder/create_new_Session_Screen.dart';
import 'package:scorer/view/FacilitateFolder/end_Session_screen.dart';
import 'package:scorer/view/FacilitateFolder/evaluate_response_Screen.dart';
import 'package:scorer/view/FacilitateFolder/evaluate_response_Screen2.dart';
import 'package:scorer/view/FacilitateFolder/facil_login_Screen.dart';
import 'package:scorer/view/FacilitateFolder/facilitator_dashboard.dart';
import 'package:scorer/view/FacilitateFolder/over_view__option_Screen.dart';
import 'package:scorer/view/FacilitateFolder/player_login_screen.dart';
import 'package:scorer/view/FacilitateFolder/splash_screen.dart';
import 'package:scorer/view/FacilitateFolder/start_Screen1.dart';
import 'package:scorer/view/FacilitateFolder/start_Screen2.dart';
import 'package:scorer/view/FacilitateFolder/start_Screen3.dart';
import 'package:scorer/view/FacilitateFolder/start_screen.dart';
import 'package:scorer/view/FacilitateFolder/view_Score_Screen.dart';
import 'package:scorer/view/FacilitateFolder/view_responses_Screen.dart';
import 'package:scorer/view/adminside/admin_create_new_session_Screen.dart'
    show AdminCreateNewSessionScreen;
import 'package:scorer/view/adminside/admin_dashboard.dart';
import 'package:scorer/view/adminside/admin_overview_option_screens.dart';

import 'package:scorer/view/adminside/create_new_Session_Screen_admin_side.dart';
import 'package:scorer/view/adminside/create_game_admin.dart';
import 'package:scorer/view/adminside/game_screen_Admin_Side.dart';
import 'package:scorer/view/adminside/user_admin_detailed_scree.dart';
import 'package:scorer/view/adminside/user_facilitate_detailed_scree.dart';
import 'package:scorer/view/adminside/user_management_Screen.dart';
import 'package:scorer/view/adminside/user_player_detailed_scree.dart';
import 'package:scorer/view/playerfolder/game_start1_screen.dart';
import 'package:scorer/view/playerfolder/player_dashboard.dart';
import 'package:scorer/view/playerfolder/player_dashboard_Screen2.dart';
import 'package:scorer/view/playerfolder/player_leader_board_Screen2.dart';
import 'package:scorer/view/playerfolder/player_leaderboard_screen.dart';
import 'package:scorer/view/playerfolder/player_login_play_side.dart';
import 'package:scorer/view/playerfolder/submit_response_Screen.dart';
import 'package:scorer/view/playerfolder/submit_response_Screen2.dart';
import '../view/adminside/phases_create_game.dart';
import '../view/playerfolder/player_registration_screen.dart';

// import 'package:scorer/view/startscreen/evaluate_response_Screen2.dart';
// import 'package:scorer/view/startscreen/start_Screen1.dart';
// import 'package:scorer/view/startscreen/start_screen.dart';

class AppRoutes {




  static getAppRoutes() => [
  GetPage(
  name: RouteName.playerRegistrationScreen,
  page: () => PlayerRegistrationScreen(),
  transition: Transition.cupertino,
  ),

    GetPage(
      name: RouteName.phaseCreateGame,
      page: () => PhasesCreateGame(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: RouteName.splashScreen,
      page: () => SplashScreen(),
      transition: Transition.cupertino,
    ),




    GetPage(
      name: RouteName.startScreen,
      page: () => StartScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.startScreen1,
      page: () => StartScreen1(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.adminLoginScreen,
      page: () => AdminLoginScreen(),
      transition: Transition.cupertino,
    ),



    GetPage(
      name: RouteName.chooseYourRoleScreen,
      page: () => ChooseYourRoleScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.createNewSessionScreen,
      page: () => CreateNewSessionScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.endSessionScreen,
      page: () => EndSessionScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.evaluateResponseScreen,
      page: () => EvaluateResponseScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.evaluateResponseScreen2,
      page: () => EvaluateResponseScreen2(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.facilLoginScreen,
      page: () => FacilLoginScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.facilitatorDashboard,
      page: () => FacilitatorDashboard(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.overViewOptionScreen,
      page: () => OverViewOptionScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.playerLoginScreen,
      page: () => PlayerLoginScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.startScreen2,
      page: () => StartScreen2(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.startScreen3,
      page: () => StartScreen3(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.viewResponsesScreen,
      page: () => ViewResponsesScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.viewScoreScreen,
      page: () => ViewScoreScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.adminCreateNewSessionScreen,
      page: () => AdminCreateNewSessionScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.adminDashboard,
      page: () => AdminDashboard(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.adminOverviewOptionScreens,
      page: () => AdminOverviewOptionScreens(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.createNewSessionHeader,
      page: () => CreateNewSessionHeader(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.gameScreenAdminSide,
      page: () => GameScreenAdminSide(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.game2Screen,
      page: () => Game2Screen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.userAdminDetailedScree,
      page: () => UserAdminDetailedScree(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.userFacilitateDetailedScree,
      page: () => UserFacilitateDetailedScree(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.userManagementScreen,
      page: () => UserManagementScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.userPlayerDetailedScree,
      page: () => UserPlayerDetailedScree(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.gameStart1Screen,
      page: () => GameStart1Screen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.playerDashboardScreen2,
      page: () => PlayerDashboardScreen2(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.playerDashboard,
      page: () => PlayerDashboard(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.playerLeaderBoardScreen2,
      page: () => PlayerLeaderBoardScreen2(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.playerLeaderboardScreen,
      page: () => PlayerLeaderboardScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.playerLoginPlaySide,
      page: () => PlayerLoginPlaySide(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.submitResponseScreen,
      page: () => SubmitResponseScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.submitResponseScreen2,
      page: () => SubmitResponseScreen2(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteName.bottomNavigation,
      page: () => BottomNavigation(),
      transition: Transition.cupertino,
    ),
  ];
}
