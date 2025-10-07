import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scorer/components/adminside/custom_Container.dart';
import 'package:scorer/components/adminside/default_time_container.dart';
import 'package:scorer/components/adminside/game_logic_setup_container.dart';
import 'package:scorer/components/count_container_row.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/bold_text.dart';
import 'package:scorer/widgets/custom_phase_Container.dart';
import 'package:scorer/widgets/filter_useable_container.dart';
import 'package:scorer/widgets/login_button.dart';
import 'package:scorer/widgets/login_textfield.dart';
import 'package:scorer/widgets/main_text.dart';
import 'package:scorer/widgets/use_able_game_row.dart';

import '../../api/api_controllers/create_game_controller.dart';
import '../../api/api_controllers/facilitator_controller.dart';
import '../../widgets/admin_side_widgets/challange_type_selector.dart';
import '../../widgets/admin_side_widgets/custom_badge_widget.dart';
import '../../widgets/admin_side_widgets/phase_timer_sliders.dart';
import '../FacilitateFolder/aa.dart';

class Game2Screen extends StatefulWidget {
  Game2Screen({super.key});

  @override
  State<Game2Screen> createState() => _Game2ScreenState();
}

class _Game2ScreenState extends State<Game2Screen> {
  // Declare _showPhaseSection as a class-level variable
  final RxBool _showPhaseSection = false.obs;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    const double baseWidth = 375.0;
    final double scaleFactor = screenWidth / baseWidth;

