import 'package:flutter/material.dart';

class FlashCardScreenModel {
  final String title; // Main heading for the screen
  final List<FlashCard> cards; // List of flashcard objects

  FlashCardScreenModel({
    required this.title,
    required this.cards,
  });
}

class FlashCard {
  final String frontImage; // Path to the image on the front side
  final String heading; // Title displayed on the back side
  final String description; // Optional description on the back side
  final Color? titleColor; // Optional color for the title

  FlashCard({
    required this.frontImage,
    required this.heading,
    required this.description,
    this.titleColor,
  });
}
