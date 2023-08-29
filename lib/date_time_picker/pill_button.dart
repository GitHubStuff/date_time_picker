import 'package:flutter/material.dart';

class AquaButton extends StatelessWidget {
  const AquaButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mainRadius = 15;
    double northPoleRadius = mainRadius * (1.0 / 3.0);
    double southPoleRadius = mainRadius *
        0.5; // Slightly larger than the north pole for more dispersion

    return Container(
      width: mainRadius * 2,
      height: mainRadius * 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.red[900]!,
            Colors.red,
          ],
        ),
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          // North pole
          Positioned(
            left: mainRadius - northPoleRadius,
            top: 0,
            child: Container(
              width: northPoleRadius * 2,
              height: northPoleRadius * 2,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [Colors.white.withOpacity(0.7), Colors.transparent],
                  stops: const [0.4, 1.0], // Quick fade
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // South pole
          Positioned(
            left: mainRadius - southPoleRadius,
            bottom:
                -southPoleRadius, // Shift it so that the center rests against the edge
            child: Container(
              width: southPoleRadius * 2,
              height: southPoleRadius * 2,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [Colors.white.withOpacity(0.2), Colors.transparent],
                  stops: const [0.2, 1.0], // More diffuse fade
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
