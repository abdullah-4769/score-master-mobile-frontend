import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/api_controllers/user_show_controller.dart';
import '../../constants/appimages.dart';
import '../../widgets/all_players_container.dart';

class UserRoleSide extends StatelessWidget {
  final String role; // "player" | "facilitator" | "admin"
  final String emptyText;

  const UserRoleSide({
    super.key,
    required this.role,
    required this.emptyText,
  });

  @override
  Widget build(BuildContext context) {
    final UserShowController controller = Get.find<UserShowController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 40),
            child: CircularProgressIndicator(),
          ),
        );
      }

      final users = controller.filteredUsers(role);

      String avatar;
      switch (role) {
        case "player":
          avatar = Appimages.player2;
          break;
        case "facilitator":
          avatar = Appimages.facil2;
          break;
        case "admin":
          avatar = Appimages.prince2;
          break;
        default:
          avatar = Appimages.player2;
      }

      if (users.isEmpty) {
        return Center(child: Text(emptyText));
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: users.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final user = users[index];
          return AllPlayersContainer(
            text: user.name,
            text2: user.email,
            image: avatar,
            onTap: () {
              print("👤 ${user.role} tapped: ${user.name}");
            },
          );
        },
      );
    });
  }
}
