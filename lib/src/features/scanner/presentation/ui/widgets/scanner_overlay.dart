


import 'package:flutter/material.dart';

class ScannerOverlayClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double borderRadius = 12;
    double cutoutWidth = size.width * 0.6;
    double cutoutHeight = size.height * 0.3;
    double cutoutLeft = (size.width - cutoutWidth) / 2;
    double cutoutTop = (size.height - cutoutHeight) / 2;

    Path path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(cutoutLeft, cutoutTop, cutoutWidth, cutoutHeight),
          const Radius.circular(12),
        ),
      );

    return path..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(ScannerOverlayClipper oldClipper) => false;
}