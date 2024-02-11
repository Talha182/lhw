//
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// class FeatureNavigationController extends GetxController {
//   var currentFeatureIndex = 0.obs;
//   List<void Function()> navigateToFeatureCallbacks;
//   final VoidCallback navigateBackToJourneyMap;
//
//   FeatureNavigationController({
//     required this.navigateToFeatureCallbacks,
//     required this.navigateBackToJourneyMap,
//   });
//
//   void navigateToNextFeatureOrBack() {
//     if (currentFeatureIndex.value < navigateToFeatureCallbacks.length) {
//       navigateToFeatureCallbacks[currentFeatureIndex.value]();
//     } else {
//       navigateBackToJourneyMap();
//     }
//     currentFeatureIndex.value++;
//   }
//
//   // Reset the controller with new callbacks
//   void resetControllerWithNewCallbacks(List<void Function()> newCallbacks) {
//     navigateToFeatureCallbacks = newCallbacks;
//     currentFeatureIndex.value = 0; // Reset the index
//   }
// }
//
