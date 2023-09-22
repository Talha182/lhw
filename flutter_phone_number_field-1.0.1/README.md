<!--
Developer: Kalybos Prosper Kokou Ahianyo
Githb: http://github.com/KalybosPro
-->
##International Phone Field Package
pub v1.0.1

A customised Flutter TextFormField to input international phone number along with country code.

This widget can be used to make customised text field to take phone number input for any country along with an option to choose country code from a dropdown.You will be able to modify country flags size when building Flutter Web app.

## Features

<img src="https://github.com/KalybosPro/flutter_phone_number_field/blob/main/Screenshot_20230728-123143.jpg" height="500px"/>
<img src="https://github.com/KalybosPro/flutter_phone_number_field/blob/main/Screenshot_20230728-123401.jpg" height="500px"/>
<img src="https://github.com/KalybosPro/flutter_phone_number_field/blob/main/Screenshot_20230728-123210.jpg" height="500px"/>
<img src="https://github.com/KalybosPro/flutter_phone_number_field/blob/main/Screenshot_20230728-123242.jpg" height="500px"/>


## Getting started

To use this package:

Run this command:

```dart
flutter pub add flutter_phone_number_field

```

Or, add the following to your pubspec.yaml file:

```dart
dependences:
    flutter_phone_number_field: ^1.0.1

```

## Usage

Simply create a FlutterPhoneNumberField widget, and pass the required params:

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_number_field/flutter_phone_number_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<FormState> formKey = GlobalKey();

  FocusNode focusNode = FocusNode();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Phone Number Field Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlutterPhoneNumberField(
                  focusNode: focusNode,
                  initialCountryCode: "TG",
                  pickerDialogStyle: PickerDialogStyle(
                    countryFlagStyle: const TextStyle(fontSize: 17),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  languageCode: "en",
                  onChanged: (phone) {
                    if (kDebugMode) {
                      print(phone.completeNumber);
                    }
                  },
                  onCountryChanged: (country) {
                    if (kDebugMode) {
                      print('Country changed to: ${country.name}');
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    formKey.currentState?.validate();
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

```
Use `initialCountryCode` to set an initial Country Code.
Use `webCountryIconWidth` to set country flag width if you are building Flutter Web app

## Update phone number

To update phone number on your update page, you need to display the phone number you juste
took earlier in the TextFormField by passsing to controller. To do this, call the founction
`PhoneNumber.getNumber(String completeNumber)`.

## update_page.dart

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_number_field/flutter_phone_number_field.dart';

class UpdatePage extends StatefulWidget {
  final String name, email, phone;
  const UpdatePage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? phoneNumber;

  @override
  void initState() {
    setState(() {
      phoneNumberController.text = PhoneNumber.getNumber(widget.phone);
      nameController.text = widget.name;
      emailController.text = widget.email;
    });
    super.initState();
  }

  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Phone Number Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30),
               TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
               TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FlutterPhoneNumberField(
                controller: phoneNumberController,
                focusNode: focusNode,
                initialCountryCode: "TG",
                pickerDialogStyle: PickerDialogStyle(
                  countryFlagStyle: const TextStyle(fontSize: 17),
                ),
                decoration: const InputDecoration(
                  hintText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                languageCode: "en",
                onChanged: (phone) {
                  setState(() {
                    phoneNumber = phone.completeNumber;
                  });
                  if (kDebugMode) {
                    print(phone.completeNumber);
                  }
                },
                onCountryChanged: (country) {
                  if (kDebugMode) {
                    print('Country changed to: ${country.name}');
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (kDebugMode) {
                      print("Phone number is: $phoneNumber");
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

```