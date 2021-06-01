import 'package:flutter/material.dart';

Rect getBasicRect(GlobalKey key) {
  final target = key.currentContext?.findRenderObject() as RenderBox;
  return target.localToGlobal(Offset.zero) & target.size;
}

RRect getBasicRRect(GlobalKey key) => RRect.fromRectAndRadius(getBasicRect(key), Radius.zero);
