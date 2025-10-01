// lib/controllers/bottom_nav_controller.dart
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  int get index => selectedIndex.value;

  void changeIndex(int i) => selectedIndex.value = i;
}