    final FacilitatorsController facilitatorController = Get.put(
        FacilitatorsController());
    final CreateGameController createGameController = Get.put(
        CreateGameController());

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30 * scaleFactor),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50 * scaleFactor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Get.back(),
                          child: SvgPicture.asset(
                            Appimages.arrowback,
                            colorFilter: ColorFilter.mode(
                                AppColors.forwardColor, BlendMode.srcIn),
                            width: 24.w,
                            height: 20.h,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 22 * scaleFactor,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: "create_ne".tr,
                                style: TextStyle(color: AppColors.blueColor),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xff8DC046),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    "w".tr,
                                    style: TextStyle(
                                      color: AppColors.blueColor,
                                      fontSize: 22 * scaleFactor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.forwardColor,
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 4.0, right: 10.0),
                                    child: Text(
                                      "game".tr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22 * scaleFactor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(""),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      height: 150 * scaleFactor,
                      child: Image.asset(
                        Appimages.game,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  LoginTextfield(
                    text: "enter_game_name".tr,
                    fontsize: 14 * scaleFactor,
                    ishow: true,
                    onChanged: (value) =>
                    createGameController.name.value = value,
                  ),
                  SizedBox(height: 9 * scaleFactor),
                  LoginTextfield(
                    ishow: true,
                    text: "description".tr,
                    height: 120 * scaleFactor,
                    fontsize: 14 * scaleFactor,
                    onChanged: (value) =>
                    createGameController.description.value = value,
                  ),

                  SizedBox(height: 24 * scaleFactor),
                  DefaultTimeContainer(
                    scaleFactor: scaleFactor,
                    controller: createGameController,
                  ),

                  SizedBox(height: 20 * scaleFactor),
                  BoldText(
                    text: "add_facilitators".tr,
                    fontSize: 16 * scaleFactor,
                    selectionColor: AppColors.blueColor,
                  ),

                  SizedBox(height: 15 * scaleFactor),

                  TextField(
                    onChanged: (value) =>
                    facilitatorController.searchQuery.value = value,
                    decoration: InputDecoration(
                      hintText: "search_facilitator".tr,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12 * scaleFactor),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),

                  SizedBox(height: 10 * scaleFactor),

                  Obx(() {
                    final query = facilitatorController.searchQuery.value
                        .toLowerCase();
                    final filtered = facilitatorController.filteredFacilitators;

                    if (query.isEmpty) return SizedBox();

                    if (filtered.isEmpty) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, color: Colors.grey,
                              size: 20 * scaleFactor),
                          SizedBox(width: 8 * scaleFactor),
                          Text(
                            "No facilitator found",
                            style: TextStyle(
                              fontSize: 14 * scaleFactor,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    }

                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8 * scaleFactor),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(12 * scaleFactor),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) => Divider(),
                        itemBuilder: (context, index) {
                          final facilitator = filtered[index];
                          return Obx(() {
                            final isSelected =
                            facilitatorController.selectedIds.contains(
                                facilitator.id);
                            return GestureDetector(
                              onTap: () =>
                                  facilitatorController.toggleSelection(
                                      facilitator.id!),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12 * scaleFactor,
                                    vertical: 8 * scaleFactor),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.green.withOpacity(
                                      0.2) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                      8 * scaleFactor),
                                  border: Border.all(
                                    color: isSelected ? Colors.green : Colors
                                        .grey.shade300,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset("assets/png/1.png",
                                        width: 40 * scaleFactor,
                                        height: 40 * scaleFactor),
                                    SizedBox(width: 10 * scaleFactor),
                                    Expanded(
                                      child: Text(
                                        facilitator.name ?? "",
                                        style: TextStyle(
                                            fontSize: 14 * scaleFactor,
                                            fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Icon(
                                      isSelected ? Icons.check_circle : Icons
                                          .check_circle_outline,
                                      color: isSelected ? Colors.green : Colors
                                          .grey,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                        },
                      ),
                    );
                  }),

                  SizedBox(height: 20 * scaleFactor),
                  Obx(() {
                    final selected = facilitatorController
                        .getSelectedFacilitators();
                    if (selected.isEmpty) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12 * scaleFactor),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(12 * scaleFactor),
                        ),
                        child: Text(
                          "no_facilitators_selected".tr,
                          style: TextStyle(
                              fontSize: 14 * scaleFactor, color: Colors.grey),
                        ),
                      );
                    }
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 12 * scaleFactor, vertical: 8 *
                          scaleFactor),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(8 * scaleFactor),
                      ),
                      constraints: BoxConstraints(maxHeight: 200 * scaleFactor),
                      child: SingleChildScrollView(
                        child: Column(
                          children: selected.map((fac) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 4 * scaleFactor),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/png/1.png",
                                    width: 40 * scaleFactor,
                                    height: 40 * scaleFactor,
                                  ),
                                  SizedBox(width: 10 * scaleFactor),
                                  Expanded(
                                    child: Text(
                                      fac.name ?? "",
                                      style: TextStyle(
                                          fontSize: 14 * scaleFactor),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        facilitatorController.toggleSelection(
                                            fac.id!),
                                    child: CircleAvatar(
                                      maxRadius: 12 * scaleFactor,
                                      backgroundColor: AppColors.whiteColor,
                                      child: Icon(Icons.remove_circle,
                                          color: Colors.red,
                                          size: 20 * scaleFactor),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  }),

                  SizedBox(height: 20 * scaleFactor),
                  BoldText(
                    text: "number_of_phases".tr,
                    fontSize: 16 * scaleFactor,
                    selectionColor: AppColors.blueColor,
                  ),
                  SizedBox(height: 14 * scaleFactor),
                  MainText(
                    text: "phase_structure_adapts".tr,
                    color: AppColors.teamColor,
                    textAlign: TextAlign.center,
                    height: 1.4,
                    fontSize: 15 * scaleFactor,
                  ),
                  SizedBox(height: 29 * scaleFactor),
                  CountContainerRow(scaleFactor: scaleFactor,
                      onCountChanged: (count) =>
                      createGameController.totalPhases.value = count),


                  SizedBox(height: 20 * scaleFactor),

                  // PhaseTimeSlider(label: '', value: null, totalTime: null, allValues: [],),
                  SizedBox(height: 20 * scaleFactor),
                  LoginButton(
                    fontSize: 20.sp,
                    text: "save".tr,
                    ishow: true,
                    image: Appimages.save,
                    onTap: () => createGameController.createGameFormat(),
                  ),
                  SizedBox(height: 20 * scaleFactor),


                  GameLogicSetupContainer(scaleFactor: scaleFactor,),
                  SizedBox(height: 20 * scaleFactor),
                  //
                  // Container(
                  //   width: double.infinity,
                  //   padding: EdgeInsets.all(16 * scaleFactor),
                  //   decoration: BoxDecoration(
                  //     color: Colors.blue.shade50,
                  //     border: Border.all(color: Colors.blue.shade200),
                  //     borderRadius: BorderRadius.circular(12 * scaleFactor),
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       Text(
                  //         "Test Phase Loading",
                  //         style: TextStyle(
                  //           fontSize: 14 * scaleFactor,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.blue.shade700,
                  //         ),
                  //       ),
                  //       SizedBox(height: 8 * scaleFactor),
                  //       ElevatedButton(
                  //         onPressed: () {
                  //           // Test with your existing game ID 1
                  //           print("🧪 Testing: Loading phases for game ID 1");
                  //           createGameController.loadExistingGame(1);
                  //         },
                  //         style: ElevatedButton.styleFrom(
                  //           backgroundColor: Colors.blue,
                  //           padding: EdgeInsets.symmetric(
                  //             horizontal: 20 * scaleFactor,
                  //             vertical: 10 * scaleFactor,
                  //           ),
                  //         ),
                  //         child: Obx(() => createGameController.isFetchingPhases.value
                  //             ? Row(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: [
                  //             SizedBox(
                  //               width: 16,
                  //               height: 16,
                  //               child: CircularProgressIndicator(
                  //                 strokeWidth: 2,
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //             SizedBox(width: 8),
                  //             Text("Loading..."),
                  //           ],
                  //         )
                  //             : Text(
                  //           "Load Game ID 1 Phases",
                  //           style: TextStyle(color: Colors.white),
                  //         )),
                  //       ),
                  //       SizedBox(height: 8 * scaleFactor),
                  //       Obx(() => Text(
                  //         "Current Game ID: ${createGameController.currentGameId.value ?? 'None'}",
                  //         style: TextStyle(fontSize: 12 * scaleFactor, color: Colors.grey.shade600),
                  //       )),
                  //     ],
                  //   ),
                  // ),

                  SizedBox(height: 20 * scaleFactor),

                  // Obx(() {
                  //   if (createGameController.phases.isEmpty) {
                  //     return SizedBox();
                  //   }
                  //
                  //   return Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       BoldText(
                  //         text: "Game Phases",
                  //         fontSize: 16 * scaleFactor,
                  //         selectionColor: AppColors.blueColor,
                  //       ),
                  //       SizedBox(height: 10 * scaleFactor),
                  //
                  //       ...createGameController.phases.map((phase) {
                  //         return Container(
                  //           margin: EdgeInsets.symmetric(vertical: 8 * scaleFactor),
                  //           padding: EdgeInsets.all(12 * scaleFactor),
                  //           decoration: BoxDecoration(
                  //             border: Border.all(color: Colors.grey.shade400),
                  //             borderRadius: BorderRadius.circular(12 * scaleFactor),
                  //           ),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               BoldText(
                  //                 text: phase.name,
                  //                 fontSize: 14 * scaleFactor,
                  //                 selectionColor: AppColors.forwardColor,
                  //               ),
                  //               SizedBox(height: 6),
                  //               Text("Duration: ${phase.timeDuration} min"),
                  //               Text("Stages: ${phase.stagesCount}"),
                  //               Text("Challenges: ${phase.challengeTypes.join(", ")}"),
                  //               Align(
                  //                 alignment: Alignment.centerRight,
                  //                 child: IconButton(
                  //                   icon: Icon(Icons.edit, color: AppColors.forwardColor),
                  //                   onPressed: () {
                  //                     // TODO: open edit later
                  //                   },
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         );
                  //       }).toList(),
                  //     ],
                  //   );
                  // }),






                  // Add Phase Button
                  Center(
                    child: LoginButton(
                      fontSize: 19.sp,
                      text: "add_phase".tr,
                      ishow: true,
                      icon: Icons.add,
                      imageHeight: 26 * scaleFactor,
                      imageWidth: 26 * scaleFactor,
                      onTap: () {
                        _showPhaseSection.value =
                        !_showPhaseSection.value; // Toggle visibility
                      },
                    ),
                  ),
                  SizedBox(height: 16 * scaleFactor),

                  // Collapsible Section
                  Obx(() =>
                      Visibility(
                        visible: _showPhaseSection.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [





                            SizedBox(height: 10 * scaleFactor),
                            ChallengeTypeSelector(
                              availableTypes: ["MCQ", "Open Ended", "Puzzle", "Simulation"],
                              initialSelected: [], // or pass pre-filled from API if editing
                              onSelectionChanged: (selectedList) {
                                // ✅ store in controller or pass to API
                                print("Selected Challenge Types: $selectedList");
                                // controller.challengeTypes.value = selectedList;
                              },
                            ),
                            SizedBox(height: 10 * scaleFactor),


                            //CustomContainer(scaleFactor: scaleFactor),
                            // SizedBox(height: 24 * scaleFactor),

                            // SizedBox(height: 16 * scaleFactor),
                            BadgeWidget(
                              onChanged: (badge, score) {
                                sendToApi(badge, score);
                              },
                            ),

                            SizedBox(height: 16 * scaleFactor),
                            // LoginButton(
                            //   text: "add_more_badges".tr,
                            //   height: 45 * scaleFactor,
                            //   color: AppColors.forwardColor,
                            //   radius: 12 * scaleFactor,
                            //   fontSize: 14.sp,
                            //   fontFamily: "refsan",
                            // ),
                            SizedBox(height: 18 * scaleFactor),


                            FilterSelector(
                              onSelected: (value) {
                                print("User selected: $value");
                                // TODO: Send `value` to API later
                              },
                            ),

                            SizedBox(height: 16 * scaleFactor),

                            // Existing Save and Cancel Buttons
                            LoginButton(
                              fontSize: 20.sp,
                              text: "save".tr,
                              ishow: true,
                              image: Appimages.save,
                              onTap: () => createGameController.createGameFormat(),
                            ),

                          ],
                        ),
                      )),

                  SizedBox(height: 10 * scaleFactor),
                  LoginButton(
                    fontSize: 20.sp,
                    text: "cancel".tr,
                    color: AppColors.forwardColor,
                    onTap: () => Get.back(),
                  ),
                  SizedBox(height: 43 * scaleFactor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  void sendToApi(BadgeType badge, String score) {
    final badgeName = badge.name;

    print("Sending to API => Badge: $badgeName, Score: $score");

    // TODO: replace with your actual API call
    // await ApiService.postBadge({"badge": badgeName, "score": score});
  }
}