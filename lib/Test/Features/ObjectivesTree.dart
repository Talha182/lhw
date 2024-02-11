import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ObjectivesTree extends StatelessWidget {
   ObjectivesTree({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> objectives = [
    {
      'icon': 'assets/objectivesTree/girl-icon.svg',
      'message': 'Message for the girl icon',
      'position': {'bottom': 15.0, 'left': 5.0},
    },
    {
      'icon': 'assets/objectivesTree/globe-icon.svg',
      'message': 'Message for the globe icon',
      'position': {'bottom': 10.0, 'left': 80.0},
    },
    {
      'icon': 'assets/objectivesTree/patient-icon.svg',
      'message': 'Message for the patient icon',
      'position': {'top': 50.0, 'right': 130.0},
    },
    {
      'icon': 'assets/objectivesTree/plus-icon.svg',
      'message': 'Message for the plus icon',
      'position': {'bottom': 25.0, 'right': 60.0},
    },
    {
      'icon': 'assets/objectivesTree/assessment-icon.svg',
      'message': 'Message for the assessment icon',
      'position': {'top': 0.0, 'right': 130.0},
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/objectivesTree/objectivesTree.jpg",
              fit: BoxFit.fill,
            ),
          ),
          ...objectives.map((objective) => Positioned(
            bottom: objective['position']['bottom'],
            top: objective['position']['top'],
            left: objective['position']['left'],
            right: objective['position']['right'],
            child: IconButton(
              icon: SvgPicture.asset(
                objective['icon'],
                width: 30,
                height: 30,
              ),
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => buildDialog(objective['message']),
              ),
            ),
          )),
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
