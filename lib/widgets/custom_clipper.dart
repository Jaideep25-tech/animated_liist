import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height - 90);

    path.lineTo((size.width / 3) - 50, 0);

    path.quadraticBezierTo((size.width / 3) + 10, 0, (size.width / 3) + 50, 30);
    path.quadraticBezierTo((size.width / 2), 50, (size.width / 2) + 20, 30);
    path.quadraticBezierTo(size.width - (size.width / 2) + 60, 0,
        size.width - (size.width / 3) + 50, 0);

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
