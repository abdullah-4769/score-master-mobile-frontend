import 'package:get/get.dart';

class GameSelectController extends GetxController {
  // Correct type: RxInt
   RxInt currentPhase = 0.obs;   // 0 = nothing complete, 1 = first complete, 2 = second complete
  RxInt clickCount = 0.obs;     // Track clicks for Back button

  void nextPhase() {
    if (currentPhase.value < 2) {
      currentPhase.value += 1;
    }
    clickCount.value += 1;
    isCompleted.value = true;
  }

  void pause() {
    isCompleted.value = false;
  }

  void back() {
    currentPhase.value = 0;
    clickCount.value = 0;
    isCompleted.value = false;
  }

  RxBool isCompleted = false.obs;
  
   // 0 = nothing completed, 1 = first complete, 2 = second complete

  final RxInt gamevalue = 0.obs;

  void gameSelect(int index) {
    gamevalue.value = index; // update the value
  }
}
