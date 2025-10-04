
import 'package:get/get.dart';
import 'package:scorer/shared_preferences/shared_preferences.dart';

class UserManagmentController extends GetxController {
  var isCompleted = false.obs;
  var userId = 0.obs;
  var selectedIndex = 0.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadUserId();
  }
  
  Future<void> loadUserId() async {
    final id = await SharedPrefServices.getUserId();
    if (id != null) {
      userId.value = id;
    }
  }
  
  void changeTab(int index) {
    selectedIndex.value = index;
  }
  
  int? getCurrentUserId() {
    return userId.value > 0 ? userId.value : null;
  }
}
