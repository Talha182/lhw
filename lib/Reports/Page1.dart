import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
class NewPage1 extends StatefulWidget {
  const NewPage1({super.key});

  @override
  State<NewPage1> createState() => _NewPage1State();
}

class _NewPage1State extends State<NewPage1> {
  String dropdownvalue = 'اس ہفتے';

// List of items in our dropdown menu
  var items = [
    'باب 1',
    'باب 2',
  ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
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
                                    'باب 1',
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
                                .map((String item) =>
                                DropdownMenuItem<String>(
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
                              width: 70,
                              padding: const EdgeInsets.only(
                                  left: 14, right: 14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: const Color(0xff685F78)),
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
                                thickness:
                                MaterialStateProperty.all<double>(6),
                                thumbVisibility:
                                MaterialStateProperty.all<bool>(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding:
                              EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15,),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: const Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'باب 1',
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
                                .map((String item) =>
                                DropdownMenuItem<String>(
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
                              width: 70,
                              padding: const EdgeInsets.only(
                                  left: 14, right: 14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: const Color(0xff685F78)),
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
                                thickness:
                                MaterialStateProperty.all<double>(6),
                                thumbVisibility:
                                MaterialStateProperty.all<bool>(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding:
                              EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text("منقسم لیڈر بورڈز",style: TextStyle(
                    fontFamily: "UrduType",
                    fontSize: 18
                  ),)


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
class NewPage2 extends StatelessWidget {
  const NewPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
