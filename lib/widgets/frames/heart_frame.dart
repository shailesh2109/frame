// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class HeartClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double width = size.width;
    double height = size.height;
    double halfWidth = width / 2;
    double halfHeight = height / 2;
    double quarterWidth = width / 4;
    double eighthHeight = height / 8;

    path.moveTo(halfWidth, eighthHeight);

    path.cubicTo(quarterWidth, -eighthHeight, 0, halfHeight - eighthHeight,
        halfWidth, height - eighthHeight);

    path.cubicTo(width, halfHeight - eighthHeight, halfWidth + quarterWidth,
        -eighthHeight, halfWidth, eighthHeight);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class HeartFrame extends StatelessWidget {
  const HeartFrame({
    Key? key,
    required this.image,
  }) : super(key: key);
  final File image;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HeartClipper(),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Image.file(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
