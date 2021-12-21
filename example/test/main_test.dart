import 'package:example/main.dart';
import 'package:example/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

WidgetWrapper mainThemeWrapper() => materialAppWrapper(
      theme: mainTheme,
      platform: TargetPlatform.iOS,
    );

void main() {
  const surfaceSize = Size(428.0, 926.0 - 47.0 - 38.0);

  testGoldens('Main Page Step 1', (tester) async {
    await tester.pumpWidgetBuilder(
      const PreviewPage(),
      wrapper: mainThemeWrapper(),
      surfaceSize: surfaceSize,
    );

    await screenMatchesGolden(tester, 'main_step1');
  });

  Future<void> pressNextTip(WidgetTester tester) async {
    final finder = find.text('Next tip');
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  testGoldens('Main Page Step 2', (tester) async {
    await tester.pumpWidgetBuilder(
      const PreviewPage(),
      wrapper: mainThemeWrapper(),
      surfaceSize: surfaceSize,
    );

    await tester.pumpAndSettle();

    await pressNextTip(tester);

    await screenMatchesGolden(tester, 'main_step2');
  });

  testGoldens('Main Page Step 3', (tester) async {
    await tester.pumpWidgetBuilder(
      const PreviewPage(),
      wrapper: mainThemeWrapper(),
      surfaceSize: surfaceSize,
    );

    await tester.pumpAndSettle();

    await pressNextTip(tester);
    await pressNextTip(tester);

    await screenMatchesGolden(tester, 'main_step3');
  });

  testGoldens('Main Page', (tester) async {
    await tester.pumpWidgetBuilder(
      const PreviewPage(),
      wrapper: mainThemeWrapper(),
      surfaceSize: surfaceSize,
    );

    await tester.pumpAndSettle();

    await pressNextTip(tester);
    await pressNextTip(tester);
    await pressNextTip(tester);

    await screenMatchesGolden(tester, 'main_page');
  });
}
