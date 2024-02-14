import 'package:flutter/material.dart';

class FlashCardScreenModel {
  final String title;
  final List<FlashCard> cards;

  FlashCardScreenModel({
    required this.title,
    required this.cards,
  });

  factory FlashCardScreenModel.fromJson(Map<String, dynamic> json) {
    return FlashCardScreenModel(
      title: json['title'],
      cards: List<FlashCard>.from(
        json['flashCards'].map((x) => FlashCard.fromJson(x as Map<String, dynamic>)),
      ),
    );
  }
}

class FlashCard {
  final String frontImage;
  final String heading;
  final String description;
  final Color? titleColor;

  FlashCard({
    required this.frontImage,
    required this.heading,
    required this.description,
    this.titleColor,
  });

  factory FlashCard.fromJson(Map<String, dynamic> json) {
    return FlashCard(
      frontImage: json['frontImage'],
      heading: json['heading'],
      description: json['description'],
      titleColor: _parseColor(json['titleColor']),
    );
  }

  static Color? _parseColor(String? colorString) {
    if (colorString == null) {
      return null;
    }
    String hexColor = colorString.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
