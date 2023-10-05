import 'package:flutter/material.dart';
import 'package:flutter_phone_number_field/flutter_phone_number_field.dart';
import 'package:get/get.dart';

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

  DateTime selectedDate = DateTime.now();

  final TextEditingController _controller = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _controller.text =
            "${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
        child: Directionality(
          textDirection: TextDirection.ltr,
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
              Expanded(child: ListView(children: [
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
                SizedBox(height: 10,),
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
                          text: 'لیڈی ہیلتھ ورکر کا شناختی نمبر',
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
                  height: 20,
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
                          text: 'شناختی کارڈ نمبر',
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
                  height: 20,
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
                          text: 'پاس ورڈ',
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
                TextField(
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
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                    child: TextField(
                      textAlign: TextAlign.right,
                      controller: _controller,
                      readOnly: true,
                      decoration: InputDecoration(
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
                Center(
                  child: Container(
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
                      onPressed: () {},
                      child: const Text(
                        'سائن اپ',
                        style: TextStyle(
                          fontFamily: 'UrduType',
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
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
              ],))

            ],
          ),
        ),
      ),
    );
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
