import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ResourcesPdf extends StatefulWidget {
  const ResourcesPdf({super.key});

  @override
  State<ResourcesPdf> createState() => _ResourcesPdfState();
}

class _ResourcesPdfState extends State<ResourcesPdf> {
  String dropdownvalue = 'اس ہفتے';

// List of items in our dropdown menu
  var items = [
    'ماڈیول 1',
    'ماڈیول 2',
  ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = (screenWidth - 55) /
        2; // 10 for left padding, 10 for right padding, and 10 for space between containers

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'ماڈیول 1',
                                  style: TextStyle(
                                      fontFamily: 'UrduType',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: items
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontFamily: 'UrduType',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (String? value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: 40,
                            width: 80,
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: const Color(0xff685F78)),
                            ),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.keyboard_arrow_down_sharp,
                            ),
                            iconSize: 14,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 100,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            offset: const Offset(-20, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(20),
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility:
                                  MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  "منقسم لیڈر بورڈز",
                  style: TextStyle(fontFamily: "UrduType", fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PdfContainer(
                  containerWidth: containerWidth,
                  text: 'بعد از پیدائش کی دیکھ بھال',
                ),
                PdfContainer(
                  containerWidth: containerWidth,
                  text: 'تعارف',
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PdfContainer(
                  containerWidth: containerWidth,
                  text: 'کمیونٹی کے ساتھ کام کرنا ل',
                ),
                PdfContainer(
                  containerWidth: containerWidth,
                  text: 'بین الشخصی مکاملہ...',
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // Your onPressed logic here
              },
              child: const Text(
                'سب دیکھیں',
                style: TextStyle(
                    fontFamily: "UrduType",
                    color: Color(0xffFE8BD1),
                    fontSize: 17),
              ),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0), // Set elevation to 0

                backgroundColor: MaterialStateProperty.all(
                    Colors.pink.shade50), // light pink
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 500,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.only(top: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [const Text("حالیہ فائلیں۔",style: TextStyle(
                    fontFamily: "UrduType",
                    fontSize: 18
                  ),),
                    const SizedBox(height: 20,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                  padding:EdgeInsets.only(top: 10),
                                  child: SvgPicture.asset("assets/images/filter.svg")),
                              const SizedBox(width: 5,),
                              const Text("نام",style: TextStyle(
                                  fontFamily: "UrduType",
                                  fontSize: 20,color: Color(0xff8E8E8E)
                              ),),
                            ],
                          ),

                          Row(
                            children: [
                              Padding(
                                  padding:EdgeInsets.only(top: 10),
                                  child: SvgPicture.asset("assets/images/filter.svg")),
                              const SizedBox(width: 5,),
                              const Text("آخری بار کھولا گیا۔",style: TextStyle(
                                  fontFamily: "UrduType",
                                  fontSize: 20,color: Color(0xff8E8E8E)

                              ),),
                            ],
                          ),

                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Color(0xffDED9E9),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                  padding:EdgeInsets.only(top: 10),
                                  child: SvgPicture.asset("assets/images/file.svg",width: 17,height: 17,)),
                              const SizedBox(width: 5,),
                              const Text("باب 1.pdf",style: TextStyle(
                                  fontFamily: "UrduType",
                                  fontSize: 16,color: Color(0xff685F78)
                              ),),
                            ],
                          ),

                          Row(
                            children: [
                              Padding(
                                  padding:EdgeInsets.only(top: 10),
                                  child: SvgPicture.asset("assets/images/filter.svg")),
                              const SizedBox(width: 5,),
                              const Text("14/05/2023 - 17:15",style: TextStyle(
                                  fontFamily: "UrduType",
                                  fontSize: 16,color: Color(0xff685F78)

                              ),),
                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                  padding:EdgeInsets.only(top: 10),
                                  child: SvgPicture.asset("assets/images/file.svg",width: 17,height: 17,)),
                              const SizedBox(width: 5,),
                              const Text("باب 1.pdf",style: TextStyle(
                                  fontFamily: "UrduType",
                                  fontSize: 16,color: Color(0xff685F78)
                              ),),
                            ],
                          ),

                          Row(
                            children: [
                              Padding(
                                  padding:EdgeInsets.only(top: 10),
                                  child: SvgPicture.asset("assets/images/filter.svg")),
                              const SizedBox(width: 5,),
                              const Text("14/05/2023 - 17:15",style: TextStyle(
                                  fontFamily: "UrduType",
                                  fontSize: 16,color: Color(0xff685F78)

                              ),),
                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                  padding:EdgeInsets.only(top: 10),
                                  child: SvgPicture.asset("assets/images/file.svg",width: 17,height: 17,)),
                              const SizedBox(width: 5,),
                              const Text("باب 1.pdf",style: TextStyle(
                                  fontFamily: "UrduType",
                                  fontSize: 16,color: Color(0xff685F78)
                              ),),
                            ],
                          ),

                          Row(
                            children: [
                              Padding(
                                  padding:EdgeInsets.only(top: 10),
                                  child: SvgPicture.asset("assets/images/filter.svg")),
                              const SizedBox(width: 5,),
                              const Text("14/05/2023 - 17:15",style: TextStyle(
                                  fontFamily: "UrduType",
                                  fontSize: 16,color: Color(0xff685F78)

                              ),),
                            ],
                          ),

                        ],
                      ),
                    ),



                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PdfContainer extends StatelessWidget {
  const PdfContainer({
    super.key,
    required this.containerWidth,
    required this.text,
  });

  final double containerWidth;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth,
      height: 220,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  "assets/images/bookmark.svg",
                  width: 18,
                  height: 18,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/eye.svg",
                      width: 14,
                      height: 14,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SvgPicture.asset(
                      "assets/images/download1.svg",
                      width: 15,
                      height: 15,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            SvgPicture.asset(
              "assets/images/pdf.svg",
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "پی ڈی ایف",
              style: TextStyle(
                  fontFamily: "UrduType",
                  fontSize: 17,
                  color: Color(0xff685F78)),
            ),
            const Text(
              "12 ایم بی",
              style: TextStyle(
                  fontFamily: "UrduType",
                  fontSize: 17,
                  color: Color(0xff685F78)),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              text,
              style: const TextStyle(
                  fontFamily: "UrduType",
                  fontSize: 17,
                  color: Color(0xff685F78)),
            ),
          ],
        ),
      ),
    );
  }
}
