import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../test/Features/ObjectivesTree.dart';
import '../test/Features/ObjectivesTreeHorizontal.dart';

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int currentPage = 0;
  // Removed assetImages list and replaced with a list of ObjectivesTree widgets
  final List<Widget> pages = [
     ObjectivesTree(), // Assuming you want multiple instances or different configurations
     ObjectivesTree(),
    // Add more instances as needed
  ];
  @override
  void dispose() {
    // Reset orientation to be flexible when the widget is disposed
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 170, // Make sure this height matches your desired height or is flexible
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black87.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.5),
          ),
          child: pages[currentPage], // Display the ObjectivesTree
        ),
        Positioned(
          right: 10,
          bottom: 10, // Position the full-screen button
          child: FloatingActionButton(
            mini: true, // Make the button smaller
            onPressed: () async {
              // Set orientation to landscape
              await SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeRight,
                DeviceOrientation.landscapeLeft,
              ]);
              // Navigate to the horizontal version of the ObjectivesTree
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  ObjectivesTreeHorizontal()));
            },
            child: Icon(Icons.fullscreen),
          ),
        ),
        Positioned(
          left: 10,
          top: 60,
          child: GestureDetector(
            onTap: () {
              setState(() {
                currentPage = currentPage > 0 ? currentPage - 1 : pages.length - 1;
              });
            },
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_back_ios_new, size: 20),
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 60,
          child: GestureDetector(
            onTap: () {
              setState(() {
                currentPage = (currentPage + 1) % pages.length;
              });
            },
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_forward_ios, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}
