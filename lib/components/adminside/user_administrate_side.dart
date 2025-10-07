// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../api/api_controllers/user_show_controller.dart';
//
// import '../../widgets/all_players_container.dart';
// import '../../constants/appimages.dart';
//
// class UserAdministrateSide extends StatelessWidget {
//   final UserShowController controller = Get.find<UserShowController>();
//
//   UserAdministrateSide({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return const Center(child: Padding(
//           padding: EdgeInsets.only(top: 40),
//           child: CircularProgressIndicator(),
//         ));
//       }
//
//       final admins = controller.admins;
//
//       if (admins.isEmpty) {
//         return const Center(child: Text("No admins found"));
//       }
//
//       return ListView.separated(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: admins.length,
//         separatorBuilder: (_, __) => const SizedBox(height: 10),
//         itemBuilder: (context, index) {
//           final admin = admins[index];
//           return AllPlayersContainer(
//             text: admin.name,
//             text2: admin.email,
//             image: Appimages.prince2,
//             onTap: () {
//               // TODO: navigate to admin details
//             },
//           );
//         },
//       );
//     });
//   }
// }
