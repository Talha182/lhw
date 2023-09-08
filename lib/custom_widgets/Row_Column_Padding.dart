import 'package:flutter/material.dart';

List<Widget> rowPadded(List<Widget> widgets, double padding) {
  List<Widget> paddedWidgets = [];

  for (int i = 0; i < widgets.length; i++) {
    paddedWidgets.add(widgets[i]);
    if (i < widgets.length - 1) {
      paddedWidgets.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
      ));
    }
  }
  return paddedWidgets;
}

List<Widget> columnPadded(List<Widget> widgets, double padding) {
  List<Widget> paddedWidgets = [];

  for (int i = 0; i < widgets.length; i++) {
    paddedWidgets.add(widgets[i]);
    if (i < widgets.length - 1) {
      paddedWidgets.add(Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
      ));
    }
  }
  return paddedWidgets;
}
