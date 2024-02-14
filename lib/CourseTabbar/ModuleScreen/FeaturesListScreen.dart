import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lhw/BranchingScenarios/ImageBranchingScenario.dart';
import 'package:lhw/BranchingScenarios/TextBranchingScenario.dart';
import 'package:lhw/ComicStrip/comic_strip.dart';
import 'package:lhw/Infographics/infographics.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../FlashCard/flash_cards_screen.dart';
import '../../ImageHotspot/ImageHotspot.dart';
import '../../InteractiveAnimationVideo/interactive_animation_video.dart';
import '../../Presentation/Presentation.dart';
import '../../Presentation/presentation_model.dart';
import '../../Test/Features/InteractiveImage.dart';
import '../../courses_test/test_model.dart';
import '../../models/flash_cards_screen_model.dart';
import '../../models/image_hotspot_model.dart';
import '../../models/interactive_images_model.dart';

class FeaturesListScreen extends StatefulWidget {
  final Submodule submodule;
  final String courseTitle; // Add this line
  final int courseQuizCount;
  final int courseModuleCount;
  final String imagePath;
  final Gradient gradient;

  const FeaturesListScreen({
    Key? key,
    required this.submodule,
    required this.courseTitle,
    required this.courseQuizCount,
    required this.courseModuleCount,
    required this.imagePath,
    required this.gradient, // Add this line
  }) : super(key: key);

  @override
  State<FeaturesListScreen> createState() => _FeaturesListScreenState();
}

class _FeaturesListScreenState extends State<FeaturesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.submodule.title,
          style: TextStyle(
            fontFamily: "UrduType",
          ),
        ), // Use the course title here
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  gradient: widget.gradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget
                                .courseTitle, // Example text, replace with dynamic data if necessary
                            style: const TextStyle(
                              fontFamily: 'UrduType',
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/module.svg',
                                color: Colors.white,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${widget.courseModuleCount} ماڈیولز', // Example text, replace with dynamic data if necessary
                                style: const TextStyle(
                                  fontFamily: 'UrduType',
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${widget.courseQuizCount} کوئز', // Example text, replace with dynamic data if necessary
                                style: const TextStyle(
                                  fontFamily: 'UrduType',
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Image.asset(
                        widget.imagePath,
                        color: Colors.white,
                        scale: 2.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'آپ کی پیشرفت', // Example text, replace with dynamic data if necessary
                      style: TextStyle(
                        fontFamily: 'UrduType',
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '40%', // Example text, replace with dynamic data if necessary
                      style: TextStyle(
                        fontFamily: 'UrduType',
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 0.9),
                  duration: const Duration(milliseconds: 400),
                  builder: (BuildContext context, double value, Widget? child) {
                    return LinearPercentIndicator(
                      lineHeight: 8.0,
                      percent: 0.1,
                      backgroundColor: Colors.grey.shade300,
                      progressColor: const Color(0xff9AC9C2),
                      barRadius: const Radius.circular(10),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                widget.submodule
                    .title, // Example text, replace with dynamic data if necessary
                style: const TextStyle(
                  fontFamily: 'UrduType',
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.submodule.features.length,
                  itemBuilder: (context, index) {
                    final feature = widget.submodule.features[index];
                    return ListTile(
                      leading: Icon(feature.icon,
                          color: feature.isCompleted
                              ? Colors.green
                              : feature.iconColor),
                      title: Text(
                        feature.title,
                        style: const TextStyle(
                          fontFamily: 'UrduType',
                          fontSize: 15,
                          color: Color(0xff685F78),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        feature.duration,
                        style: const TextStyle(
                          fontFamily: 'UrduType',
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () async {
                        if (feature.featureType == FeatureType.presentation) {
                          PresentationModel presentationModel =
                              feature.relatedData as PresentationModel;
                          // Using Get.to for navigation
                          await Get.to(() => Presentation(
                              presentationModel: presentationModel));
                        }
                        if (feature.featureType == FeatureType.comicStrips) {
                          List<ComicStripModel> comicStripModels =
                              feature.relatedData as List<ComicStripModel>;
                          // Adjust navigation based on your actual ComicStrip widget's constructor
                          await Get.to(() =>
                              ComicStrip(comicStripsModel: comicStripModels));
                        }

                        if (feature.featureType == FeatureType.flashCards) {
                          if (feature.relatedData is List<FlashCard>) {
                            // Ensure this matches your model structure
                            List<FlashCard> flashCards = feature.relatedData;
                            FlashCardScreenModel flashCardScreenModel =
                                FlashCardScreenModel(
                                    title: feature.title,
                                    cards:
                                        flashCards); // Assuming constructor matches this
                            await Get.to(() => FlashCardsScreen(
                                flashCardModel: flashCardScreenModel));
                          }
                        }
                        if (feature.featureType == FeatureType.infographics) {
                          InfographicsModel infographicsModel =
                              feature.relatedData as InfographicsModel;
                          // Assuming you have a route or method to display the infographics
                          await Get.to(() => InfographicScreen(
                              infographicsModel: infographicsModel));
                        }
                        if (feature.featureType ==
                            FeatureType.interactiveAnimationVideo) {
                          InteractiveAnimationVideoModel
                              interactiveAnimationVideoModel =
                              feature.relatedData
                                  as InteractiveAnimationVideoModel;
                          await Get.to(() => InteractiveAnimationVideo(
                              interactiveAnimationVideoModel:
                                  interactiveAnimationVideoModel));
                        }
                        if (feature.featureType ==
                            FeatureType.interactiveImage) {
                          List<InteractiveImageModel> interactiveImageModels =
                              feature.relatedData
                                  as List<InteractiveImageModel>;
                          // Assuming you have an InteractiveImages widget that takes a list of InteractiveImageModel
                          await Get.to(() => InteractiveImages(
                              feature:
                                  feature)); // Update this line to match how you initialize your InteractiveImages widget
                        }
                        if (feature.featureType == FeatureType.imageHotspot) {
                          ImageHotspotModel imageHotspotModel =
                              feature.relatedData as ImageHotspotModel;
                          await Get.to(() => ImageHotspot(
                              imageHotspotModel: imageHotspotModel));
                        }
                        if (feature.featureType ==
                            FeatureType.imageBranchingScenario) {
                          ImageBranchingScenarioModel
                              imageBranchingScenarioModel = feature.relatedData
                                  as ImageBranchingScenarioModel;
                          await Get.to(() => ImageBranchingScenario(
                                imageBranchingScenarioModel:
                                    imageBranchingScenarioModel,
                              ));
                        }
                        if (feature.featureType ==
                            FeatureType.textBranchingScenario) {
                          TextBranchingScenarioModel
                              textBranchingScenarioModel =
                              feature.relatedData as TextBranchingScenarioModel;
                          await Get.to(() => TextBranchingScenario(
                                textBranchingScenarioModel:
                                    textBranchingScenarioModel,
                              ));
                        }
                      },
                    );
                  },
                ).animate().fade(duration: 400.ms),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
