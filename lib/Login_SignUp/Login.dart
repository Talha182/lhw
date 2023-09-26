import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool _isChecked = false;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
              "خوش آمدید",
              style: TextStyle(fontFamily: "UrduType", fontSize: 30),
            )),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "میں نئے ہیں؟",
                    style: TextStyle(
                        fontFamily: "UrduType",
                        fontSize: 20,
                        color: Color(0xff878787)),
                  ),
                  GestureDetector(
                    child: Text(
                      "سائن اپ",
                      style: TextStyle(
                          fontFamily: "UrduType",
                          fontSize: 20,
                          color: Color(0xffFE8BD1)),
                    ),
                  ),
                  Text(
                    "LHW",
                    style: TextStyle(
                        fontFamily: "UrduType",
                        fontSize: 20,
                        color: Color(0xff878787)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "لیڈی ہیلتھ ورکر کا شناختی نمبر*",
              style: TextStyle(
                  fontFamily: "UrduType",
                  fontSize: 16,
                  color: Color(0xff0F0D18)),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              keyboardType: TextInputType.phone,
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
              height: 25,
            ),
            Text(
              "پاس ورڈ",
              style: TextStyle(
                  fontFamily: "UrduType",
                  fontSize: 16,
                  color: Color(0xff0F0D18)),
            ),
            SizedBox(
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
            SizedBox(
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
                    'لاگ ان کریں',
                    style: TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    CustomCheckbox(
                      value: _isChecked,
                      onChanged: (value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    ), SizedBox(width: 10,),
                    Text(
                      "مجھے پہچانتے ہو",
                      style: TextStyle(
                          fontFamily: "UrduType",
                          fontSize: 16,
                          color: Color(0xff0F0D18)),
                    ),
                  ],),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Text(
                      "پاسورڈ بھول گے؟",
                      style: TextStyle(
                          fontFamily: "UrduType",
                          fontSize: 16,
                          color: Color(0xffFE8BD1)),
                    ),
                  ),

                ],
              ),
            )
          ],
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
          border: Border.all(width: 1.0, color: Color(0xffE5E5E5)),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: widget.value ? Icon(Icons.check, size: 20.0) : null,
      ),
    );
  }
}
