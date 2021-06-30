import 'package:flutter/material.dart';
import 'package:flutter_tutorial/get_basic_rrect.dart';

class TutorialEntry {
  const TutorialEntry(this.rrectList);

  TutorialEntry.single(RRect rrect) : rrectList = [rrect];

  TutorialEntry.fromKey(GlobalKey key)
      : rrectList = [
          getBasicRRect(key),
        ];

  TutorialEntry.multipleKeys(List<GlobalKey> keys)
      : rrectList = keys
            .map(
              (key) => getBasicRRect(key),
            )
            .toList();

  /// Object references to highlight.
  final List<RRect> rrectList;
}
