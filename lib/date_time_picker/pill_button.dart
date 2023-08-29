import 'package:flutter/material.dart';

class AquaButton extends StatelessWidget {
  const AquaButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mainRadius = 10;
    double northPoleRadius = mainRadius * 0.85; // Slightly increasing the size

    return Container(
      width: mainRadius * 2,
      height: mainRadius * 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.red,
            Colors.red[900]!,
            Colors.red[700]!,
            Colors.red[500]!,
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
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipOval(
              child: CustomPaint(
                size: Size(mainRadius * 2, mainRadius * 2),
                painter: _TrianglePainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double triangleHeight = size.height / 2.5; // Height of the triangle
    double triangleBase = size.width * 1.0; // Base of the triangle

    Path path = Path()
      ..moveTo(size.width / 2, size.height - triangleHeight)
      ..lineTo(0, size.height)
      ..lineTo(triangleBase, size.height)
      ..close();

    // Gradient for the triangle
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.white.withOpacity(0.1),
        Colors.white.withOpacity(0.3),
      ],
    );

    final paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromPoints(
          Offset(0, size.height - triangleHeight),
          Offset(triangleBase, size.height),
        ),
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
