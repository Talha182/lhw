import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_number_field/flutter_phone_number_field.dart';
import 'package:get/get.dart';

import '../LoginSignUp/Login.dart';

class ProfileEdit extends StatefulWidget {
  ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    // if (pickedDate != null) {
    //   dobController.text = '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
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
                      Get.back();
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
                    'assets/images/profile_pic.png',
                    // replace with your asset image name
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
                      text: ' نام',
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
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
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
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                hintText: "DD/MM/YY",
                hintStyle: const TextStyle(fontSize: 13),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
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
            FlutterPhoneNumberField(
              showCountryFlag: false,
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
              height: 10,
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
                      text: 'صوبہ',
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
                hintText: "منتخب کریں۔",
                hintStyle: const TextStyle(
                  fontFamily: "UrduType",
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.black,
                ), // Added dropdown icon on the left
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
                      text: 'شہر',
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
                hintText: "منتخب کریں۔",
                hintStyle: const TextStyle(
                  fontFamily: "UrduType",
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.black,
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
                      text: 'یو سی کا نام',
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
                hintText: "منتخب کریں۔",
                hintStyle: const TextStyle(
                  fontFamily: "UrduType",
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.black,
                ), // Added dropdown icon on the left
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
                      text: 'گاؤں',
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
                hintText: "منتخب کریں۔",
                hintStyle: const TextStyle(
                  fontFamily: "UrduType",
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.black,
                ), // Added dropdown icon on the left
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
                      text: 'ای میل (بطور اختیاری)',
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
              keyboardType: TextInputType.emailAddress,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: "ای میل درج کریں۔",
                hintStyle: const TextStyle(
                  fontFamily: "UrduType",
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
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
                      text: 'LHW شناختی نمبر',
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
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "LHW ID نمبر درج کریں۔",
                hintStyle: const TextStyle(
                  fontFamily: "UrduType",
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
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
                      text: 'سروس کے سال',
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
              // controller: serviceController,
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: "سروس کے سال درج کریں۔",
                hintStyle: const TextStyle(
                  fontFamily: "UrduType",
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color(0xffCDD1E0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              title: 'Update profile',
              onTap: () {},
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
