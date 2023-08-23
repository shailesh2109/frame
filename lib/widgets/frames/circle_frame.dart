import 'package:flutter/material.dart';

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = size.width < size.height ? size.width / 2 : size.height / 2;

    path.addOval(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius));

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
