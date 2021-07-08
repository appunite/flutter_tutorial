import 'package:flutter/material.dart';

extension Math on RRect {
  RRect operator +(RRect other) {
    return RRect.fromLTRBAndCorners(
      left + other.left,
      top + other.top,
      right + other.right,
      bottom + other.bottom,
      bottomLeft: blRadius + other.blRadius,
      bottomRight: brRadius + other.brRadius,
      topRight: trRadius + other.trRadius,
      topLeft: tlRadius + other.tlRadius,
    );
  }

  RRect operator -(RRect other) {
    return RRect.fromLTRBAndCorners(
      left - other.left,
      top - other.top,
      right - other.right,
      bottom - other.bottom,
      bottomLeft: blRadius - other.blRadius,
      bottomRight: brRadius - other.brRadius,
      topRight: trRadius - other.trRadius,
      topLeft: tlRadius - other.tlRadius,
    );
  }

  RRect operator *(double other) {
    return RRect.fromLTRBAndCorners(
      left * other,
      top * other,
      right * other,
      bottom * other,
      bottomLeft: Radius.elliptical(
        blRadius.x * other,
        blRadius.y * other,
      ),
      bottomRight: Radius.elliptical(
        brRadius.x * other,
        brRadius.y * other,
      ),
      topRight: Radius.elliptical(
        trRadius.x * other,
        trRadius.y * other,
      ),
      topLeft: Radius.elliptical(
        tlRadius.x * other,
        tlRadius.y * other,
      ),
    );
  }
}

/// An interpolation between two rrects, similar to [RectTween].
class RRectTween extends Tween<RRect> {
  RRectTween({
    required RRect begin,
    required RRect end,
  }) : super(begin: begin, end: end);

  @override
  RRect lerp(double t) {
    assert(begin != null);
    assert(end != null);
    return begin! + (end! - begin!) * t;
  }
}
