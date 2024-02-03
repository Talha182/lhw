import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  String dropdownvalue = 'اس ہفتے';
  var items = [
    'اس ہفتے',
    'Item 2',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "نشانی",
                    style: TextStyle(fontFamily: "UrduType", fontSize: 24),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Row(
                        children: [
                          Expanded(
                            child: Text(
                              'اس ہفتے',
                              style: TextStyle(
                                fontFamily: 'UrduType',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
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
                                    fontSize: 16,
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
                        height: 35,
                        width: 90,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black),
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
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView(
              children: [
                BookMarksCard(
                  image: Image.asset("assets/images/1.png"),
                  title: 'باب 1 تعارف',
                  gradient: LinearGradient(
                      colors: [Color(0xffED8DCE), Color(0xffF4B9E1)]),
                ),
                const SizedBox(
                  height: 15,
                ),
                BookMarksCard(
                  image: Image.asset("assets/images/2.png"),
                  title: 'باب 1 تعارف',
                  gradient: LinearGradient(
                      colors: [Color(0xffF38E17), Color(0xffFABF7A)]),
                ),
                const SizedBox(
                  height: 15,
                ),
                BookMarksCard(
                  image: Image.asset(
                    "assets/images/3.png",
                    fit: BoxFit.cover,
                  ),
                  title: 'باب 1 تعارف',
                  gradient: LinearGradient(
                      colors: [Color(0xff9747FF), Color(0xffA795FC)]),
                ),
                const SizedBox(
                  height: 15,
                ),
                BookMarksCard(
                  image: Image.asset(
                    "assets/images/4.png",
                    fit: BoxFit.cover,
                  ),
                  title: 'باب 1 تعارف',
                  gradient: LinearGradient(
                      colors: [Color(0xff37B4D6), Color(0xff5BC9E7)]),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class BookMarksCard extends StatelessWidget {
  final String title;
  final Image image;
  final LinearGradient gradient;

  const BookMarksCard({
    super.key,
    required this.title,
    required this.image,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300)),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, gradient: gradient),
                    child: ClipOval(child: image),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style:
                        const TextStyle(fontFamily: "UrduType", fontSize: 16),
                  )
                ],
              ),
              const Icon(Icons.more_vert_rounded)
            ],
          ),
        ),
      ),
    );
  }
}
