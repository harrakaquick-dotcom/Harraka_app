import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:harraka/app.dart';
import 'package:harraka/features/auth/presentation/screens/login_screen.dart';
import 'package:harraka/features/auth/presentation/screens/otp_screen.dart';
import 'package:harraka/features/auth/presentation/screens/signup_screen.dart';
import 'package:harraka/features/onboarding/presentation/screens/onboarding_screen.dart';

void main() {
  testWidgets('App boots and shows the splash screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: HarrakaApp()));
    await tester.pump();

    expect(find.text('Groceries at your door\nin 10 minutes'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });

  testWidgets('Get Started navigates to the onboarding screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: HarrakaApp()));
    await tester.pump();

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(find.text('Ten minutes. That is the whole promise.'), findsOneWidget);
  });

  testWidgets('Skip on onboarding navigates to the signup screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: HarrakaApp()));
    await tester.pump();

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.byType(SignupScreen), findsOneWidget);
  });

  testWidgets('Log in on the signup screen navigates to the login screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: HarrakaApp()));
    await tester.pump();

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('OTP keypad auto-advances focus and enables verify when complete', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: OtpScreen(phoneNumber: '9876543210')),
    );
    await tester.pump();

    Future<void> tapDigit(String digit) async {
      await tester.tap(find.widgetWithText(InkWell, digit));
      await tester.pump();
    }

    final boxes = find.byType(TextField);
    expect(boxes, findsNWidgets(4));

    await tapDigit('9');
    await tapDigit('8');
    await tapDigit('7');

    var fields = tester.widgetList<TextField>(boxes).toList();
    expect(fields[0].controller!.text, '9');
    expect(fields[1].controller!.text, '8');
    expect(fields[2].controller!.text, '7');
    expect(fields[3].controller!.text, isEmpty);
    // typing auto-advanced focus onto the still-empty 4th box.
    expect(fields[3].focusNode!.hasFocus, isTrue);

    await tapDigit('6');

    // verify button is disabled until all 4 boxes are filled.
    final verifyButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(verifyButton.onPressed, isNotNull);

    await tester.tap(find.byIcon(Icons.backspace_outlined));
    await tester.pump();

    fields = tester.widgetList<TextField>(boxes).toList();
    expect(fields[3].controller!.text, isEmpty);
    // verify button is disabled again once the code is incomplete.
    expect(
      tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
      isNull,
    );

    await tapDigit('6');
    expect(
      tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
      isNotNull,
    );
  });
}
