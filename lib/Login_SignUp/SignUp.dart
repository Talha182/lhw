import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_number_field/flutter_phone_number_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lhw/Login_SignUp/Login.dart';
import 'package:lhw/controllers/signup_controller.dart';
import 'package:lhw/models/user_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;
  bool _isChecked = false;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null && selectedDate != DateTime.now()) {
      // Get the instance of SignUpController
      final signUpController = SignUpController.instance;

      // Format the selected date and set it to the dob controller of SignUpController
      signUpController.dob.text = "${selectedDate.toLocal()}".split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formkey = GlobalKey<FormState>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Center(
                    child: Text(
                  "ارے وہاں",
                  style: TextStyle(fontFamily: "UrduType", fontSize: 30),
                )),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "پہلے سے جانتے ہیں؟",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 20,
                            color: Color(0xff878787)),
                      ),
                      GestureDetector(
                        child: const Text(
                          "لاگ ان کریں",
                          style: TextStyle(
                              fontFamily: "UrduType",
                              fontSize: 20,
                              color: Color(0xffFE8BD1)),
                        ),
                      ),
                      const Text(
                        "LHW",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 20,
                            color: Color(0xff878787)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                    child: ListView(
                  children: [
                    const Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        "نام",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 16,
                            color: Color(0xff0F0D18)),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: controller.name,
                      keyboardType: TextInputType.emailAddress,
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
                    SizedBox(
                      height: 10,
                    ),
                    const Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        "ای میل",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 16,
                            color: Color(0xff0F0D18)),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: controller.email,
                      keyboardType: TextInputType.emailAddress,
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
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: const TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Color(
                                0xffEC5A53), // This makes the asterisk red
                            fontSize: 16,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'فون نمبر',
                              style: TextStyle(
                                fontFamily: "UrduType",
                                color: Colors
                                    .black, // Change the color as you want
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
                      controller: controller.phoneNo,
                      showCountryFlag: true,
                      showDropdownIcon: false,
                      textAlign: TextAlign.right,
                      initialCountryCode: "PK",
                      pickerDialogStyle: PickerDialogStyle(
                        countryFlagStyle: const TextStyle(fontSize: 17),
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
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
                              color: Color(
                                  0xffCDD1E0)), // Grey border when enabled
                        ),
                      ),
                      languageCode: "ar",
                      onChanged: (phone) {},
                      onCountryChanged: (country) {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: const TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Color(
                                0xffEC5A53), // This makes the asterisk red
                            fontSize: 16,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'لیڈی ہیلتھ ورکر کا شناختی نمبر',
                              style: TextStyle(
                                fontFamily: "UrduType",
                                color: Colors
                                    .black, // Change the color as you want
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
                    TextField(
                      controller: controller.id,
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
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: const TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Color(
                                0xffEC5A53), // This makes the asterisk red
                            fontSize: 16,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'شناختی کارڈ نمبر',
                              style: TextStyle(
                                fontFamily: "UrduType",
                                color: Colors
                                    .black, // Change the color as you want
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
                    TextField(
                      controller: controller.nic,
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
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: const TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Color(
                                0xffEC5A53), // This makes the asterisk red
                            fontSize: 16,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'پاس ورڈ',
                              style: TextStyle(
                                fontFamily: "UrduType",
                                color: Colors
                                    .black, // Change the color as you want
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
                    TextField(
                        controller: controller.password,
                        obscureText: _obscureText,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                            prefixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye,
                                color: Colors.black,
                              ),
                              onPressed: _toggleVisibility,
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
                            ))),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: const TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Color(
                                0xffEC5A53), // This makes the asterisk red
                            fontSize: 16,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'تاریخ پیدائش',
                              style: TextStyle(
                                fontFamily: "UrduType",
                                color: Colors
                                    .black, // Change the color as you want
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
                    GestureDetector(
                        child: TextField(
                      textAlign: TextAlign.right,
                      controller: controller.dob,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "MM/DD/YYYY",
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today_outlined,
                              color: Colors.black),
                          onPressed: () {
                            _selectDate(context);
                          },
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
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                  Obx(() {
                    if (SignUpController.instance.isLoading.value) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Center(
                        child: SizedBox(
                          width: Get.width,
                          height: 45,
                          child: RoundedButton(
                            title: "سائن اپ",
                            onTap: () async {
                              if (areFieldsEmpty([
                                SignUpController.instance.id,
                                SignUpController.instance.name,
                                SignUpController.instance.email,
                                SignUpController.instance.nic,
                                SignUpController.instance.phoneNo,
                                SignUpController.instance.password,
                                SignUpController.instance.dob
                              ])) {
                                Fluttertoast.showToast(
                                  msg: "Please fill all the fields!",
                                  backgroundColor: Colors.red.withOpacity(0.1),
                                  textColor: Colors.red,
                                );
                              } else if (_formkey.currentState!.validate()) {
                                await SignUpController.instance.RegisterUser(
                                  SignUpController.instance.email.text.trim(),
                                  SignUpController.instance.password.text.trim(),
                                );
                              }
                            },
                          ),
                        ),
                      );
                    }
                  }),
                    const SizedBox(
                      height: 10,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: [
                          CustomCheckbox(
                            value: _isChecked,
                            onChanged: (value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "مجھے پہچانتے ہو",
                            style: TextStyle(
                                fontFamily: "UrduType",
                                fontSize: 16,
                                color: Color(0xff0F0D18)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool areFieldsEmpty(List<TextEditingController> controllers) {
    for (var controller in controllers) {
      if (controller.text.trim().isEmpty) {
        return true;
      }
    }
    return false;
  }
}

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  CustomCheckbox({required this.value, required this.onChanged});

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: const Color(0xffE5E5E5)),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: widget.value ? const Icon(Icons.check, size: 20.0) : null,
      ),
    );
  }
}
