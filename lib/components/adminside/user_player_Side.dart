// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../api/api_controllers/user_show_controller.dart';
// import '../../widgets/all_players_container.dart';
// import '../../constants/appimages.dart';
//
// class UserPlayerSide extends StatelessWidget {
//   final UserShowController controller = Get.find<UserShowController>();
//
//   UserPlayerSide({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return const Center(child: Padding(
//           padding: EdgeInsets.only(top: 40), // loader not touching top
//           child: CircularProgressIndicator(),
//         ));
//       }
//
//       final players = controller.players;
//
//       if (players.isEmpty) {
//         return const Center(child: Text("No players found"));
//       }
//
//       return ListView.separated(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: players.length,
//         separatorBuilder: (_, __) => const SizedBox(height: 10),
//         itemBuilder: (context, index) {
//           final player = players[index];
//           return AllPlayersContainer(
//             text: player.name,
//             text2: player.email,
//             image: Appimages.player2,
//             onTap: () {
//               // TODO: navigate to player details
//             },
//           );
//         },
//       );
//     });
//   }
// }
