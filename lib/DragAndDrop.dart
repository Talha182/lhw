import 'package:flutter/material.dart';

class DragDropScreen extends StatefulWidget {
  @override
  _DragDropScreenState createState() => _DragDropScreenState();
}

class _DragDropScreenState extends State<DragDropScreen> {
  Color targetColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drag and Drop Demo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              DraggableIcon(iconData: Icons.face),
              DraggableIcon(iconData: Icons.fingerprint),
              DraggableIcon(iconData: Icons.favorite),
              DraggableIcon(iconData: Icons.flight),
            ],
          ),
          DragTarget<IconData>(
            onWillAccept: (data) => true,
            onAccept: (data) {
              setState(() {
                targetColor = Colors.green;
              });
              // Implement your logic here, e.g., updating a list or state.
            },
            builder: (context, candidateData, rejectedData) {
              return Container(
                width: 200,
                height: 200,
                color: targetColor,
                child: const Center(
                  child: Icon(Icons.android, size: 100),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DraggableIcon extends StatelessWidget {
  final IconData iconData;

  const DraggableIcon({Key? key, required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<IconData>(
      data: iconData,
      child: Icon(iconData, size: 50),
      feedback: Material(
        type: MaterialType
            .transparency, // Needed for the icon to appear correctly when dragged
        child: Icon(iconData, size: 60, color: Colors.blue),
      ),
      childWhenDragging: const SizedBox(
        width: 50,
        height: 50,
      ), // Renders an empty container when dragging
    );
  }
}
