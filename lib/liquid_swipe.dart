// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:liquid_swipe/Helpers/Helpers.dart';
// import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
// import 'package:liquid_swipe/liquid_swipe.dart';
//
// ///Class to hold data for itembuilder in Withbuilder app.
// class ItemData {
//   final Color color;
//   final String image;
//   final String text1;
//   final String text2;
//
//   ItemData(
//     this.color,
//     this.image,
//     this.text1,
//     this.text2,
//   );
// }
//
// /// Example of LiquidSwipe with itemBuilder
// class WithBuilder extends StatefulWidget {
//   @override
//   _WithBuilder createState() => _WithBuilder();
// }
//
// class _WithBuilder extends State<WithBuilder> {
//   int page = 0;
//   late LiquidController liquidController;
//   late UpdateType updateType;
//
//   List<ItemData> data = [
//     ItemData(
//         const Color(0xffF7E4ED),
//         "assets/images/onBoarding1.svg",
//         "لیڈی ہیلتھ ورکرز کو خوش آمدید!",
//         "یہ مضامین قدم قدم پر آپ کی رہنمائی کریں گے تا کہ آپ اپنے وقت پرعلم کی نئی منزلوں تک پہنچیں۔ "),
//     ItemData(
//       Color(0xffA8D1B3),
//       "assets/images/onBoarding2.svg",
//       "موبائل زیادہ استعمال نہیں کرتیں؟ ",
//       "فکر نہ کریں، ہم نے یہ ایپ آپ کے مطابق بنائی ہے۔ ",
//     ),
//     ItemData(
//       Color(0xffF4D5A7),
//       "assets/images/onBoarding3.svg",
//       "اپنی آن لائن سہیلی سمینہ سے ملیں !",
//       "سمجھنے میں مشکل ہو رہی ہے ؟ ہماری لیڈی ہیلتھ ورکر سمینہ آپ کی قدم قدم پر رہنمائی کرے گی۔",
//     ),
//   ];
//
//   @override
//   void initState() {
//     liquidController = LiquidController();
//     super.initState();
//   }
//
//   Widget _buildDot(int index) {
//     double selectedness = Curves.easeOut.transform(
//       max(
//         0.0,
//         1.0 - ((page) - index).abs(),
//       ),
//     );
//     double zoom = 1.0 + (2.0 - 1.0) * selectedness;
//     return SizedBox(
//       width: 25.0,
//       child: Center(
//         child: Material(
//           color: Colors.white,
//           type: MaterialType.circle,
//           child: SizedBox(
//             width: 8.0 * zoom,
//             height: 8.0 * zoom,
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Stack(
//           children: <Widget>[
//             LiquidSwipe.builder(
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   width: double.infinity,
//                   color: data[index].color,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.max,
//                     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       Container(
//                         width: double.infinity,
//                         child: SvgPicture.asset(
//                           data[index].image,
//                           height: 400,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//
//
//                       Padding(
//                         padding: const EdgeInsets.only(left: 18.0,right: 50.0,top: 50),
//                         child: Column(
//                           children: <Widget>[
//                             Text(
//                               data[index].text1,
//                               textDirection: TextDirection.rtl,
//                               textAlign:  TextAlign.right,
//                               style:
//                                   const TextStyle(fontFamily: "UrduType", fontSize: 25),
//                             ),
//                             Text(
//                               data[index].text2,
//                               textAlign:
//                                   TextAlign.right, // Align the text to the right
//                               style: const TextStyle(
//                                 fontFamily: "UrduType",
//                                 fontSize: 16,
//                                 color: Color(0xff685F78),
//                                 height: 1.2,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               positionSlideIcon: 0.8,
//               slideIconWidget: const Icon(Icons.arrow_back_ios),
//               onPageChangeCallback: pageChangeCallback,
//               waveType: WaveType.liquidReveal,
//               liquidController: liquidController,
//               fullTransitionValue: 880,
//               enableSideReveal: true,
//               preferDragFromRevealedArea: true,
//               enableLoop: true,
//               ignoreUserGestureWhileAnimating: true,
//             ),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: Padding(
//                 padding: const EdgeInsets.all(25.0),
//                 child: TextButton(
//                   onPressed: () {
//                     liquidController.animateToPage(
//                         page: data.length - 1, duration: 700);
//                   },
//                   child: const Text("Skip to End"),
//                   style: TextButton.styleFrom(
//                       backgroundColor: Colors.white.withOpacity(0.01),
//                       foregroundColor: Colors.black),
//                 ),
//               ),
//              TextButton(
//                   onPressed: () {
//                     liquidController.jumpToPage(
//                         page: liquidController.currentPage + 1 > data.length - 1
//                             ? 0
//                             : liquidController.currentPage + 1);
//                   },
//                   child: const Text("Next"),
//                   style: TextButton.styleFrom(
//                       backgroundColor: Colors.white.withOpacity(0.01),
//                       foregroundColor: Colors.black),
//                 ),
//               ),
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: <Widget>[
//                   const Expanded(child: SizedBox()),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List<Widget>.generate(data.length, _buildDot),
//                   ),
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: Padding(
//                 padding: const EdgeInsets.all(25.0),
//                 child: TextButton(
//                   onPressed: () {
//                     liquidController.animateToPage(
//                         page: data.length - 1, duration: 700);
//                   },
//                   child: const Text("Skip to End"),
//                   style: TextButton.styleFrom(
//                       backgroundColor: Colors.white.withOpacity(0.01),
//                       foregroundColor: Colors.black),
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: Padding(
//                 padding: const EdgeInsets.all(25.0),
//                 child: TextButton(
//                   onPressed: () {
//                     liquidController.jumpToPage(
//                         page: liquidController.currentPage + 1 > data.length - 1
//                             ? 0
//                             : liquidController.currentPage + 1);
//                   },
//                   child: const Text("Next"),
//                   style: TextButton.styleFrom(
//                       backgroundColor: Colors.white.withOpacity(0.01),
//                       foregroundColor: Colors.black),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   pageChangeCallback(int lpage) {
//     setState(() {
//       page = lpage;
//     });
//   }
// }
