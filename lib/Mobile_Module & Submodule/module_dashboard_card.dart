import 'package:flutter/material.dart';

import 'Gradient_Circle_Progress_Bar.dart';

class Module_Card extends StatelessWidget {
  const Module_Card(
      {Key? key,
      required this.progressValue,
      required this.showProgressBar,
      required this.imagePath,
      required this.cardText,
      required this.onClick})
      : super(key: key);

  final double progressValue;
  final bool showProgressBar;
  final VoidCallback onClick;
  final String imagePath; // Add this line
  final String cardText; // Add this line

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
            color: const Color(0xffeaeaea).withOpacity(0.4),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      imagePath, // Updated this line
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      cardText, // Updated this line
                      style: const TextStyle(
                          fontFamily: 'UrduType',
                          fontSize: 16,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w400),
                      softWrap: true,
                      // Set softWrap to true to enable text wrapping
                      overflow: TextOverflow.ellipsis, // or TextOverflow.fade
                    ),
                  ],
                ),
                // if (showProgressBar)
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: GradientCircleProgressBar(
                      strokeWidth: 3.0,
                      value: progressValue,
                      backgroundColor: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
