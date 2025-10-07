import 'package:get/get.dart';
import '../api_models/user_model.dart';
import '../api_services/user_service.dart';

class UserShowController extends GetxController {
  /// Holds all users fetched from API
  var allUsers = <UserModel>[].obs;

  /// Loading state
  var isLoading = false.obs;

  /// Search text
  var searchText = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers(); // initial fetch when controller created
  }

  @override
  void onReady() {
    super.onReady();
    fetchUsers(); // 🔄 refresh whenever screen is opened
  }

  /// Fetch all users from API
  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      print("🔄 Starting fetchUsers...");
      final users = await UserService.fetchUsers();
      allUsers.assignAll(users);
      print("✅ Users fetched: ${allUsers.length}");
    } catch (e) {
      print("❌ Error fetching users: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Manual refresh, can be called after adding/deleting a user
  Future<void> refreshUsers() async {
    await fetchUsers();
  }

  /// 🔎 Filtered list based on role + search text
  List<UserModel> filteredUsers(String role) {
    return allUsers
        .where((u) => u.role.toLowerCase() == role.toLowerCase() ||
        (role == "admin" &&
            (u.role.toLowerCase() == "administrator" ||
                u.role.toLowerCase() == "admin")))
        .where((u) =>
    u.name.toLowerCase().contains(searchText.value.toLowerCase()) ||
        u.email.toLowerCase().contains(searchText.value.toLowerCase()))
        .toList();
  }
}
