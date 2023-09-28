import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class GroupsDiscussion extends StatelessWidget {
  const GroupsDiscussion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            flexibleSpace: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                          child: SvgPicture.asset(
                            'assets/images/bell.svg',
                            color: Colors.black,
                          ),
                          onTap: () {},
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          child: SvgPicture.asset(
                            'assets/images/magnifier.svg',
                            color: Colors.black,
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Text(
                      "ڈسکشن گروپس",
                      style: TextStyle(
                        fontFamily: 'UrduType',
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: [
              const Text(
                "تبادلہ خیال: بڑھیں اور ایک ساتھ سیکھیں۔",
                style: TextStyle(
                  fontFamily: 'UrduType',
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                "LHW کمیونٹی آپس میں جڑنے، بات چیت شروع کرنے، سوالات پوچھنے، ایک دوسرے کی مدد کرنے اور ایک ساتھ سیکھنے کی جگہ ہے۔ یہ جگہ آپ کے لیے ہے، اور ہمیں بہت خوشی ہے کہ آپ یہاں ہیں۔ شروع کرنے کے لیے تیار ہیں؟ ڈومین گفتگو چلا کر اپنے ساتھیوں کے ساتھ مشغول رہیں۔ ہر کورس کے لیے ایک گروپ وقف ہوتا ہے۔ کورس میں داخلہ لینے پر آپ خود بخود چیٹ میں شامل ہو جائیں گے۔",
                style: TextStyle(
                  fontFamily: 'UrduType',
                  fontSize: 14,
                  color: Color(0xff7A7D84),
                  fontWeight: FontWeight.w600,
                ),
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.right,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withOpacity(0.1))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(colors: [
                                  Color(0xffED8DCE),
                                  Color(0xffED8DCE)
                                ])),
                              child: ClipOval(
                                child: SvgPicture.asset(
                                  "assets/images/samina_group.svg",
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "جنرل چیٹ",
                            style:
                                TextStyle(fontFamily: "UrduType", fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "بحث شروع کریں۔",
                            style: TextStyle(
                                fontFamily: "UrduType",
                                fontSize: 18,
                                color: Color(0xffFE8BD1)),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          SvgPicture.asset(
                            "assets/images/Icon.svg",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(
                            width: 5,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
