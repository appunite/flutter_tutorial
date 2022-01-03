import 'package:flutter/material.dart';
import 'package:flutter_tutorial/flutter_tutorial.dart';

const _keysLength = 16;
final _keys = List.generate(_keysLength, (_) => GlobalKey());
final _tutorials = [
  // 0 - single
  (BuildContext context) => Tutorial().show(
        context,
        children: [
          TutorialEntry.fromKey(_keys.first),
        ],
      ),
  // 1 - first to second
  (BuildContext context) => Tutorial().show(
        context,
        children: [
          TutorialEntry.fromKey(_keys[0]),
          TutorialEntry.fromKey(_keys[1]),
        ],
      ),
  // 2 - second to first
  (BuildContext context) => Tutorial().show(
        context,
        children: [
          TutorialEntry.fromKey(_keys[0]),
          TutorialEntry.fromKey(_keys[14]),
        ],
      ),
  // 3 - first to 2 others
  (BuildContext context) => Tutorial().show(
        context,
        children: [
          TutorialEntry.fromKey(_keys[0]),
          TutorialEntry.multipleKeys([_keys[12], _keys[14]]),
        ],
      ),
  // 4 - 2 others to first
  (BuildContext context) => Tutorial().show(
        context,
        children: [
          TutorialEntry.multipleKeys([_keys[12], _keys[14]]),
          TutorialEntry.fromKey(_keys[0]),
        ],
      ),
  // 5 - 2 others to 2 others
  (BuildContext context) => Tutorial().show(
        context,
        children: [
          TutorialEntry.multipleKeys([_keys[12], _keys[14]]),
          TutorialEntry.multipleKeys([_keys[3], _keys[5]]),
        ],
      ),
  // 6 - 3 to 1
  (BuildContext context) => Tutorial().show(
        context,
        children: [
          TutorialEntry.multipleKeys([_keys[12], _keys[14], _keys[4]]),
          TutorialEntry.fromKey(_keys[3]),
        ],
      ),
  // 7 - 1 to 3
  (BuildContext context) => Tutorial().show(
        context,
        children: [
          TutorialEntry.fromKey(_keys[3]),
          TutorialEntry.multipleKeys([_keys[12], _keys[14], _keys[4]]),
        ],
      ),
  // 8 - 3 to 3
  (BuildContext context) => Tutorial().show(
        context,
        children: [
          TutorialEntry.multipleKeys([_keys[12], _keys[14], _keys[4]]),
          TutorialEntry.multipleKeys([_keys[2], _keys[11], _keys[15]]),
        ],
      ),
  // 9 - 3 to 2
  (BuildContext context) => Tutorial().show(
        context,
        children: [
          TutorialEntry.multipleKeys([_keys[12], _keys[14], _keys[4]]),
          TutorialEntry.multipleKeys([_keys[8], _keys[11]]),
        ],
      ),
  // 10 - 2 to 3
  (BuildContext context) => Tutorial().show(
        context,
        children: [
          TutorialEntry.multipleKeys([_keys[8], _keys[11]]),
          TutorialEntry.multipleKeys([_keys[12], _keys[14], _keys[4]]),
        ],
      ),
  // 11 - 3 to 6
  (BuildContext context) => Tutorial().show(
        context,
        children: [
          TutorialEntry.multipleKeys([_keys[8], _keys[11], _keys[12]]),
          TutorialEntry.multipleKeys(
              [_keys[12], _keys[14], _keys[4], _keys[5], _keys[4], _keys[15]]),
        ],
      ),
  // 12 - 3 to 6 to 2
  (BuildContext context) => Tutorial().show(
        context,
        children: [
          TutorialEntry.multipleKeys([_keys[8], _keys[11], _keys[12]]),
          TutorialEntry.multipleKeys(
              [_keys[12], _keys[14], _keys[4], _keys[5], _keys[4], _keys[15]]),
          TutorialEntry.multipleKeys([_keys[3], _keys[5]]),
        ],
      ),
  // 13
  // 14
  // 15
];

class GridViewPage extends StatelessWidget {
  const GridViewPage();

  static Route route() =>
      MaterialPageRoute(builder: (_) => const GridViewPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: _keysLength ~/ 5,
          padding: const EdgeInsets.all(16),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: [
            for (int i = 0; i < _keysLength; i++) ...[
              GridItemWidget(
                key: _keys[i],
                index: i,
                color: Colors.accents[i],
                onTap: i >= _keysLength ? null : () => _tutorials[i](context),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class GridItemWidget extends StatelessWidget {
  const GridItemWidget({
    Key? key,
    required this.index,
    required this.color,
    this.onTap,
  }) : super(key: key);

  final int index;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        color: color,
        alignment: Alignment.center,
        child: Text(
          index.toString(),
          style: const TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}
