import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_tutorial/flutter_tutorial.dart';
import 'package:flutter_tutorial/tutorial_widget.dart';

class ExampleTutorialEntry extends TutorialEntry {
  ExampleTutorialEntry(
    List<RRect> rrectList,
    this.text,
    this.alignment,
  ) : super(rrectList);

  final String text;
  final Alignment alignment;
}

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute(builder: (_) => const CounterPage());

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> with SingleTickerProviderStateMixin {
  static final _buttonKey = GlobalKey();
  static final _textKey = GlobalKey();
  static final _text1Key = GlobalKey();
  static final _text2Key = GlobalKey();

  int _counter = 0;
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

    SchedulerBinding.instance?.scheduleTask(
      () {
        final tutorialEntries = [
          ExampleTutorialEntry(
            [
              RRect.fromRectAndRadius(
                getBasicRect(_buttonKey),
                const Radius.circular(28),
              )
            ],
            'Press the button to increase counter',
            Alignment.center,
          ),
          ExampleTutorialEntry(
            [getBasicRRect(_textKey)],
            'Counter will be increased here',
            Alignment.bottomCenter,
          ),
          ExampleTutorialEntry(
            [
              getBasicRRect(_text1Key),
              RRect.fromRectAndCorners(
                getBasicRect(_text2Key).inflate(10),
              ),
            ],
            'Highlights 2 texts',
            Alignment.bottomCenter,
          ),
        ];
        Tutorial().show<ExampleTutorialEntry>(
          context,
          children: tutorialEntries,
          onPressedBehavior: OnPressedBehavior.next,
          backgroundColor: Colors.blue,
          backgroundMaxOpacity: 0.8,
          prepareNext: () async {
            await _animationController.reverse();
            _animationController.forward();
          },
          dialogBuilder: (context, index, next, previous) {
            final entry = tutorialEntries[index];
            _animationController.forward();
            return Align(
              alignment: entry.alignment,
              child: SafeArea(
                child: Material(
                  color: Colors.transparent,
                  child: AnimatedBuilder(
                    animation: _opacityAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _opacityAnimation.value,
                        child: child,
                      );
                    },
                    child: Text(
                      entry.text,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      Priority.animation,
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              key: _textKey,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'You have pushed the button this many times:',
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Text 1',
                  key: _text1Key,
                ),
                Text(
                  'Text 2',
                  key: _text2Key,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: _buttonKey,
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
