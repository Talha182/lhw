import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Page2 extends StatefulWidget {
  Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
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
        padding: const EdgeInsets.only(top: 20),
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
                                    'ہفتہ وار',
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
                              width: 75,
                              padding: const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: const Color(0xff685F78)),
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
                      const SizedBox(
                        width: 15,
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: const Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'قومی',
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
                              width: 70,
                              padding: const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: const Color(0xff685F78)),
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
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'لوگ',
                    style: TextStyle(
                        fontFamily: "UrduType",
                        fontSize: 15,
                        color: Color(0xff7A7D84)),
                  ),
                  Text(
                    'پوائنٹس',
                    style: TextStyle(
                        fontFamily: "UrduType",
                        fontSize: 15,
                        color: Color(0xff7A7D84)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text(
                  '1',
                  style: TextStyle(
                      fontFamily: "UrduType",
                      color: Color(0xff7A7D84),
                      fontSize: 18),
                ),
                const SizedBox(
                  width: 10,
                ),
                PointsCard(
                  name: 'Tim Hudson',
                  points: '3',
                  image: Image.asset("assets/images/profile_pic.png"),
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                const Text(
                  '2',
                  style: TextStyle(
                      fontFamily: "UrduType",
                      color: Color(0xff7A7D84),
                      fontSize: 18),
                ),
                const SizedBox(
                  width: 10,
                ),
                PointsCard(
                  name: 'Kathryn Murphy',
                  points: '3',
                  image: Image.asset("assets/images/profile_pic.png"),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  '3',
                  style: TextStyle(
                      fontFamily: "UrduType",
                      color: Color(0xff7A7D84),
                      fontSize: 18),
                ),
                const SizedBox(
                  width: 10,
                ),
                PointsCard(
                  name: 'Brooklyn Simmons',
                  points: '3',
                  image: Image.asset("assets/images/profile_pic.png"),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  '4',
                  style: TextStyle(
                      fontFamily: "UrduType",
                      color: Color(0xff7A7D84),
                      fontSize: 18),
                ),
                const SizedBox(
                  width: 10,
                ),
                PointsCard(
                  name: 'Bessie Cooper',
                  points: '3',
                  image: Image.asset("assets/images/profile_pic.png"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PointsCard extends StatelessWidget {
  final String name;
  final Image image;
  final String points;

  PointsCard({
    Key? key, // Add the key parameter here
    required this.name,
    required this.image,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(child: image),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: "UrduType",
                      color: Color(0xff7A7D84),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Text(
                points,
                style: const TextStyle(
                  fontFamily: "UrduType",
                  color: Color(0xff7A7D84),
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopPerformers extends StatelessWidget {
  TopPerformers({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
