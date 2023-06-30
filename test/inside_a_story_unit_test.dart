import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:magic_pages/inside_story.dart';
import 'package:magic_pages/main.dart';
import './test_helpers.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('endToEnd', () {
    testWidgets(
        'next an previous buttons work',
        (tester) async => {
              //catch overflow exceptions
              FlutterError.onError = ignoreOverflowErrors,

              await tester.pumpWidget(InsideStory()),
              await tester.tap(find.byKey(const Key('nextButton'))),
              await tester.pumpAndSettle(),
              await tester.tap(find.byKey(const Key('previousButton'))),
              await tester.pumpAndSettle()
            });
  });
  runApp(const MyApp());
}
