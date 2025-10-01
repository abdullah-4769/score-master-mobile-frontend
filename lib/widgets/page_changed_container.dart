import 'package:flutter/material.dart';

class PageChangedContainer extends StatelessWidget {
  final Color color;
  final double width;
  final double height;
  const PageChangedContainer({super.key, required this.color, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
  width: width,
  height: height,

  decoration: BoxDecoration(
  color: color,
  border: Border.all(
    color: color,width: 2
  ),
  borderRadius: BorderRadius.circular(80)
  ),
);
  }
}