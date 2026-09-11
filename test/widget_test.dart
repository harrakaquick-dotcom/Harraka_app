import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:harraka/app.dart';

void main() {
  testWidgets('App boots and shows the splash screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: HarrakaApp()));
    await tester.pump();

    expect(find.text('Groceries at your door\nin 10 minutes'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });

  testWidgets('Get Started navigates to the login screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: HarrakaApp()));
    await tester.pump();

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsOneWidget);
  });
}
