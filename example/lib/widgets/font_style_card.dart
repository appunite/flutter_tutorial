import 'package:flutter/material.dart';

class FontStyleCard extends StatelessWidget {
  const FontStyleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 19,
              offset: const Offset(0, 12),
              color: Colors.black.withOpacity(0.11),
            ),
            BoxShadow(
              blurRadius: 11,
              color: Colors.black.withOpacity(0.11),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                StyleButton(
                  icon: Icons.format_bold,
                ),
                StyleButton(
                  icon: Icons.format_italic,
                  isSelected: true,
                ),
                StyleButton(
                  icon: Icons.format_underline,
                ),
                StyleButton(
                  icon: Icons.format_strikethrough,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xFFf3f3f3),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.remove,
                        ),
                        Expanded(
                          child: Text(
                            '16',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Icon(
                          Icons.add,
                        ),
                      ],
                    ),
                  ),
                ),
                const StyleButton(
                  icon: Icons.format_align_center,
                ),
                const StyleButton(
                  icon: Icons.more_horiz,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StyleButton extends StatelessWidget {
  const StyleButton({
    Key? key,
    required this.icon,
    this.isSelected = false,
  }) : super(key: key);

  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: isSelected ? Colors.white : const Color(0xFFf3f3f3),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.secondary
                : const Color(0xFFf3f3f3),
            width: 2,
          ),
        ),
        child: Icon(
          icon,
          color: isSelected ? Theme.of(context).colorScheme.secondary : null,
        ),
      ),
    );
  }
}
