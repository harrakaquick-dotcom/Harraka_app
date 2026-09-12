import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:harraka/app.dart';
import 'package:harraka/features/auth/presentation/screens/login_screen.dart';

void main() {
  testWidgets('App boots and shows the splash screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: HarrakaApp()));
    await tester.pump();

    expect(find.text('Groceries at your door\nin 10 minutes'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });

  testWidgets('Get Started navigates to the signup screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: HarrakaApp()));
    await tester.pump();

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    expect(find.text('Create your account'), findsOneWidget);
  });

  testWidgets('Log in on the signup screen navigates to the login screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: HarrakaApp()));
    await tester.pump();

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
