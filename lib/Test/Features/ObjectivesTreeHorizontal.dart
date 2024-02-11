import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class ObjectivesTreeHorizontal extends StatelessWidget {
  ObjectivesTreeHorizontal({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> iconsData = [
    {
      'icon': 'assets/objectivesTree/girl-icon.svg',
      'message': 'Text for the girl icon',
      'position': Alignment.bottomLeft,
      'offset': Offset(35, -60),
    },
    {
      'icon': 'assets/objectivesTree/globe-icon.svg',
      'message': 'Text for the globe icon',
      'position': Alignment.bottomLeft,
      'offset': Offset(170, -50),
    },
    {
      'icon': 'assets/objectivesTree/patient-icon.svg',
      'message': 'Text for the patient icon',
      'position': Alignment.topRight,
      'offset': Offset(-280, 140),
    },
    {
      'icon': 'assets/objectivesTree/plus-icon.svg',
      'message': 'Text for the plus icon',
      'position': Alignment.bottomRight,
      'offset': Offset(-160, -75),
    },
    {
      'icon': 'assets/objectivesTree/assessment-icon.svg',
      'message': 'Text for the assessment icon',
      'position': Alignment.topRight,
      'offset': Offset(-300, 20),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/objectivesTree/objectivesTree.jpg",
              fit: BoxFit.fill,
            ),
          ),
          ...iconsData.map((iconData) => Positioned(
            left: iconData['position'] == Alignment.bottomLeft || iconData['position'] == Alignment.topLeft ? iconData['offset'].dx : null,
            right: iconData['position'] == Alignment.bottomRight || iconData['position'] == Alignment.topRight ? -iconData['offset'].dx : null,
            top: iconData['position'] == Alignment.topRight || iconData['position'] == Alignment.topLeft ? iconData['offset'].dy : null,
            bottom: iconData['position'] == Alignment.bottomRight || iconData['position'] == Alignment.bottomLeft ? -iconData['offset'].dy : null,
            child: IconButton(
              icon: SvgPicture.asset(
                iconData['icon'],
                width: 50,
                height: 50,
              ),
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => buildDialog(iconData['message']),
              ),
            ),
          )),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ]);
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget buildDialog(String dialogText) {
     return Dialog(
       shape: const RoundedRectangleBorder(
         borderRadius: BorderRadius.zero, // This removes border radius
       ),
       child: Stack(
         clipBehavior: Clip.none, // Allows overflow of children outside the box
         children: <Widget>[
           // Dialog main content
           Container(
             padding: const EdgeInsets.all(20),
             margin: const EdgeInsets.only(
                 top: 20,
                 right: 60,
                 bottom: 60,
                 left: 60), // Adjust margins for image space
             child: ConstrainedBox(
               constraints: const BoxConstraints(
                 maxHeight: 120,
                 maxWidth: 150, // Set a maximum width for the text content
               ),
               child: Text(
                 dialogText,
                 textAlign:
                 TextAlign.center, // Ensures text is centered if short
                 style: const TextStyle(fontFamily: "UrduType", fontSize: 20),
               ),
             ),
           ),

           Positioned(
             bottom:
             -15, // Adjusted to fit within the dialog, below the green border
             left:
             -55, // Adjusted to fit within the dialog, below the green border
             child: Image.asset(
               'assets/script11/2.png', // Replace with your image path
               width: 180, // Adjust the size as needed
               height: 180, // Adjust the size as needed
             ),
           ),
           // Top-right Image (Second Image)
           Positioned(
             top:
             -40, // Adjusted to fit within the dialog, above the green border
             right:
             -50, // Adjusted to fit within the dialog, above the green border
             child: Image.asset(
               'assets/script11/1.png', // Replace with your image path
               width: 180, // Adjust the size as needed
               height: 180, // Adjust the size as needed
             ),
           ),
           // Green border Container (Overlaying Images)
           Positioned.fill(
             // This ensures the container fills the dialog but respects the margin
             child: Container(
               margin:
               const EdgeInsets.all(5), // Margin from the edge of the dialog
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20),
                 border:
                 Border.all(color: Colors.green, width: 2), // Green border
               ),
             ),
           ),
         ],
       ),
     );
   }
}