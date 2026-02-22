import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('App starts with StartScreen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CatchTheBallGame());

    // Verify that StartScreen is shown
    expect(find.text('Catch the Ball'), findsOneWidget);
    expect(find.text('Start Game'), findsOneWidget);
  });
}
