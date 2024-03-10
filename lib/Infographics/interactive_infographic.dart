import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class InteractiveInfographicsModel {
  final String image;
  final List<InfographicIcon> icons;

  InteractiveInfographicsModel({required this.image, required this.icons});

  factory InteractiveInfographicsModel.fromJson(Map<String, dynamic> json) {
    var iconsFromJson = json['icons'] as List;
    List<InfographicIcon> iconsList =
    iconsFromJson.map((i) => InfographicIcon.fromJson(i)).toList();
    return InteractiveInfographicsModel(
      image: json['image'],
      icons: iconsList,
    );
  }
}

class InfographicIcon {
  final String iconPath;
  final String message;
  final Offset offset;

  InfographicIcon({
    required this.iconPath,
    required this.message,
    required this.offset,
  });

  factory InfographicIcon.fromJson(Map<String, dynamic> json) {
    return InfographicIcon(
      iconPath: json['icon'],
      message: json['message'],
      offset: Offset(json['offset']['dx'], json['offset']['dy']),
    );
  }
}

class InteractiveInfographics extends StatefulWidget {
  final InteractiveInfographicsModel interactiveInfographicsModel;

  InteractiveInfographics({Key? key, required this.interactiveInfographicsModel}) : super(key: key);

  @override
  State<InteractiveInfographics> createState() => _InteractiveInfographicsState();
}

class _InteractiveInfographicsState extends State<InteractiveInfographics> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              widget.interactiveInfographicsModel.image,
              fit: BoxFit.fill,
            ),
          ),
          ...widget.interactiveInfographicsModel.icons.map((icon) => Positioned(
            left: icon.offset.dx,
            top: icon.offset.dy,
            child: IconButton(
              icon: SvgPicture.asset(
                icon.iconPath,
                width: 50,
                height: 50,
              ),
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => buildDialog(icon.message),
              ),
            ),
          )),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
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
              'assets/scripts/script11/2.png', // Replace with your image path
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
              'assets/scripts/script11/1.png', // Replace with your image path
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
