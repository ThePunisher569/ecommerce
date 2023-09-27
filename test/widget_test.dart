import 'package:ecommerce/ui/login/login_screen.dart';
import 'package:ecommerce/ui/login/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// This test case is to makes sure that all the widgets in the login_screen.dart
  /// is pumped into widget tree.
  testWidgets('Login screen widgets test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Login(),
    ));

    final phoneInputField = find.byType(PhoneInputField);
    final otpInputField = find.byType(OTPInputField);
    final loginButton = find.byType(FilledButton);

    expect(phoneInputField, findsOneWidget);
    expect(otpInputField, findsOneWidget);
    expect(loginButton, findsOneWidget);
  });

  testWidgets('Logo widget test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Login(),
    ));

    final logoImage = find.byType(SvgPicture);
    final logoText = find.text('Commerce');

    expect(logoImage, findsOneWidget);
    expect(logoText, findsOneWidget);
  });

  testWidgets('Phone number validation test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Login(),
    ));

    // Phone number error validation
    await tester.enterText(find.byType(PhoneInputField), '3257873');

    // Trigger the login action
    await tester.tap(find.text('Login'));

    await tester.pump();

    // Expect a validation error message
    expect(find.text('Enter a valid 10-digit mobile number'), findsOneWidget);
  });

  testWidgets('OTP validation test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Login(),
    ));

    // Enter an invalid OTP (less than 4 digits)
    await tester.enterText(find.byType(OTPInputField), '456');

    // Trigger the login action
    await tester.tap(find.text('Login'));

    // Expect a validation error message
    expect(find.text('Invalid Username or Password'), findsOneWidget);
  });
}
