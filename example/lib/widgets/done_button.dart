import 'package:flutter/material.dart';

class DoneButton extends StatelessWidget {
  const DoneButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextButton(
        onPressed: () {},
        child: const Text('Done'),
      ),
    );
  }
}
