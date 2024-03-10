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
  final bool autoShowDialog; // New property
  final bool moveToNextOnDrop;
  final double dragTargetWidth;
  final double draggableImageWidth;
  final double draggableImageHeight;
  final double dragTargetHeight;
  final double draggableImageScale;
  final bool showGuideText;

  InteractiveImageModel({
    required this.image,
    required this.guide,
    required this.touchArea,
    this.dragTargetWidth = 300.0, // Default width
    this.dragTargetHeight = 300.0, // Default height
    this.showDialog = false,
    this.showGuideText = true,
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
    this.autoShowDialog = false, // Default to false
    this.draggableImageWidth = 100.0, // Default width
    this.draggableImageHeight = 100.0, // Default height
    this.draggableImageScale = 1.0, // Default scale is 1.0 (original size)
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
      draggableImageInitialPosition =
          Offset(dipJson['dx'].toDouble(), dipJson['dy'].toDouble());
    }

    // Parsing drag target position
    Offset? dragTargetPosition;
    if (json['dragTargetPosition'] != null) {
      final dtpJson = json['dragTargetPosition'];
      dragTargetPosition =
          Offset(dtpJson['dx'].toDouble(), dtpJson['dy'].toDouble());
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
      autoShowDialog: json['autoShowDialog'] ?? false,
      dragTargetWidth: json['dragTargetWidth']?.toDouble() ?? 200.0,
      dragTargetHeight: json['dragTargetHeight']?.toDouble() ?? 200.0,
      draggableImageWidth: json['draggableImageWidth']?.toDouble() ?? 100.0,
      draggableImageHeight: json['draggableImageHeight']?.toDouble() ?? 100.0,
      draggableImageScale: json['draggableImageScale']?.toDouble() ?? 1.0,
      showGuideText: json['showGuideText'] ?? true,
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
      'draggableImageInitialPosition': draggableImageInitialPosition != null
          ? {
              'dx': draggableImageInitialPosition!.dx,
              'dy': draggableImageInitialPosition!.dy
            }
          : null,
      'dragTargetPosition': dragTargetPosition != null
          ? {'dx': dragTargetPosition!.dx, 'dy': dragTargetPosition!.dy}
          : null,
      'newDraggableImage': newDraggableImage,
      'newBackgroundImage': newBackgroundImage,
      'moveToNextOnDrop': moveToNextOnDrop,
      'autoShowDialog': autoShowDialog,
      'dragTargetWidth': dragTargetWidth,
      'dragTargetHeight': dragTargetHeight,
      'draggableImageWidth': draggableImageWidth,
      'draggableImageHeight': draggableImageHeight,
      'draggableImageScale': draggableImageScale,
    };
  }
}
