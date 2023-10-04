import 'package:flutter/material.dart';
import 'package:flutter_phone_number_field/flutter_phone_number_field.dart';
import 'package:get/get.dart';
import 'package:lhw/Login_SignUp/Login.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
                child: Text(
              "پاسورڈ بھول گے",
              style: TextStyle(fontFamily: "UrduType", fontSize: 30),
            )),
            Directionality(
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
            ), SizedBox(
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
            SizedBox(
              height: 5,
            ),
            FlutterPhoneNumberField(
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

            SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: Get.width,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFE8BD1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(150, 37),
                  ),
                  onPressed: () {
                    Get.to(
                            () => const LoginScreen(),
                        transition: Transition.fade,
                        duration: const Duration(milliseconds: 400)
                    );
                  },
                  child: const Text(
                    'لنک بھیجیں۔',
                    style: TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}


