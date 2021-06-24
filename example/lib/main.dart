import 'package:example/main_theme.dart';
import 'package:example/widgets/done_button.dart';
import 'package:example/widgets/font_style_card.dart';
import 'package:example/widgets/redo_button.dart';
import 'package:example/widgets/select_font_widget.dart';
import 'package:example/widgets/text_to_style.dart';
import 'package:example/widgets/undo_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mainTheme,
      home: const PreviewPage(),
    );
  }
}

class PreviewPage extends StatelessWidget {
  const PreviewPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: const [
            UndoButton(),
            SizedBox(width: 24),
            RedoButton(),
          ],
        ),
        actions: const [
          DoneButton(),
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            child: TextToStyle(),
          ),
          SelectFontWidget(),
          SizedBox(height: 32),
          FontStyleCard(),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
