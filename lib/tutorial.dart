import 'package:flutter/material.dart';
import 'package:flutter_tutorial/tutorial_entry.dart';
import 'package:flutter_tutorial/tutorial_widget.dart';

class Tutorial {
  bool _isVisible = false;
  OverlayEntry? _overlayBackground;

  void show<T extends TutorialEntry>(
    BuildContext context, {
    GlobalKey<TutorialWidgetState>? key,
    required List<T> children,
    required DialogBuilder dialogBuilder,
    Color backgroundColor = Colors.black,
    double backgroundMaxOpacity = 0.5,
    ValueNotifier<int>? indexController,
    AnimationController? opacityAnimationController,
    AnimationController? highlightAnimationController,
    Animation<double>? opacityAnimation,
    Animation<double>? highlightAnimation,
    OnPressedBehavior onPressedBehavior = OnPressedBehavior.none,
    Future<void> Function()? prepareNext,
  }) {
    if (!_isVisible) {
      _isVisible = true;

      key = key ?? GlobalKey<TutorialWidgetState>();

      _overlayBackground = _overlayBackground ??
          OverlayEntry(
            builder: (BuildContext context) => TutorialWidget<T>(
              key: key,
              children: children,
              close: () => _close(key!),
              dialogBuilder: dialogBuilder,
              backgroundColor: backgroundColor,
              backgroundMaxOpacity: backgroundMaxOpacity,
              indexController: indexController,
              highlightAnimation: highlightAnimation,
              opacityAnimation: opacityAnimation,
              opacityAnimationController: opacityAnimationController,
              highlightAnimationController: highlightAnimationController,
              onPressedBehavior: onPressedBehavior,
              prepareNext: prepareNext,
            ),
          );

      Overlay.of(context)?.insert(_overlayBackground!);
    }
  }

  Future _close(GlobalKey<TutorialWidgetState> key) async {
    if (_isVisible) {
      await key.currentState?.reverse();
      _overlayBackground?.remove();

      _isVisible = false;
    }
  }
}
