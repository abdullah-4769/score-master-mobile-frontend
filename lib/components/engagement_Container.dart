// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:scorer/constants/appcolors.dart';
// import 'package:scorer/constants/appimages.dart';
// import 'package:scorer/widgets/bold_text.dart';
// import '../api/api_controllers/session_controller.dart';
//
// class EngagementContainer extends StatelessWidget {
//   const EngagementContainer({
//     super.key,
//     required this.widthScaleFactor,
//     required this.heightScaleFactor,
//   });
//
//   final double widthScaleFactor;
//   final double heightScaleFactor;
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SessionController>(
//       builder: (sessionController) {
//         final session = sessionController.session.value;
//
//         return Padding(
//           padding: EdgeInsets.only(right: 23 * widthScaleFactor),
//           child: Row(
//             children: [
//               Image.asset(
//                 Appimages.group,
//                 height: 116 * heightScaleFactor,
//                 width: 170 * widthScaleFactor,
//               ),
//               SizedBox(width: 3 * widthScaleFactor),
//               Flexible(
//                 child: Container(
//                   width: 248 * widthScaleFactor,
//                   height: 116 * heightScaleFactor,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: AppColors.greyColor, width: 1.5),
//                     borderRadius: BorderRadius.circular(24 * widthScaleFactor),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 10 * widthScaleFactor),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         // Player count row - Fixed overflow
//                         Row(
//                           children: [
//                             Expanded(
//                               flex: 1,
//                               child: BoldText(
//                                 text: "${session?.totalPlayers ?? '0'}",
//                                 selectionColor: AppColors.forwardColor,
//                                 fontSize: 22.sp,
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                             SizedBox(width: 8 * widthScaleFactor),
//                             Container(
//                               width: 40 * widthScaleFactor,
//                               height: 2,
//                               decoration: BoxDecoration(
//                                 color: AppColors.orangeColor,
//                                 borderRadius: BorderRadius.circular(2),
//                               ),
//                             ),
//                             SizedBox(width: 6 * widthScaleFactor),
//                             Expanded(
//                               flex: 2,
//                               child: FittedBox(
//                                 fit: BoxFit.scaleDown,
//                                 alignment: Alignment.centerLeft,
//                                 child: BoldText(
//                                   text: "active_players".tr,
//                                   selectionColor: AppColors.blueColor,
//                                   fontSize: 16.sp,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10 * heightScaleFactor),
//                         // Engagement row - Fixed overflow
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               flex: 1,
//                               child: BoldText(
//                                 text: "${session?.engagement ?? '0'}%",
//                                 selectionColor: AppColors.forwardColor,
//                                 fontSize: 22.sp,
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                             SizedBox(width: 6 * widthScaleFactor),
//                             Container(
//                               width: 35 * widthScaleFactor,
//                               height: 2,
//                               decoration: BoxDecoration(
//                                 color: AppColors.orangeColor,
//                                 borderRadius: BorderRadius.circular(2),
//                               ),
//                             ),
//                             SizedBox(width: 5 * widthScaleFactor),
//                             Expanded(
//                               flex: 2,
//                               child: FittedBox(
//                                 fit: BoxFit.scaleDown,
//                                 alignment: Alignment.centerLeft,
//                                 child: BoldText(
//                                   text: "engagement".tr,
//                                   selectionColor: AppColors.blueColor,
//                                   fontSize: 16.sp,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/bold_text.dart';
import '../api/api_controllers/session_controller.dart';


class EngagementContainer extends StatelessWidget {
  const EngagementContainer({
    super.key,
    required this.widthScaleFactor,
    required this.heightScaleFactor,
  });

  final double widthScaleFactor;
  final double heightScaleFactor;

  @override
  Widget build(BuildContext context) {
    final SessionController sessionController =
    Get.find<
        SessionController
    >(); // Assuming controller is put in Get.put() elsewhere

    return Padding(
      padding: EdgeInsets.only(right: 23 * widthScaleFactor),
      child: Row(
        children: [
          Image.asset(
            Appimages.group,
            height: 116 * heightScaleFactor,
            width: 170 * widthScaleFactor,
          ),
          SizedBox(width: 3 * widthScaleFactor),
          Flexible(
            child: Container(
              width: 248 * widthScaleFactor,
              height: 116 * heightScaleFactor,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyColor, width: 1.5),
                borderRadius: BorderRadius.circular(24 * widthScaleFactor),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10 * widthScaleFactor),
                child: Obx(
                      () => Column(
                    // Use Obx to react to changes
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          BoldText(
                            text:
                            "${sessionController.session.value?.totalPlayers ?? '12'}",
                            selectionColor: AppColors.forwardColor,
                            fontSize: 22.sp,
                          ),
                          SizedBox(width: 8 * widthScaleFactor),
                          Container(
                            width: 40 * widthScaleFactor,
                            height: 2,
                            decoration: BoxDecoration(
                              color: AppColors.orangeColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          SizedBox(width: 6 * widthScaleFactor),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: BoldText(
                                text: "active_players".tr,
                                selectionColor: AppColors.blueColor,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10 * heightScaleFactor),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BoldText(
                            text:
                            "${sessionController.session.value?.engagement ?? '89'}%",
                            selectionColor: AppColors.forwardColor,
                            fontSize: 22.sp,
                          ),
                          SizedBox(width: 6 * widthScaleFactor),
                          Container(
                            width: 35 * widthScaleFactor,
                            height: 2,
                            decoration: BoxDecoration(
                              color: AppColors.orangeColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          SizedBox(width: 5 * widthScaleFactor),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: BoldText(
                                text: "engagement".tr,
                                selectionColor: AppColors.blueColor,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
