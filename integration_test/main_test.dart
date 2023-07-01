import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'test_helpers.dart';

import 'package:magic_pages/main.dart' as app;

//to run: flutter test integration_test
//choose windows
void main() {
  group('end-to-end test', () {
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('integration test', (tester) async {
      //ignore overflow errors
      FlutterError.onError = ignoreOverflowErrors;
      //set window size
      binding.window.physicalSizeTestValue = Size(800, 1900);

      app.main();
      //wait for the current story to load
      await tester.pumpAndSettle(const Duration(seconds: 5));

      //see the loading text is present
      expect(find.text('Continue reading...'), findsOneWidget);
    });
  });
}
