import 'package:flutter/material.dart';

class LinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path2 = Path();
    path2.addOval(Rect.fromCircle(
      center: Offset(size.width * 0.8, 0),
      radius: size.width * 0.2,
    ));
    canvas.drawPath(path2, Paint()..color = Color(0xFFF84E69));

    var path = Path();
    path.addOval(Rect.fromCircle(
      center: Offset(size.width * 0.4, 0),
      radius: size.width * 0.4,
    ));
    canvas.drawPath(path, Paint()..color = Color(0xFFFF637C));

    canvas.rotate(-160 / 360);
    var paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < size.width.round() * 2; i = i + 8) {
      Offset startingPoint = Offset(i.toDouble() - 400, -100);
      Offset endingPoint = Offset(i.toDouble() - 400, size.height + 100);

      canvas.drawLine(startingPoint, endingPoint, paint);
    }

    var path3 = Path();
    path3.addOval(Rect.fromCircle(
      center: Offset(size.width * 0.2, size.width * 0.3),
      radius: size.width * 0.08,
    ));
    canvas.drawPath(path3, Paint()..color = Color(0xFFF84E69));

    var path4 = Path();
    path4.addOval(Rect.fromCircle(
      center: Offset(size.width * 0.4, size.width * 0.3 + size.width * 0.08),
      radius: size.width * 0.1,
    ));
    canvas.drawPath(path4, Paint()..color = Color(0xFFF84E69));
    canvas.rotate(160 / 360);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(
              size.width * 0.6,
              size.height - 100,
              size.width * 0.2,
              200,
            ),
            Radius.circular(80.0)),
        Paint()..color = Color(0xFFFF637C));
    var path5 = Path();
    path5.addOval(Rect.fromCircle(
      center: Offset( size.width * 0.6 + (size.width * 0.08), size.height - 60),
      radius: size.width * 0.04,
    ));
    canvas.drawPath(path5, Paint()..color = Color(0xFFF84E69));

    var path6 = Path();
    path6.addOval(Rect.fromCircle(
      center: Offset(size.width * 0.6 + (size.width * 0.15), size.height - 60),
      radius: size.width * 0.02,
    ));
    canvas.drawPath(path6, Paint()..color = Color(0xFFF84E69));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
