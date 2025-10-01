import 'package:get/get.dart';

class StageController extends GetxController {
  var isCompleted = false.obs; // false = orange, true = green


    var selectedIndex= 0.obs;
  void changeTab(int index){
    selectedIndex.value= index;
  }
}
