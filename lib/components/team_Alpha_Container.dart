import 'package:flutter/material.dart';
import 'package:scorer/constants/appcolors.dart';
import 'package:scorer/constants/appimages.dart';
import 'package:scorer/widgets/main_text.dart';

class TeamAlphaContainer extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const TeamAlphaContainer({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  _TeamAlphaContainerState createState() => _TeamAlphaContainerState();
}

class _TeamAlphaContainerState extends State<TeamAlphaContainer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,

              width: isExpanded
                  ? widget.screenWidth * 0.4
                  : widget.screenWidth * 0.05,
              height: widget.screenHeight * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(widget.screenWidth * 0.03),
                  bottomLeft: Radius.circular(widget.screenWidth * 0.03),
                ),
                color: AppColors.forwardColor,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  if (isExpanded)
                    Positioned(
                      top: -widget.screenHeight * 0.03,
                      left: -widget.screenWidth * 0.06,
                      child: Image.asset(
                        Appimages.man3,
                        width: widget.screenWidth * 0.21,
                        height: widget.screenWidth * 0.25,
                      ),
                    ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isExpanded)
                        Padding(
                          padding: EdgeInsets.only(
                            left: widget.screenWidth * 0.05,
                            top: widget.screenHeight * 0.01,
                          ),
                          child: MainText(
                            text: "Team Alpha",
                            fontFamily: "gotham",
                            fontSize: widget.screenWidth * 0.04,
                            color: AppColors.whiteColor,
                            height: 0,
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (isExpanded)
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: AppColors.arrowColor,
                              size: widget.screenWidth * 0.05,
                            ),
                          if (isExpanded)
                            MainText(
                              text: "2,890 pts",
                              fontFamily: "gotham",
                              fontSize: widget.screenWidth * 0.04,
                              height: 0,
                            ),
                          SizedBox(width: widget.screenWidth * 0.02),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
