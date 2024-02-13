import 'dart:ui';

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
  final String? newDraggableImage; // New image path after successful drop
  final String?
  newBackgroundImage; // New background image path after successful drop, if applicable
  final bool
  moveToNextOnDrop; // Whether to move to the next image on successful drop

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
}