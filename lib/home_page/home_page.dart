import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ڈیش بورڈ",
            style: GoogleFonts.abhayaLibre(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Image.asset('assets/icons/magnifier.png'),
              onPressed: () {},
            ), //IconButton
            IconButton(
              icon: Image.asset('assets/icons/bell.png'),
              onPressed: () {},
            ), //IconButton
          ], //<Widget>[]
          elevation: 1.0,
          backgroundColor: Colors.white,

          systemOverlayStyle: SystemUiOverlayStyle.light,
        ), //AppBar
        body: const Center(
          child: Text(
            "",
            style: TextStyle(fontSize: 24),
          ), //Text
        ), //Center
      ), //Scaffold
      debugShowCheckedModeBanner: false, //Removing Debug Banner
    );
  }
  }
