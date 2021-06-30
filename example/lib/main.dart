import 'package:example/main_theme.dart';
import 'package:example/widgets/done_button.dart';
import 'package:example/widgets/font_style_card.dart';
import 'package:example/widgets/redo_button.dart';
import 'package:example/widgets/select_font_widget.dart';
import 'package:example/widgets/text_to_style.dart';
import 'package:example/widgets/undo_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_tutorial/flutter_tutorial.dart';
import 'package:flutter_tutorial/tutorial_widget.dart';

final _fontSelectKey = GlobalKey();
final _textKey = GlobalKey();
final _undoKey = GlobalKey();
final _redoKey = GlobalKey();

const _padding = EdgeInsets.symmetric(
  horizontal: 32,
  vertical: 12,
);
const _textStyle = TextStyle(
  fontSize: 32,
  color: Colors.white,
  fontWeight: FontWeight.w600,
  decoration: TextDecoration.none,
);

class TutorialEntryValue {
  const TutorialEntryValue({
    required this.text,
    required this.alignment,
  });

  final String text;
  final Alignment alignment;
}

const tutorialValues = [
  TutorialEntryValue(
    text: 'Swipe left and right to change font',
    alignment: Alignment.center,
  ),
  TutorialEntryValue(
    text: 'Tap text to edit',
    alignment: Alignment(0.0, 0.5),
  ),
  TutorialEntryValue(
    text: 'Undo and redo your changes',
    alignment: Alignment(0.0, -0.7),
  ),
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mainTheme,
      home: const PreviewPage(),
    );
  }
}

class PreviewPage extends StatefulWidget {
  const PreviewPage();

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.scheduleTask(
      () {
        Tutorial().show(
          context,
          children: [
            TutorialEntry.fromKey(_fontSelectKey),
            TutorialEntry.single(
              RRect.fromRectAndRadius(
                getBasicRect(_textKey).deflate(60),
                const Radius.circular(20),
              ),
            ),
            TutorialEntry.multipleKeys([
              _undoKey,
              _redoKey,
            ]),
          ],
          backgroundColor: Theme.of(context).primaryColor,
          backgroundMaxOpacity: 0.9,
          onPressedBehavior: OnPressedBehaviour.none,
          dialogBuilder: (context, index, next, __) {
            final value = tutorialValues[index];

            return TutorialDialog(
              value: value,
              next: next,
            );
          },
        );
      },
      Priority.animation,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            UndoButton(key: _undoKey),
            const SizedBox(width: 16),
            RedoButton(key: _redoKey),
          ],
        ),
        actions: [
          DoneButton(
            onPressed: () {
              Tutorial().show(
                context,
                children: [
                  TutorialEntry.fromKey(_fontSelectKey),
                  TutorialEntry.single(
                    RRect.fromRectAndRadius(
                      getBasicRect(_textKey).deflate(60),
                      const Radius.circular(20),
                    ),
                  ),
                  TutorialEntry.multipleKeys([
                    _undoKey,
                    _redoKey,
                  ]),
                ],
                backgroundColor: Theme.of(context).primaryColor,
                backgroundMaxOpacity: 0.9,
                onPressedBehavior: OnPressedBehaviour.none,
                dialogBuilder: (context, index, next, __) {
                  final value = tutorialValues[index];

                  return TutorialDialog(
                    value: value,
                    next: next,
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: TextToStyle(
              key: _textKey,
            ),
          ),
          SelectFontWidget(
            key: _fontSelectKey,
          ),
          const SizedBox(height: 16),
          const FontStyleCard(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class TutorialDialog extends StatefulWidget {
  const TutorialDialog({
    Key? key,
    required this.value,
    required this.next,
  }) : super(key: key);

  final TutorialEntryValue value;
  final VoidCallback next;

  @override
  _TutorialDialogState createState() => _TutorialDialogState();
}

class _TutorialDialogState extends State<TutorialDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: widget.value.alignment,
        child: AnimatedBuilder(
          animation: _opacityAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: child,
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: _padding,
                child: Text(
                  widget.value.text,
                  style: _textStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () async {
                  await _animationController.reverse();
                  widget.next();
                  await _animationController.forward();
                },
                child: const Text(
                  'Next tip',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
