import 'package:flutter/material.dart';

class RedoButton extends StatelessWidget {
  const RedoButton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Icon(
        Icons.redo,
      ),
    );
  }
}
