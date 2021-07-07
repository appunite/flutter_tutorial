import 'package:flutter/material.dart';

class SelectFontWidget extends StatelessWidget {
  const SelectFontWidget({Key? key}) : super(key: key);

  static const _sideFontStyle = TextStyle(
    fontSize: 14,
    color: Color(0xFF908e8e),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: PageView(
              controller: PageController(
                initialPage: 1,
                viewportFraction: 0.8,
              ),
              children: const [
                Text(
                  'Comic Sans',
                  textAlign: TextAlign.right,
                  style: _sideFontStyle,
                ),
                Text(
                  'SF Pro Display',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Roboto',
                  style: _sideFontStyle,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Dot(),
              Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const Dot(),
              const Dot(),
              const Dot(),
              const Dot(),
              const Dot(),
            ],
          ),
        ],
      ),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 4,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFc7c7c7),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
