import 'package:flutter/material.dart';
import 'package:flutter_phone_number_field/flutter_phone_number_field.dart';
import 'package:get/get.dart';
import 'package:lhw/Login_SignUp/Login.dart';
import 'package:lhw/controllers/otp_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controllers/signup_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool showVerificationCode = false;
  final _formkey = GlobalKey<FormState>();
  final controller = Get.put(SignUpController());
  var otp;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Center(
                  child: Text(
                "پاسورڈ بھول گے",
                style: TextStyle(fontFamily: "UrduType", fontSize: 30),
              )),
              const Directionality(
                textDirection: TextDirection.rtl,
                child: Center(
                  child: Text(
                    "وہ نمبر درج کریں جس میں آپ ری سیٹ لنک وصول کرنا چاہتے ہیں۔",
                    style: TextStyle(
                        fontFamily: "UrduType",
                        fontSize: 20,
                        color: Color(0xff878787)),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: RichText(
                  text: const TextSpan(
                    text: '*',
                    style: TextStyle(
                      color: Color(0xffEC5A53), // This makes the asterisk red
                      fontSize: 16,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'فون نمبر',
                        style: TextStyle(
                          fontFamily: "UrduType",
                          color: Colors.black, // Change the color as you want
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              FlutterPhoneNumberField(
                controller: controller.phone,
                showCountryFlag: true,
                showDropdownIcon: false,
                textAlign: TextAlign.right,
                initialCountryCode: "PK",
                pickerDialogStyle: PickerDialogStyle(
                  countryFlagStyle: const TextStyle(fontSize: 17),
                ),
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  hintText: 'اپنا موبائل نمبر درج کیجئے',
                  hintStyle: TextStyle(
                    fontFamily: "UrduType",
                    color: Color(0xff7A7D84),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        color: Color(
                            0xffCDD1E0)), // You can set it to transparent here.
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        color: Color(0xffCDD1E0)), // Grey border when enabled
                  ),
                ),
                languageCode: "ar",
                onChanged: (phone) {},
                onCountryChanged: (country) {},
              ),
              const SizedBox(
                height: 20,
              ),
              if (showVerificationCode) ...[
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 40, right: 40, bottom: 30),
                  child: PinCodeTextField(
                    obscureText: false,
                    length: 6,
                    animationDuration: const Duration(milliseconds: 300),
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    onSubmitted: (code) {
                      otp = code;
                      OTPController.instance.verifyOTP(otp);
                    },
                    appContext: context,
                  ),
                ),
              ],
              Center(
                child: RoundedButton(
                    title: 'لنک بھیجیں۔',
                    onTap: () {
                      setState(() {
                        showVerificationCode = true;
                      });
                      if (_formkey.currentState!.validate()) {
                        String formattedNumber = "+92" + controller.phone.text.trim();

                        SignUpController.instance
                            .phoneAuthentication(formattedNumber);
                      }

                      OTPController.instance.verifyOTP(otp);

                    }),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
