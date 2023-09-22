import 'package:flutter_phone_number_field/src/countries.dart';
import 'package:flutter_phone_number_field/src/phone_number.dart';
import 'package:test/test.dart';

void main() {
  group('PhoneNumber', () {
    test('create a phone number', () {
      PhoneNumber phoneNumber = PhoneNumber(
          countryISOCode: "TG", countryCode: "+228", number: "93333401");
      String actual = phoneNumber.completeNumber;
      String expected = "+22893333401";

      expect(actual, expected);
      expect(phoneNumber.isValidNumber(), true);
    });

    test('create a Togo number', () {
      PhoneNumber phoneNumber = PhoneNumber(
          countryISOCode: "TG", countryCode: "+228793", number: "333401");
      String actual = phoneNumber.completeNumber;
      String expected = "+22893333401";

      expect(actual, expected);
      expect(phoneNumber.isValidNumber(), true);
    });

    test('look up TG as a country code', () {
      Country country = PhoneNumber.getCountry("+22893333401");
      expect(country.name, "Togo");
      expect(country.code, "TG");
      expect(country.regionCode, "");
    });

    test('look up Togo as a country code', () {
      Country country = PhoneNumber.getCountry("+22893333401");
      expect(country.name, "Togo");
      expect(country.code, "TG");
      expect(country.regionCode, "9333");
    });

    test('create with empty complete number', () {
      PhoneNumber phoneNumber =
          PhoneNumber.fromCompleteNumber(completeNumber: "");
      expect(phoneNumber.countryISOCode, "");
      expect(phoneNumber.countryCode, "");
      expect(phoneNumber.number, "");
      expect(() => phoneNumber.isValidNumber(),
          throwsA(const TypeMatcher<NumberTooShortException>()));
    });

    test('create HK  number +85212345678', () {
      PhoneNumber phoneNumber =
          PhoneNumber.fromCompleteNumber(completeNumber: "+85212345678");
      expect(phoneNumber.countryISOCode, "HK");
      expect(phoneNumber.countryCode, "852");
      expect(phoneNumber.number, "12345678");
      expect(phoneNumber.isValidNumber(), true);
    });

    test('Number is too short number +8521234567', () {
      PhoneNumber ph =
          PhoneNumber.fromCompleteNumber(completeNumber: "+8521234567");
      expect(() => ph.isValidNumber(),
          throwsA(const TypeMatcher<NumberTooShortException>()));
    });

    test('cannot create from too long number +852123456789', () {
      PhoneNumber ph =
          PhoneNumber.fromCompleteNumber(completeNumber: "+852123456789");

      expect(() => ph.isValidNumber(),
          throwsA(const TypeMatcher<NumberTooLongException>()));
    });

    test('create UK PhoneNumber from +447891234567', () {
      PhoneNumber phoneNumber =
          PhoneNumber.fromCompleteNumber(completeNumber: "+447891234567");
      expect(phoneNumber.countryISOCode, "GB");
      expect(phoneNumber.countryCode, "44");
      expect(phoneNumber.number, "7891234567");
      expect(phoneNumber.isValidNumber(), true);
    });

    test('create Guernsey PhoneNumber from +441481960194', () {
      PhoneNumber phoneNumber =
          PhoneNumber.fromCompleteNumber(completeNumber: "+441481960194");
      expect(phoneNumber.countryISOCode, "GG");
      expect(phoneNumber.countryCode, "441481");
      expect(phoneNumber.number, "960194");
      expect(phoneNumber.isValidNumber(), true);
    });

    test('create alpha character in  PhoneNumber from +44abcdef', () {
      expect(() => PhoneNumber.fromCompleteNumber(completeNumber: "+44abcdef"),
          throwsA(const TypeMatcher<InvalidCharactersException>()));
    });

    test('create alpha character in  PhoneNumber from +44abcdef1', () {
      expect(() => PhoneNumber.fromCompleteNumber(completeNumber: "+44abcdef1"),
          throwsA(const TypeMatcher<InvalidCharactersException>()));
    });
  });

  test("get number from complete phone number (+22893333401)", () {
    const completeNumber = "+22893333401";
    final number = PhoneNumber.getNumber(completeNumber);
    expect(number, "93333401");
  });
}
