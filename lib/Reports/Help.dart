import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.white,
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 5),
                  child: GestureDetector(
                    child: const Text(
                      "ہمیں لکھیں۔",
                      style: TextStyle(
                        fontFamily: 'UrduType',
                        fontSize: 20,
                        color: Color(0xffFE8BD1),
                        fontWeight: FontWeight.w600,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5, right: 40),
                  child: Text(
                    "مدد",
                    style: TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 20,
                      color: Color(0xff232323),
                      fontWeight: FontWeight.w600,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    child: const Icon(Icons.arrow_forward),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffE3E3E3))),
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "کورس کا مواد",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 26,
                            color: Color(0xff72C391)),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Divider(
                        thickness: 1,
                        color: Color(0xffE0E0E0),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      _buildExpandablePanel(
                          "کورس کا مواد کس پر مبنی ہے؟", "کورس کا مواد لیڈی ہیلتھ ورکرز کے لیے حکومت کی طرف سے مقرر کردہ نصاب پر مبنی ہے۔"),
                      SizedBox(height: 20,),
                      Divider(
                        thickness: 1,color: Color(0xffE0E0E0),
                      ), SizedBox(
                        height: 7,
                      ),
                      _buildExpandablePanel(
                          "کورس کا مواد کس پر مبنی ہے؟", "کورس کا مواد لیڈی ہیلتھ ورکرز کے لیے حکومت کی طرف سے مقرر کردہ نصاب پر مبنی ہے۔"),
                      SizedBox(height: 20,),
                      Divider(
                        thickness: 1,color: Color(0xffE0E0E0),
                      ), SizedBox(
                        height: 7,
                      ),
                      _buildExpandablePanel(
                          "کورس کا مواد کس پر مبنی ہے؟", "کورس کا مواد لیڈی ہیلتھ ورکرز کے لیے حکومت کی طرف سے مقرر کردہ نصاب پر مبنی ہے۔"),
                      SizedBox(height: 30,),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffE3E3E3))),
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "تکنیکی مسئلہ",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 26,
                            color: Color(0xff72C391)),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Divider(
                        thickness: 1,
                        color: Color(0xffE0E0E0),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      _buildExpandablePanel(
                          "کمجھے ایک ویڈیو میں پریشانی ہو رہی ہے۔ میں کیا کروں؟", "کورس کا مواد لیڈی ہیلتھ ورکرز کے لیے حکومت کی طرف سے مقرر کردہ نصاب پر مبنی ہے۔"),
                     SizedBox(height: 30,),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),

              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffE3E3E3))),
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "اکاؤنٹ کی ترتیبات",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 26,
                            color: Color(0xff72C391)),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Divider(
                        thickness: 1,
                        color: Color(0xffE0E0E0),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      _buildExpandablePanel(
                          "میں اپنے پروفائل میں تفصیلات کیسے تبدیل کر سکتا ہوں؟ ", "کورس کا مواد لیڈی ہیلتھ ورکرز کے لیے حکومت کی طرف سے مقرر کردہ نصاب پر مبنی ہے۔"),
                     SizedBox(height: 30,),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),

              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffE3E3E3))),
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "کوئز اور تشخیص",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 26,
                            color: Color(0xff72C391)),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Divider(
                        thickness: 1,
                        color: Color(0xffE0E0E0),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      _buildExpandablePanel(
                          "اگر میں نے اچھا نہیں کیا تو کیا میں پوسٹ کورس کے آخری کوئز کو دوبارہ آزما سکتا ہوں؟ ", "کورس کا مواد لیڈی ہیلتھ ورکرز کے لیے حکومت کی طرف سے مقرر کردہ نصاب پر مبنی ہے۔"),
                     SizedBox(height: 30,),

                    ],
                  ),
                ),
              ),  SizedBox(height: 20,),

              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffE3E3E3))),
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "بیجز اور شناخت",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 26,
                            color: Color(0xff72C391)),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Divider(
                        thickness: 1,
                        color: Color(0xffE0E0E0),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      _buildExpandablePanel(
                          "ایپ میں بیجز کیسے دیئے جاتے ہیں؟", "کورس کا مواد لیڈی ہیلتھ ورکرز کے لیے حکومت کی طرف سے مقرر کردہ نصاب پر مبنی ہے۔"),
                     SizedBox(height: 20,),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}



Widget _buildExpandablePanel(String title, String content) {
  return ExpandableNotifier(
    //initialize the controller
    controller: ExpandableController(initialExpanded: false),
    child: ExpandablePanel(
      header: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: "UrduType",
                  fontSize: 20,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Builder(
              builder: (context) {
                var controller = ExpandableController.of(context);
                return Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: controller!.expanded
                        ? Color(0xff0ffFE8BD1)
                        : Color(0xffFE8BD1).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    controller.expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color:
                    controller.expanded ? Colors.white : Color(0xffFE8BD1),
                    size: 25,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      collapsed: Container(), // Empty Container
      expanded: Center(
        child: Text(
          content,
          style: TextStyle(
            fontFamily: "UrduType",
            fontSize: 20,
            color: Color(0xff414141),
          ),
        ),
      ),
      theme: const ExpandableThemeData(
        tapHeaderToExpand: true,
        tapBodyToCollapse: true,
        hasIcon: false,
      ),
    ),
  );
}
