import 'package:flutter/material.dart';

class AquaButton extends StatelessWidget {
  const AquaButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.red.shade500,
            Colors.red.shade800,
          ],
          stops: const [0.5, 1.0],
          center: const Alignment(0.0, 0.0), // Centered gradient
          radius: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.red.shade900,
            blurRadius: 2.0,
            offset: const Offset(1.0, 1.5),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            blurRadius: 1.0,
            offset: const Offset(-1.0, -1.0),
            spreadRadius: 0.5,
          ),
        ],
      ),
    );
  }
}
