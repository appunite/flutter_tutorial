import 'package:example/pages/counter_page.dart';
import 'package:example/pages/grid_view_page.dart';
import 'package:example/pages/text_edit_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: const Text(
                'Counter example',
              ),
              onTap: () => Navigator.push(context, CounterPage.route()),
            ),
            ListTile(
              title: const Text(
                'Grid view example',
              ),
              onTap: () => Navigator.push(context, GridViewPage.route()),
            ),
            ListTile(
              title: const Text(
                'Text edit example',
              ),
              onTap: () => Navigator.push(context, TextEditPage.route()),
            ),
          ],
        ),
      ),
    );
  }
}
