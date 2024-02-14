import 'dart:ui';
import 'dart:convert'; // Import json library for encoding and decoding

class InteractiveImageModel {
  String image;
  final String guide;
  final Rect touchArea;
  final bool showDialog;
  final String dialogText;
  final bool swipeEnabled;
  final bool longPressEnabled;
  final String longPressAction;
  final bool dragDropEnabled;
  final String swipeAction;
  String? draggableImage;
  final Offset? draggableImageInitialPosition;
  final Offset? dragTargetPosition;
  final String? newDraggableImage;
  final String? newBackgroundImage;
  final bool moveToNextOnDrop;

  InteractiveImageModel({
    required this.image,
    required this.guide,
    required this.touchArea,
    this.showDialog = false,
    this.dialogText = '',
    this.swipeEnabled = false,
    this.longPressEnabled = false,
    this.longPressAction = '',
    this.dragDropEnabled = false,
    this.swipeAction = '',
    this.draggableImage,
    this.draggableImageInitialPosition,
    this.dragTargetPosition,
    this.newDraggableImage,
    this.newBackgroundImage,
    this.moveToNextOnDrop = false,
  });

  // JSON deserialization
  factory InteractiveImageModel.fromJson(Map<String, dynamic> json) {
    // Parsing touch area
    final touchAreaJson = json['touchArea'];
    final touchArea = Rect.fromLTWH(
      touchAreaJson['left'].toDouble(),
      touchAreaJson['top'].toDouble(),
      touchAreaJson['width'].toDouble(),
      touchAreaJson['height'].toDouble(),
    );

    // Parsing draggable image initial position
    Offset? draggableImageInitialPosition;
    if (json['draggableImageInitialPosition'] != null) {
      final dipJson = json['draggableImageInitialPosition'];
      draggableImageInitialPosition = Offset(dipJson['dx'].toDouble(), dipJson['dy'].toDouble());
    }

    // Parsing drag target position
    Offset? dragTargetPosition;
    if (json['dragTargetPosition'] != null) {
      final dtpJson = json['dragTargetPosition'];
      dragTargetPosition = Offset(dtpJson['dx'].toDouble(), dtpJson['dy'].toDouble());
    }

    return InteractiveImageModel(
      image: json['image'],
      guide: json['guide'],
      touchArea: touchArea,
      showDialog: json['showDialog'] ?? false,
      dialogText: json['dialogText'] ?? '',
      swipeEnabled: json['swipeEnabled'] ?? false,
      longPressEnabled: json['longPressEnabled'] ?? false,
      longPressAction: json['longPressAction'] ?? '',
      dragDropEnabled: json['dragDropEnabled'] ?? false,
      swipeAction: json['swipeAction'] ?? '',
      draggableImage: json['draggableImage'],
      draggableImageInitialPosition: draggableImageInitialPosition,
      dragTargetPosition: dragTargetPosition,
      newDraggableImage: json['newDraggableImage'],
      newBackgroundImage: json['newBackgroundImage'],
      moveToNextOnDrop: json['moveToNextOnDrop'] ?? false,
    );
  }

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'guide': guide,
      'touchArea': {
        'left': touchArea.left,
        'top': touchArea.top,
        'width': touchArea.width,
        'height': touchArea.height,
      },
      'showDialog': showDialog,
      'dialogText': dialogText,
      'swipeEnabled': swipeEnabled,
      'longPressEnabled': longPressEnabled,
      'longPressAction': longPressAction,
      'dragDropEnabled': dragDropEnabled,
      'swipeAction': swipeAction,
      'draggableImage': draggableImage,
      'draggableImageInitialPosition': draggableImageInitialPosition != null ? {'dx': draggableImageInitialPosition!.dx, 'dy': draggableImageInitialPosition!.dy} : null,
      'dragTargetPosition': dragTargetPosition != null ? {'dx': dragTargetPosition!.dx, 'dy': dragTargetPosition!.dy} : null,
      'newDraggableImage': newDraggableImage,
      'newBackgroundImage': newBackgroundImage,
      'moveToNextOnDrop': moveToNextOnDrop,
    };
  }
}
