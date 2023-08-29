import 'package:flutter/material.dart';

class AquaButton extends StatelessWidget {
  final MaterialColor color;
  final double mainRadius;

  const AquaButton({
    Key? key,
    this.color = Colors.red,
    this.mainRadius = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double northPoleRadius = mainRadius * 0.85;

    return Container(
      width: mainRadius * 2,
      height: mainRadius * 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color,
            color[900]!,
            color[700]!,
            color[500]!,
          ],
        ),
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          // North pole
          Positioned(
            left: mainRadius - northPoleRadius,
            top: -northPoleRadius / 1.3,
            child: Container(
              width: northPoleRadius * 2.0,
              height: northPoleRadius * 2.0,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withOpacity(0.55),
                    Colors.transparent,
                  ],
                  stops: const [0.09, 0.8],
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
                painter: _TrianglePainter(mainRadius: mainRadius),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final double mainRadius;

  _TrianglePainter({required this.mainRadius});

  @override
  void paint(Canvas canvas, Size size) {
    double triangleHeight = size.height / 2.5;
    double triangleBase = size.width * 1.0;

    Path path = Path()
      ..moveTo(size.width / 2, size.height - triangleHeight)
      ..lineTo(0, size.height)
      ..lineTo(triangleBase, size.height)
      ..close();

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
