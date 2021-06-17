import 'package:flutter/material.dart';

class TutorialTargetClipper extends CustomClipper<Path> {
  const TutorialTargetClipper(this.rrectList);

  final List<RRect> rrectList;

  @override
  Path getClip(Size size) {
    final path = Path();
    for (int i = 0; i < rrectList.length; i++) {
      path.addRRect(rrectList[i]);
    }
    return Path.combine(
        PathOperation.difference, Path()..addRect(Offset.zero & size), path);
  }

  @override
  bool shouldReclip(TutorialTargetClipper oldClipper) =>
      rrectList != oldClipper.rrectList;
}
