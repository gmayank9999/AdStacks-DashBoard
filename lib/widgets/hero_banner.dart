import 'package:flutter/material.dart';

class HeroBanner extends StatelessWidget {
  final bool isMobile;
  const HeroBanner({Key? key, required this.isMobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bannerHeight = isMobile ? 280.0 : 340.0;

    return Container(
      height: bannerHeight,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(
            right: -50,
            top: -30,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: isMobile ? 20 : 60,
            top: isMobile ? 30 : 40,
            child: Transform.rotate(
              angle: 0.3,
              child: Container(
                width: isMobile ? 80 : 120,
                height: isMobile ? 80 : 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.withOpacity(0.8),
                      Colors.purple.withOpacity(0.6),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(10, 10),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: isMobile ? 80 : 140,
            top: isMobile ? 80 : 100,
            child: Transform.rotate(
              angle: -0.2,
              child: Container(
                width: isMobile ? 60 : 90,
                height: isMobile ? 60 : 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.pink.withOpacity(0.8),
                      Colors.orange.withOpacity(0.6),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(8, 8),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: isMobile ? 30 : 50,
            bottom: isMobile ? 40 : 50,
            child: Container(
              width: isMobile ? 70 : 100,
              height: isMobile ? 70 : 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.grey.shade300,
                    Colors.grey.shade600,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(10, 10),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: isMobile ? 120 : 180,
            bottom: isMobile ? 60 : 70,
            child: CustomPaint(
              size: Size(isMobile ? 50 : 70, isMobile ? 50 : 70),
              painter: ConePainter(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(isMobile ? 20 : 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ETHEREUM 3.0',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isMobile ? 10 : 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Top Rating\nProject',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 24 : 32,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Trending project and high rating\nProject Created by team.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isMobile ? 12 : 14,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F2937),
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : 32,
                      vertical: isMobile ? 12 : 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Learn More',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: isMobile ? 13 : 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ConePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.teal.withOpacity(0.8),
          Colors.cyan.withOpacity(0.6),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    final shadowPath = Path()
      ..moveTo(size.width * 0.5 + 5, 5)
      ..lineTo(size.width + 5, size.height + 5)
      ..lineTo(5, size.height + 5)
      ..close();

    canvas.drawPath(shadowPath, shadowPaint);

    final path = Path()
      ..moveTo(size.width * 0.5, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
