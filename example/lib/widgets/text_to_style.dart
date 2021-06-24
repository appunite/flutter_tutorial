import 'package:flutter/material.dart';

class TextToStyle extends StatelessWidget {
  const TextToStyle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'STYLE\nTHE\nTEXT',
        style: TextStyle(
          fontSize: 66,
          fontStyle: FontStyle.italic,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
