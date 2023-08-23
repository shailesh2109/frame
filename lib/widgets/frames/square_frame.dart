import 'package:flutter/material.dart';

class SquareClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double side = size.width < size.height ? size.width : size.height;
    double padding = size.width / 5;
    path.moveTo(padding, 0);
    path.lineTo(side + padding, 0);
    path.lineTo(side + padding, side);
    path.lineTo(padding, side);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
