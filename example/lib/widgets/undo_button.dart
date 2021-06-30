import 'package:flutter/material.dart';

class UndoButton extends StatelessWidget {
  const UndoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Icon(
        Icons.undo,
      ),
    );
  }
}
