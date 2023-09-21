import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ProfileEdit extends StatelessWidget {
  ProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String initialCountry = 'US';
    PhoneNumber number = PhoneNumber(isoCode: 'US');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.white,
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 50, // Added this to make the space equally spread
                  ),
                  const Text(
                    "پروفائل میں ترمیم کریں",
                    style: TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 20,
                      color: Color(0xff232323),
                      fontWeight: FontWeight.w600,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  GestureDetector(
                    child: const Icon(Icons.arrow_forward, color: Colors.black),
                    onTap: () {
                      // Add your navigation logic here
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  child: const Text(
                    "پروفائل تصویر تبدیل کریں۔",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "UrduType",
                        color: Color(0xffFE8BD1)),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ClipOval(
                  child: Image.asset(
                    'assets/images/profile_pic.png', // replace with your asset image name
                    width: 80.0, // the width of the image widget
                    height: 80.0, // the height of the image widget
                    fit: BoxFit.cover,
                  ),
                )
              ],
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
                      text: 'پہلا نام',
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
            TextField(
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0), // Adjust vertical padding
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
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
                      text: 'آخری نام',
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
            TextField(
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0), // Adjust vertical padding
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
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
                      text: 'تاریخ پیدائش',
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
            TextField(
              readOnly: true, // makes this TextField read-only
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );

                if (selectedDate != null && selectedDate != DateTime.now()) {
                  // Handle the selected date
                  print(selectedDate); // Replace this with your own logic
                }
              },
              decoration: InputDecoration(
                hintText: 'DD/MM/YYYY',
                hintStyle: const TextStyle(
                  color: Color(0xff7A7D84),fontSize: 13
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
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
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                print(number.phoneNumber);
              },
              onInputValidated: (bool value) {
                print(value);
              },
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                showFlags: false, // This should hide flags

              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              initialValue: number,
              textFieldController: null,
              inputDecoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              textStyle: const TextStyle(
                fontFamily: "UrduType",
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
