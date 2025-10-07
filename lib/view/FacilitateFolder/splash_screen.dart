














































import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/view/FacilitateFolder/aa.dart';
import 'package:scorer/view/FacilitateFolder/start_screen.dart';

import '../../constants/routename.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    final box = GetStorage();
    String? token = box.read('token');
    String? role = box.read('role');



    Future.delayed(const Duration(seconds: 3), () {
     // Get.off(() =>  StartScreen());


      if (token != null && role != null) {
        if (role == "admin") {
          Get.offAllNamed(RouteName.bottomNavigation);
        } else if (role == "facilitator") {
          Get.offAllNamed(RouteName.facilitatorDashboard);
        } else if (role == "player") {
          Get.offAllNamed(RouteName.playerDashboard);
        }
      } else {
        Get.offAllNamed(RouteName.startScreen); // or main login screen
      }





    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GradientBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 50),

            
            Center(
              child: SvgPicture.asset(
                Appimages.splash,
                height: 184,
                width: 212,
              ),
            ),

            
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SvgPicture.asset(
                Appimages.bottom,
                width: 104,
                height: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
