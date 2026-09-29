// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:test_task_evencier/app.dart';
import 'package:test_task_evencier/features/shell/main_shell.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task_evencier/data/repositories/mock_fitness_repository.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Prepare mock shared preferences and build our app.
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    final repo = MockFitnessRepository(latency: Duration.zero);
    await tester.pumpWidget(EvencirApp(prefs: prefs, repository: repo));

    // Verify that the main shell builds.
    await tester.pumpAndSettle();
    expect(find.byType(MainShell), findsOneWidget);
  });
}
