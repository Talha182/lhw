import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressCircle extends StatelessWidget {
  final String text;

  const ProgressCircle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     Color backgroundColor = Colors.black87.withOpacity(0.5);

    final innerLayout = Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(150),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text, // Use the text passed as a constructor parameter
            textAlign: TextAlign.center,
            style:
                GoogleFonts.raleway(fontWeight: FontWeight.w500, fontSize: 13),
          ),
        ],
      ),
    );
    return innerLayout;
  }
}
