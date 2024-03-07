import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItlaatScreen extends StatefulWidget {
  const ItlaatScreen({super.key});

  @override
  State<ItlaatScreen> createState() => _ItlaatScreenState();
}

class _ItlaatScreenState extends State<ItlaatScreen> {
  bool firstState = false;
  bool secondState = false;
  bool thirdState = false;
  bool fourthState = false;
  bool fifthState = false;
  final List<DropdownMenuItem<String>> dropdownItems = [
    const DropdownMenuItem(value: 'فوری طور پر', child: Text('فوری طور پر')),
    const DropdownMenuItem(value: 'یومیہ', child: Text('یومیہ')),
    const DropdownMenuItem(value: 'ہفتہ وار', child: Text('ہفتہ وار')),
    const DropdownMenuItem(value: 'ماہانہ', child: Text('ماہانہ')),
  ];

  String selectedItem = 'فوری طور پر';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "اپنے مطابق اطلاعات حاصل کریں۔",
                style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                textAlign: TextAlign.right,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "فوری اور ای میل کی اطلاعات حاصل کرنے کا طریقہ چنیں۔",
                  style: TextStyle(
                      fontFamily: "UrduType",
                      fontSize: 13,
                      color: Color(0xff8B9DA0)),
                  textAlign: TextAlign.right,
                ),
              ),
              const Divider(),
              const Text(
                "اپنے مطابق اطلاعات حاصل کریں۔",
                style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                textAlign: TextAlign.right,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "فوری اور ای میل کی اطلاعات حاصل کرنے کا طریقہ چنیں۔",
                  style: TextStyle(
                      fontFamily: "UrduType",
                      fontSize: 13,
                      color: Color(0xff8B9DA0)),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              buildSwitchListTile(
                  "سبق کی یاد دہانیاں",
                  "مجھے کسی بھی شروع کردہ یونٹ میں میری پیشرفت کے بارے میں مطلع کریں۔",
                  firstState, (newValue) {
                setState(() => firstState = newValue);
              }),
              buildSwitchListTile(
                  "کامیابی اور انعامات کی تازہ ترین معلومات",
                  "جب میں اپنے علم کے سفر میں اہم سنگ میل یا تمغہ حاصل کرتی ہوں تو مجھے اطلاع دی جاۓ۔",
                  secondState, (newValue) {
                setState(() => secondState = newValue);
              }),
              buildSwitchListTile(
                  "مہارت پوزیشن میں تبدیلی",
                  "مجھے میری مہارت پوزیشن اور متعلقہ چیزوں میں تبدیلیوں کے بارے میں اطلاع دی جاۓ۔",
                  thirdState, (newValue) {
                setState(() => thirdState = newValue);
              }),
              buildSwitchListTile(
                  "تاثرات کی یاد دہانیاں",
                  "جب کورس کے مواد یا پلیٹ فارم کی خصوصیات کے لیے تاثرات درکار ہوں تو مجھے مطلع کریں۔",
                  fourthState, (newValue) {
                setState(() => fourthState = newValue);
              }),
              buildSwitchListTile(
                  " بات چیت گروپ",
                  "مجھے بات چیت گروپوں میں کسی بھی سرگرمی یا میسج کے بارے میں مطلع کریں۔",
                  fifthState, (newValue) {
                setState(() => fifthState = newValue);
              }),
              const Divider(),
              const Text(
                "اپنی مرضی کی گھنٹی چنیں۔",
                style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                textAlign: TextAlign.right,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "وہ زبان منتخب کریں جس میں آپ دیکھنا چاہتے ہیں۔",
                  style: TextStyle(
                      fontFamily: "UrduType",
                      fontSize: 13,
                      color: Color(0xff8B9DA0)),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(color: const Color(0xffCDD1E0)),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedItem,
                      icon: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black),
                      items: dropdownItems,
                      onChanged: (value) {
                        setState(() {
                          selectedItem = value!;
                        });
                      },
                      style: const TextStyle(fontFamily: "UrduType", fontSize: 20, color: Colors.black),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      itemHeight: 50,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),

              const Divider(),
              const SizedBox(height: 10,),

              const Text(
                "اطلاعات فریکوئنسی",
                style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                textAlign: TextAlign.right,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "اطلاعات کی تعداد مخصوص کریں۔",
                  style: TextStyle(
                      fontFamily: "UrduType",
                      fontSize: 13,
                      color: Color(0xff8B9DA0)),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(color: const Color(0xffCDD1E0)),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedItem,
                      icon: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black),
                      items: dropdownItems,
                      onChanged: (value) {
                        setState(() {
                          selectedItem = value!;
                        });
                      },
                      style: const TextStyle(fontFamily: "UrduType", fontSize: 20, color: Colors.black),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      itemHeight: 50,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ),
              ),

              // Other UI elements here
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSwitchListTile(
      String title, String subtitle, bool value, Function(bool) onChanged) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          const TextStyle(fontFamily: "UrduType", fontSize: 17),
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                          fontFamily: "UrduType",
                          fontSize: 13,
                          color: Color(0xff8B9DA0)),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: CupertinoSwitch(
                  activeColor: const Color(0xff72C391),
                  value: value,
                  onChanged: (newValue) => onChanged(newValue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
