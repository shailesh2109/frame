import 'package:celebrare_assignment/models/frame_types.dart';
import 'package:celebrare_assignment/widgets/frames/circle_frame.dart';
import 'package:celebrare_assignment/widgets/frames/heart_frame.dart';
import 'package:celebrare_assignment/widgets/frames/rectangle_clipper.dart';
import 'package:celebrare_assignment/widgets/frames/square_frame.dart';
import 'package:flutter/material.dart';

class ImageHelper {
  static CustomClipper<Path>? getImageFrame(Frame type) {
    switch (type) {
      case Frame.heart:
        return HeartClipper();

      case Frame.circle:
        return CircleClipper();

      case Frame.rectangle:
        return RectangleClipper();

      case Frame.square:
        return SquareClipper();

      case Frame.original:
        return null;
    }
  }
}
