import 'package:flutter/material.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({Key? key, this.onPressed}) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextButton(
        onPressed: onPressed ?? () {},
        child: const Text('Done'),
      ),
    );
  }
}
