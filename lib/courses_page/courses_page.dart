import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(
              70.0), // Set to 80.0, change thisa to your desired height
          child: AppBar(
            elevation: 1.0,
            backgroundColor: Colors.white,
            flexibleSpace: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "کورسز",
                        style: GoogleFonts.abhayaLibre(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          InkWell(
                            child: Image.asset(
                              'assets/icons/magnifier.png',
                              color: Colors.black,
                            ),
                            onTap: () {},
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            child: Image.asset(
                              'assets/icons/bell.png',
                              color: Colors.black,
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: Column(
        children: [],
      ),
    );
  }
}
