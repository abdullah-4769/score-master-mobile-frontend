import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorer/components/filter_drop_down_container.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/main_text.dart';
class MetricesContainer extends StatelessWidget {
  const MetricesContainer({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.35,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyColor, width: 1.7),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.025),
            BoldText(
              text: "engagement_metrics".tr,
              fontSize: screenWidth * 0.04,
              selectionColor: AppColors.blueColor,
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    BoldText(
                      text: "85%",
                      fontSize: screenWidth * 0.06,
                      selectionColor: AppColors.forwardColor,
                    ),
                    BoldText(
                  text: "participation".tr,
                      fontSize: screenWidth * 0.04,
                      selectionColor: AppColors.blueColor,
                    ),
                  ],
                ),
                SizedBox(width: screenWidth * 0.08),
                Column(
                  children: [
                    BoldText(
                      text: "85%",
                      fontSize: screenWidth * 0.06,
                      selectionColor: AppColors.forwardColor,
                    ),
                    BoldText(
                    text: "participation".tr,
                      fontSize: screenWidth * 0.04,
                      selectionColor: AppColors.blueColor,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.025),
           Row(
              children: [
                Expanded(
                              flex:  3 ,
                  
                  child: Container(
                    height: screenHeight * 0.006,
                    width: screenWidth * 0.38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      color: AppColors.forwardColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: screenHeight * 0.006,
                    width: screenWidth * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
              ],
            ),  SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainText(
                 text: "active_players".tr,
                  fontSize: screenWidth * 0.035,
                ),
                BoldText(
                  text: "10/12",
                  fontSize: screenWidth * 0.04,
                  selectionColor: AppColors.blueColor,
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                Expanded(
                              flex:  3 ,
                  
                  child: Container(
                    height: screenHeight * 0.006,
                    width: screenWidth * 0.38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      color: AppColors.forwardColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: screenHeight * 0.006,
                    width: screenWidth * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainText(
  text: "avg_response_time".tr,
                  fontSize: screenWidth * 0.035,
                ),
                BoldText(
                  text: "32s",
                  fontSize: screenWidth * 0.04,
                  selectionColor: AppColors.blueColor,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<T?> showCustomBottomSheet<T>({
  
  required BuildContext context,
  bool isDismissible = true,
  bool enableDrag = true,
  double? height,
  Color backgroundColor = Colors.white,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: false,
    showDragHandle: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      double screenHeight = MediaQuery.of(context).size.height;
      double screenWidth = MediaQuery.of(context).size.width;
      return Container(
        height: screenHeight * 0.89, 
        width: screenWidth * 1.12, 
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: FilterDropDownContainer(),
      );
    },
  );
}