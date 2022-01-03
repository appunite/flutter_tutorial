import 'package:example/pages/text_edit_page.dart';
import 'package:example/text_edit_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

WidgetWrapper mainThemeWrapper() => materialAppWrapper(
      theme: textEditTheme,
      platform: TargetPlatform.iOS,
    );

void main() {
  const surfaceSize = Size(428.0, 926.0 - 47.0 - 38.0);

  testGoldens('Text Edit Page Step 1', (tester) async {
    await tester.pumpWidgetBuilder(
      const TextEditPage(),
      wrapper: mainThemeWrapper(),
      surfaceSize: surfaceSize,
    );

    await screenMatchesGolden(tester, 'text_edit_page_step_1');
  });

  Future<void> pressNextTip(WidgetTester tester) async {
    final finder = find.text('Next tip');
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  testGoldens('Text Edit Page Step 2', (tester) async {
    await tester.pumpWidgetBuilder(
      const TextEditPage(),
      wrapper: mainThemeWrapper(),
      surfaceSize: surfaceSize,
    );

    await tester.pumpAndSettle();

    await pressNextTip(tester);

    await screenMatchesGolden(tester, 'text_edit_page_step_2');
  });

  testGoldens('Text Edit Page Step 3', (tester) async {
    await tester.pumpWidgetBuilder(
      const TextEditPage(),
      wrapper: mainThemeWrapper(),
      surfaceSize: surfaceSize,
    );

    await tester.pumpAndSettle();

    await pressNextTip(tester);
    await pressNextTip(tester);

    await screenMatchesGolden(tester, 'text_edit_page_step_3');
  });

  testGoldens('Text Edit Page', (tester) async {
    await tester.pumpWidgetBuilder(
      const TextEditPage(),
      wrapper: mainThemeWrapper(),
      surfaceSize: surfaceSize,
    );

    await tester.pumpAndSettle();

    await pressNextTip(tester);
    await pressNextTip(tester);
    await pressNextTip(tester);

    await screenMatchesGolden(tester, 'text_edit_page');
  });
}
