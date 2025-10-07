// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../../api/api_controllers/user_show_controller.dart';
// import '../../widgets/all_players_container.dart';
// import '../../constants/appimages.dart';
//
// class UserFacilitateSide extends StatelessWidget {
//   final UserShowController controller = Get.find<UserShowController>();
//
//   UserFacilitateSide({super.key});
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
//       final facilitators = controller.facilitators;
//
//       if (facilitators.isEmpty) {
//         return const Center(child: Text("No facilitators found"));
//       }
//
//       return ListView.separated(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: facilitators.length,
//         separatorBuilder: (_, __) => const SizedBox(height: 10),
//         itemBuilder: (context, index) {
//           final f = facilitators[index];
//           return AllPlayersContainer(
//             text: f.name,
//             text2: f.email,
//             image: Appimages.facil2,
//             onTap: () {
//               // TODO: navigate to facilitator details
//             },
//           );
//         },
//       );
//     });
//   }
// }
