import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/svg.dart';

class JourneyMapScreen extends StatelessWidget {
  final List<String> submoduleTitles;
  final List<String> submoduleDescriptions;
  final List<Offset> buttonPositions;
  final List<String> iconPaths; // Paths to the submodule icons
  final List<Function()> navigateActions; // List of navigation actions


  JourneyMapScreen({
    Key? key,
    required this.submoduleTitles,
    required this.submoduleDescriptions,
    required this.buttonPositions,
    required this.iconPaths,
    required this.navigateActions, // Include this in the constructor
  })  : assert(submoduleDescriptions.length == submoduleTitles.length),
        assert(buttonPositions.length == submoduleTitles.length),
        assert(iconPaths.length == submoduleTitles.length),
        assert(navigateActions.length ==
            submoduleTitles.length), // Ensure lists are of equal length
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: const Alignment(0, -0.2),
              colors: [
                const Color(0xff80B8FB).withOpacity(0.3),
                Colors.transparent,
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                  left: 10,
                  top: 180,
                  child: SvgPicture.asset("assets/images/path.svg")),
              Positioned(
                  left: 15,
                  top: 190,
                  child: SvgPicture.asset("assets/images/path_dots.svg")),
              Positioned(
                  left: 10,
                  top: 110,
                  child: SvgPicture.asset("assets/images/pencil.svg")),

              // Bottom buildings
              Positioned(
                  bottom: 0,
                  child: SvgPicture.asset("assets/images/build1.svg")),
              Positioned(
                  bottom: 0,
                  left: 80,
                  child: SvgPicture.asset("assets/images/build2.svg")),
              Positioned(
                  bottom: 0,
                  left: 200,
                  child: SvgPicture.asset("assets/images/build3.svg")),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset("assets/images/build4.svg")),
              Positioned(
                  bottom: 0,
                  child: SvgPicture.asset("assets/images/bottom.svg")),
              Positioned(
                  bottom: 60, // Adjust as needed
                  right: 15, // Adjust as needed
                  child: CircleAvatar(
                    backgroundColor: const Color(0xffF6B3D0),
                    radius: 30,
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: SvgPicture.asset(
                          "assets/images/samina_instructor.svg",
                          fit: BoxFit.fill,
                        )),
                  )),

              Stack(
                children: List.generate(submoduleTitles.length, (index) {
                  return Positioned(
                    left: buttonPositions[index].dx,
                    top: buttonPositions[index].dy,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          submoduleTitles[index],
                          style: TextStyle(
                            fontFamily: "UrduType",
                          ),
                        ), // Display the submodule title
                        SizedBox(width: 8), //
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffD9D9D9)),
                              shape: BoxShape.circle,
                              color: Colors.white),
                          child: Center(
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xffFF6BC5),
                              ),
                              child: Center(
                                child: IconButton(
                                  onPressed: () =>
                                      _showSubmoduleDialog(context, index),
                                  icon: SvgPicture.asset(
                                    iconPaths[index], // Use the SVG icon path
                                    width: 24, // Set an appropriate size
                                    height: 24,
                                  ),
                                  iconSize: 24, // Specify the icon size here
                                ),
                              ),
                            ),
                          ),
                        ), // Spacing between title and icon button
                      ],
                    ),
                  );
                }),
              ),
            ],
          )),
    );
  }

  void _showSubmoduleDialog(BuildContext context, int index) {
    showAnimatedDialog(
      curve: Curves.fastOutSlowIn,
      animationType: DialogTransitionType.sizeFade,
      duration: Duration(seconds: 1),
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 365,
              maxWidth: MediaQuery.of(context).size.width - 50,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "ماڈیول 1 - ذیلی ماڈل 1",
                      style: TextStyle(
                          fontFamily: "UrduType", color: Color(0xff685F78)),
                    ),
                    const Text(
                      "پاکستان میں غذائیت کی صورتحال",
                      style: TextStyle(fontFamily: "UrduType", fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        // Note: SvgPicture.asset requires the flutter_svg package.
                        // SvgPicture.asset("assets/images/person_card.svg",
                        //     color: const Color(0xff685F78)),
                        const SizedBox(width: 8),
                        const Text(
                          "12 کوئز",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "UrduType",
                              color: Color(0xff685F78)),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xff685F78)),
                        ),
                        const SizedBox(width: 8),
                        // SvgPicture.asset("assets/images/clock.svg",
                        //     color: const Color(0xff685F78)),
                        const SizedBox(width: 8),
                        const Text(
                          "01 گھنٹہ 30 منٹ",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "UrduType",
                              color: Color(0xff685F78)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "تفصیل",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 18, fontFamily: "UrduType"),
                    ),
                     Text(
                      submoduleDescriptions[index],
                      style: TextStyle(
                          fontFamily: "UrduType",
                          color: Color(0xff7A7D84),
                          height: 1.2),
                      textAlign: TextAlign.justify,
                    ),
                    Spacer(),
                    const Divider(thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            minimumSize: const Size(140, 40),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text(
                            'منسوخ کریں۔',
                            style: TextStyle(
                                fontFamily: "UrduType",
                                color: Colors.black,
                                fontSize: 15),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFE8BD1),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            minimumSize: const Size(140, 40),
                          ),
                          onPressed: () {

                            },
                          child: const Text(
                            'کورس جاری رکھیں',
                            style: TextStyle(
                              fontFamily: "UrduType",
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text('Submodule Description'),
    //       content: Text(submoduleDescriptions[index]),
    //       actions: <Widget>[
    //         TextButton(
    //           child: Text('Navigate'),
    //           onPressed: () {
    //             Navigator.of(context).pop(); // Close the dialog first
    //             navigateActions[index](); // Execute the navigation action
    //           },
    //         ),
    //         TextButton(
    //           child: Text('Close'),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}

class Submodule1 extends StatelessWidget {
  const Submodule1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Submodule2 extends StatelessWidget {
  const Submodule2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Submodule3 extends StatelessWidget {
  const Submodule3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
