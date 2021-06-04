import 'package:flutter/material.dart';
import 'package:flutter_tutorial/rrect_tween.dart';
import 'package:flutter_tutorial/tutorial_entry.dart';
import 'package:flutter_tutorial/tutorial_target_clipper.dart';

typedef DialogBuilder = Widget Function(
  BuildContext context,
  int index,
  VoidCallback next,
  VoidCallback previous,
);

enum OnPressedBehavior {
  /// When pressed outside the dialog widget tutorial will terminate
  close,

  /// When pressed outside the dialog widget tutorial will skip to next index
  next,

  /// When pressed outside the dialog widget tutorial no action will be taken
  none,
}

class TutorialWidget<T extends TutorialEntry> extends StatefulWidget {
  const TutorialWidget({
    Key? key,
    required this.children,
    required this.close,
    required this.dialogBuilder,
    this.backgroundColor = Colors.black,
    this.backgroundMaxOpacity = 0.5,
    this.opacityAnimationController,
    this.highlightAnimationController,
    this.opacityAnimation,
    this.highlightAnimation,
    this.onPressedBehavior = OnPressedBehavior.none,
    this.prepareNext,
  }) : super(key: key);

  final List<T> children;
  final VoidCallback close;
  final DialogBuilder dialogBuilder;
  final Color backgroundColor;
  final double backgroundMaxOpacity;
  final AnimationController? opacityAnimationController;
  final AnimationController? highlightAnimationController;
  final Animation<double>? opacityAnimation;
  final Animation<double>? highlightAnimation;
  final OnPressedBehavior onPressedBehavior;
  final Future<void> Function()? prepareNext;

  @override
  State<StatefulWidget> createState() => TutorialWidgetState();
}

class TutorialWidgetState extends State<TutorialWidget> with TickerProviderStateMixin {
  late ValueNotifier<int> _indexController;
  late AnimationController _opacityController;
  late Animation<double> _opacityAnimation;
  late AnimationController _highlightController;
  late List<Animation<RRect>> _highlightAnimations;

  Future<void> reverse() => _opacityController.reverse();

  @override
  void initState() {
    super.initState();
    _initControllers();
    _initAnimations();
    _opacityController.forward();
  }

  void _initControllers() {
    _indexController = ValueNotifier<int>(0);
    _opacityController = widget.opacityAnimationController ??
        AnimationController(
          duration: const Duration(milliseconds: 500),
          vsync: this,
        );
    _highlightController = widget.highlightAnimationController ??
        AnimationController(
          duration: const Duration(milliseconds: 250),
          vsync: this,
        );
  }

  void _initAnimations() {
    _opacityAnimation = widget.opacityAnimation ??
        Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _opacityController,
            curve: const Interval(
              0.0,
              1.0,
              curve: Curves.ease,
            ),
          ),
        );
    _highlightAnimations = _getCurrentHighlightAnimation(0);
  }

  List<Animation<RRect>> _getCurrentHighlightAnimation(int index) {
    final animation = widget.highlightAnimation ??
        CurvedAnimation(
          parent: _highlightController,
          curve: Curves.ease,
        );
    final children = widget.children;
    final rrectList = children[index].rrectList;
    final newRRectList = children[index + 1].rrectList;
    for (int i = 0; i < rrectList.length; i++) {}
    if (children.length - 1 == index)
      return rrectList
          .map((rrect) => RRectTween(
                begin: rrect,
                end: rrect,
              ).animate(animation))
          .toList();
    if (rrectList.length > newRRectList.length) {
    } else if (rrectList.length < newRRectList.length) {
      return List.generate(
        newRRectList.length,
        (i) => RRectTween(
          begin: i >= rrectList.length ? rrectList.first : rrectList[i],
          end: newRRectList[i],
        ).animate(animation),
      );
    } else {
      return List.generate(
        newRRectList.length,
        (i) => RRectTween(
          begin: rrectList[i],
          end: i >= newRRectList.length ? newRRectList.first : newRRectList[i],
        ).animate(animation),
      );
    }
    return List.generate(
      rrectList.length,
      (i) => RRectTween(
        begin: rrectList[i],
        end: newRRectList[i],
      ).animate(animation),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacityController,
      builder: (context, child) {
        return Stack(
          children: <Widget>[
            Listener(
              behavior: HitTestBehavior.opaque,
              onPointerUp: _onPointer,
              onPointerDown: _onPointer,
              onPointerCancel: _onPointer,
              onPointerMove: _onPointer,
              child: AnimatedBuilder(
                animation: _highlightController,
                builder: (context, child) {
                  return ClipPath(
                    clipper: TutorialTargetClipper(
                      _highlightAnimations.map((animation) => animation.value).toList(),
                    ),
                    child: child,
                  );
                },
                child: Container(
                  color: widget.backgroundColor.withOpacity(
                    _opacityAnimation.value * widget.backgroundMaxOpacity,
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: _opacityAnimation.value,
              child: child,
            ),
          ],
        );
      },
      child: ValueListenableBuilder<int>(
        valueListenable: _indexController,
        builder: (context, value, child) {
          return widget.dialogBuilder(
            context,
            value,
            _nextIndex,
            _previousIndex,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _opacityController.dispose();
    _highlightController.dispose();
    super.dispose();
  }

  void _nextIndex() {
    if (_indexController.value + 1 == widget.children.length) {
      widget.close();
    } else {
      _indexController.value++;
      _highlightAnimations = _getCurrentHighlightAnimation(_indexController.value - 1);
      _highlightController.reset();
      _highlightController.forward();
    }
  }

  void _previousIndex() {
    _indexController.value--;
    if (_highlightController.isAnimating || _highlightController.isCompleted) {
      _highlightController.reverse();
    } else {
      _highlightAnimations = _getCurrentHighlightAnimation(_indexController.value);
      _highlightController.reverse(from: 1);
    }
  }

  Future<void> _onPointer(PointerEvent event) async {
    switch (widget.onPressedBehavior) {
      case OnPressedBehavior.close:
        widget.close();
        break;
      case OnPressedBehavior.next:
        if (!event.down) {
          if (widget.prepareNext != null) {
            await widget.prepareNext!();
          }
          _nextIndex();
        }
        break;
      default:
        break;
    }
  }
}
