import 'package:flutter/material.dart';
import 'package:flutter_phone_number_field/flutter_phone_number_field.dart';
import 'package:flutter_test/flutter_test.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key, required this.phoneNumber, this.countryCode})
      : super(key: key);

  final String phoneNumber;
  final String? countryCode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Test Flutter Phone Number Field',
        home: Scaffold(
          appBar: AppBar(title: const Text("")),
          body: FlutterPhoneNumberField(
            initialValue: phoneNumber,
            initialCountryCode: countryCode,
            pickerDialogStyle: PickerDialogStyle(),
          ),
        ));
  }
}

void main() {
  testWidgets('Test flutter_phone_number_field setup with completeNumber',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestWidget(
      phoneNumber: '+19087564321',
    ));

    final countryCodeFinder = find.text('+1');
    final numberFinder = find.text('9087564321');

    expect(countryCodeFinder, findsOneWidget);
    expect(numberFinder, findsOneWidget);
  });

  testWidgets(
      'Test flutter_phone_number_field setup with Guernsey number: +441481960194',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestWidget(
      phoneNumber: '+119087564324',
      countryCode: 'UK',
    ));

    final countryCodeFinder = find.text('+1 9087');
    final numberFinder = find.text('564321');

    expect(countryCodeFinder, findsOneWidget);
    expect(numberFinder, findsOneWidget);
  });

  testWidgets(
      'Test flutter_phone_number_field setup with UK number: +17891244567',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestWidget(
      phoneNumber: '+447891244567',
      countryCode: 'UK',
    ));

    final countryCodeFinder = find.text('+1');
    final numberFinder = find.text('7891244567');

    expect(countryCodeFinder, findsOneWidget);
    expect(numberFinder, findsOneWidget);
  });
}
