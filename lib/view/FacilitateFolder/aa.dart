
import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child; 

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xFFFFFFFF), 
            Color(0x00FFFFFF), 
          ],
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color.fromRGBO(67, 177, 80, 0.2), 
              Color.fromRGBO(168, 209, 236, 0.2), 
            ],
            transform: GradientRotation(0.97), 
          ),
        ),
        child: child, 
      ),
    );
  }
}
