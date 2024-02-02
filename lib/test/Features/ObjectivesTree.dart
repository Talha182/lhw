import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Assuming you'll use SVG objectivesTree

class ObjectivesTree extends StatelessWidget {
  const ObjectivesTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(30),
          width: double.infinity,
          height: 200,
          // Using Stack to overlay objectivesTree on top of the Container
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/objectivesTree/objectivesTree.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              // Overlaying IconButtons on the image
              Positioned(
                bottom: 15, // Adjust these values as needed
                left: 5,
                child: IconButton(
                  icon: SvgPicture.asset(
                    "assets/objectivesTree/girl-icon.svg",
                    color: Colors.white,
                    width: 50,
                    height: 50,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return buildDialog("Text for the girl icon");
                      },
                    );                    // Your action here
                  },
                ),
              ),
              Positioned(
                bottom: 10,
                left: 60, // Space out the objectivesTree as needed
                child: IconButton(
                  icon: SvgPicture.asset(
                    "assets/objectivesTree/globe-icon.svg",
                    width: 50,
                    height: 50,
                  ),
                  onPressed: () {
                    // Your action here
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return buildDialog("Text for the girl icon");
                      },
                    );
                  },
                ),
              ),
              Positioned(
                top: 60,
                right: 120, // Adjust for alignment
                child: IconButton(
                  icon: SvgPicture.asset(
                    "assets/objectivesTree/patient-icon.svg",
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return buildDialog("Text for the girl icon");
                      },
                    );
                    // Your action here
                  },
                ),
              ),
              Positioned(
                bottom: 28,
                right: 60, // Align to the right
                child: IconButton(
                  icon: SvgPicture.asset("assets/objectivesTree/plus-icon.svg",width: 20,height: 20,),
                  onPressed: () {
                    // Your action here
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return buildDialog("Text for the girl icon");
                      },
                    );
                  },
                ),
              ),
              // Centering an icon
              Positioned(
                top: 0,
                right: 120,
                child: IconButton(
                  icon: SvgPicture.asset(
                      "assets/objectivesTree/assessment-icon.svg",width: 30,height: 30,),
                  onPressed: () {
                    // Your action here
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return buildDialog("Text for the girl icon");
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
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
