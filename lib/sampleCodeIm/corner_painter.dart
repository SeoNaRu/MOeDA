import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    double cornerRadius = 20;
    double cornerLength = 20;

    // Top-left corner
    canvas.drawLine(Offset(0, cornerRadius), Offset(0, cornerLength), paint);
    canvas.drawLine(Offset(cornerRadius, 0), Offset(cornerLength, 0), paint);

    // Top-right corner
    canvas.drawLine(Offset(size.width, cornerRadius), Offset(size.width, cornerLength), paint);
    canvas.drawLine(Offset(size.width - cornerRadius, 0), Offset(size.width - cornerLength, 0), paint);

    // Bottom-left corner
    canvas.drawLine(Offset(0, size.height - cornerRadius), Offset(0, size.height - cornerLength), paint);
    canvas.drawLine(Offset(cornerRadius, size.height), Offset(cornerLength, size.height), paint);

    // Bottom-right corner
    canvas.drawLine(Offset(size.width, size.height - cornerRadius), Offset(size.width, size.height - cornerLength), paint);
    canvas.drawLine(Offset(size.width - cornerRadius, size.height), Offset(size.width - cornerLength, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
