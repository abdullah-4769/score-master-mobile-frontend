import 'package:get/get.dart';

class FilterController extends GetxController {
  var selectedIndex = 0.obs; // clear name
  var selectedstage = 0.obs; // clear name


  void select(int newIndex) {
    selectedIndex.value = newIndex;
  }
    void selectStage(int newIndex) {
    selectedstage.value = newIndex;
  }
}
