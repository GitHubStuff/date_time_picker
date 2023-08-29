import 'package:flutter/material.dart';

class AquaButton extends StatelessWidget {
  const AquaButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mainRadius = 15;
    double northPoleRadius = mainRadius * 0.85; // Slightly increasing the size
    double southPoleRadius = mainRadius * 0.55;

    return Container(
      width: mainRadius * 2,
      height: mainRadius * 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.red[900]!,
            Colors.red[800]!,
            Colors.red[700]!,
            Colors.red[400]!,
          ],
        ),
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          // North pole
          Positioned(
            left: mainRadius - northPoleRadius, // + (northPoleRadius / 7.0),
            top: -northPoleRadius / 1.3, // Adjusting position
            child: Container(
              width: northPoleRadius * 2.0,
              height: northPoleRadius * 2.0,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withOpacity(0.55),
                    Colors.transparent,
                  ],
                  stops: const [0.09, 0.8], // More dramatic fade
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // South pole
          Positioned(
            left: mainRadius - southPoleRadius,
            bottom: -southPoleRadius, // + (0.2 * southPoleRadius),
            child: Container(
              width: southPoleRadius * 2.5, // Increase width for dispersal
              height: southPoleRadius,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, 0.5),
                  focal: const Alignment(0, 0.5), // Aligning focal with center
                  colors: [
                    Colors.green.withOpacity(1.0),
                    Colors.transparent,
                  ],
                  stops: const [0, 1.0],
                  focalRadius: 0.2, // Focal radius for elliptical dispersion
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
