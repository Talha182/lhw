import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lhw/BranchingScenarios/ImageBranchingScenario.dart';
import 'package:lhw/BranchingScenarios/TextBranchingScenario.dart';
import 'package:lhw/ComicStrip/comic_strip.dart';
import 'package:lhw/ImageHotspot/horizontal_image_hotspot.dart';
import 'package:lhw/Infographics/infographics.dart';
import 'package:lhw/Test/Features/InteractiveImage.dart';
import 'package:lhw/models/interactive_images_model.dart';
import 'package:lhw/services/global_user.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../Database/database_helper.dart';
import '../FlashCard/flash_cards_screen.dart';
import '../ImageHotspot/ImageHotspot.dart';
import '../InteractiveAnimationVideo/interactive_animation_video.dart';
import '../Presentation/Presentation.dart';
import '../Presentation/presentation_model.dart';
import '../course_models/courses_models.dart';
import '../models/flash_cards_screen_model.dart';
import '../models/image_hotspot_model.dart';
import '../models/user_model.dart';
import 'course_provider.dart';

class FeaturesListScreen extends StatefulWidget {
  final Submodule submodule;
  final String courseTitle; // Add this line
  final int moduleId;
  final int courseQuizCount;
  final int courseModuleCount;
  final String imagePath;
  final Gradient gradient;
  final int courseId;

  const FeaturesListScreen({
    Key? key,
    required this.submodule,
    required this.courseTitle,
    required this.courseQuizCount,
    required this.courseModuleCount,
    required this.imagePath,
    required this.moduleId,
    required this.gradient, // Add this line
    required this.courseId,
  }) : super(key: key);

  @override
  State<FeaturesListScreen> createState() => _FeaturesListScreenState();
}

class _FeaturesListScreenState extends State<FeaturesListScreen> {
  @override
  void initState() {
    super.initState();
    _loadFeatures();
  }

  List<Feature> _features = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadFeatures();
  }

  Future<void> _loadFeatures() async {
    List<Feature> featuresLoaded = await DatabaseHelper.instance
        .fetchFeatures(widget.submodule.submoduleId);
    setState(() {
      _features = featuresLoaded;
    });
  }

  void toggleFeatureCompletion(Feature feature) async {
    bool success = await DatabaseHelper.instance
        .toggleFeatureCompletion(feature.featureId);
    if (success) {
      User? currentUser = GlobalUser.getCurrentUser;
      int courseId = widget.courseId;
      int moduleId = widget.moduleId;
      String startTime = DateTime.now().toIso8601String();

      await DatabaseHelper.instance.updateUserProgress(
          currentUser!.id, courseId, moduleId, feature.featureId, startTime);
      print(
          'Feature completion toggled successfully for featureId: ${feature.featureId}');

      setState(() {
        feature.isCompleted.value = !feature.isCompleted.value;
      });
    } else {
      print(
          'Failed to toggle feature completion for featureId: ${feature.featureId}');
    }
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = GlobalUser.getCurrentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          Row(
            children: [
              Text(
                widget.submodule.title,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: "UrduType"),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward, color: Colors.black),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          )
        ],
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
                          Row(
                            children: [
                              Text(
                                "یونٹ:", // Example text, replace with dynamic data if necessary
                                style: const TextStyle(
                                  fontFamily: 'UrduType',
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                '${widget.courseQuizCount} ٹیسٹ', // Example text, replace with dynamic data if necessary
                                style: const TextStyle(
                                  fontFamily: 'UrduType',
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 6),
                              SvgPicture.asset(
                                'assets/images/person_card.svg',
                                color: Colors.white,
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
                                '${widget.courseModuleCount} سبق', // Example text, replace with dynamic data if necessary
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
                  itemCount: _features
                      .length, // Use _features list to determine item count
                  itemBuilder: (context, index) {
                    final feature = _features[
                        index]; // Access feature by index from _features list
                    return ValueListenableBuilder<bool>(
                        valueListenable: feature.isCompleted,
                        builder: (context, isCompleted, _) {
                          return ListTile(
                            leading: Icon(
                              feature
                                  .icon, // Conditional icon based on isCompleted
                              color: isCompleted ? Colors.green : Colors.grey,
                            ),
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
                              User? currentUser = GlobalUser.getCurrentUser;
                              String startTime =
                                  DateTime.now().toIso8601String();
                              await DatabaseHelper.instance.updateUserProgress(
                                currentUser!.id,
                                widget.courseId,
                                widget.moduleId,
                                feature.featureId,
                                startTime,
                              );

                              switch (feature.featureType) {
                                case FeatureType.presentation:
                                  final presentationModel =
                                      PresentationModel.fromJson({
                                    ...feature.data as Map<String, dynamic>,
                                    'featureId': feature.featureId,
                                  });
                                  final result = await Get.to(() =>
                                      PresentationScreen(
                                          presentationModel:
                                              presentationModel));

                                  if (result == true) {
                                    toggleFeatureCompletion(feature);

                                    Provider.of<CoursesProvider>(context,
                                            listen: false)
                                        .markFeatureAsCompletedAndUpdateProgress(
                                            widget.courseId,
                                            widget.moduleId,
                                            feature.featureId);
                                  }
                                  break;
                                case FeatureType.comicStrip:
                                  List<dynamic> comicStripData = feature
                                      .data['imagePairs'] as List<dynamic>;
                                  List<ComicStripModel> comicStripsModel =
                                      comicStripData
                                          .map((item) => ComicStripModel(
                                                  title: feature.data['title'],
                                                  imagePairs: [
                                                    ImagePair.fromJson(item)
                                                  ]))
                                          .toList();

                                  final result = await Get.to(() => ComicStrip(
                                        comicStripsModel: comicStripsModel,
                                        featureId: feature.featureId,
                                      ));
                                  if (result == true) {
                                    toggleFeatureCompletion(feature);
                                    await DatabaseHelper.instance
                                        .markFeatureAsCompleted(
                                            feature.featureId);
                                    // await DatabaseHelper.instance.calculateAndUpdateModuleProgress(widget.moduleId);
                                    Provider.of<CoursesProvider>(context,
                                            listen: false)
                                        .markFeatureAsCompletedAndUpdateProgress(
                                            widget.courseId,
                                            widget.moduleId,
                                            feature.featureId);
                                  }
                                  break;
                                case FeatureType.flashCard:
                                  final flashCardModel =
                                      FlashCardScreenModel.fromJson(
                                          feature.data as Map<String, dynamic>);

                                  final result = await Get.to(() =>
                                      FlashCardsScreen(
                                          flashCardModel: flashCardModel));
                                  if (result == true) {
                                    toggleFeatureCompletion(feature);
                                    await DatabaseHelper.instance
                                        .markFeatureAsCompleted(
                                            feature.featureId);
                                    // await DatabaseHelper.instance.calculateAndUpdateModuleProgress(widget.moduleId);
                                    Provider.of<CoursesProvider>(context,
                                            listen: false)
                                        .markFeatureAsCompletedAndUpdateProgress(
                                            widget.courseId,
                                            widget.moduleId,
                                            feature.featureId);
                                  }
                                  break;
                                case FeatureType.interactiveImage:
                                  final interactiveImageModel =
                                      (feature.data['interactiveImageModel']
                                              as List)
                                          .map((e) =>
                                              InteractiveImageModel.fromJson(e))
                                          .toList();

                                  final result =
                                      await Get.to(() => InteractiveImages(
                                            imagesInfo: interactiveImageModel,
                                          ));

                                  if (result == true) {
                                    toggleFeatureCompletion(feature);
                                    await DatabaseHelper.instance
                                        .markFeatureAsCompleted(
                                            feature.featureId);
                                    Provider.of<CoursesProvider>(context,
                                            listen: false)
                                        .markFeatureAsCompletedAndUpdateProgress(
                                            widget.courseId,
                                            widget.moduleId,
                                            feature.featureId);
                                  }
                                  break;

                                case FeatureType.infographics:
                                  final infographicsModel =
                                      InfographicsModel.fromJson(
                                          feature.data as Map<String, dynamic>);
                                  final result = await Get.to(() =>
                                      InfographicScreen(
                                          infographicsModel:
                                              infographicsModel));
                                  if (result == true) {
                                    toggleFeatureCompletion(feature);
                                    await DatabaseHelper.instance
                                        .markFeatureAsCompleted(
                                            feature.featureId);
                                    // await DatabaseHelper.instance.calculateAndUpdateModuleProgress(widget.moduleId);
                                    Provider.of<CoursesProvider>(context,
                                            listen: false)
                                        .markFeatureAsCompletedAndUpdateProgress(
                                            widget.courseId,
                                            widget.moduleId,
                                            feature.featureId);
                                  }
                                  break;
                                case FeatureType.interactiveAnimationVideo:
                                  final interactiveAnimationVideoModel =
                                      InteractiveAnimationVideoModel.fromJson(
                                          feature.data as Map<String, dynamic>);
                                  final result = await Get.to(
                                      () => InteractiveAnimationVideo(
                                            interactiveAnimationVideoModel:
                                                interactiveAnimationVideoModel,
                                          ));
                                  if (result == true) {
                                    toggleFeatureCompletion(feature);

                                    Provider.of<CoursesProvider>(context,
                                            listen: false)
                                        .markFeatureAsCompletedAndUpdateProgress(
                                            widget.courseId,
                                            widget.moduleId,
                                            feature.featureId);
                                  }
                                  break;
                                case FeatureType.imageHotspot:
                                  final imageHotspotModel =
                                      ImageHotspotModel.fromJson(
                                          feature.data as Map<String, dynamic>);
                                  await Get.to(() => ImageHotspot(
                                        imageHotspotModel: imageHotspotModel,
                                      ));
                                  break;
                                case FeatureType.horizontalImageHotspot:
                                  final horizontalImageHotspotModel =
                                      HorizontalImageHotspotModel.fromJson(
                                          feature.data as Map<String, dynamic>);
                                  final result = await Get.to(() => HorizontalImageHotspot(
                                        horizontalImageHotspotModel:
                                            horizontalImageHotspotModel,
                                      ));
                                  if (result == true) {
                                    toggleFeatureCompletion(feature);

                                    Provider.of<CoursesProvider>(context,
                                        listen: false)
                                        .markFeatureAsCompletedAndUpdateProgress(
                                        widget.courseId,
                                        widget.moduleId,
                                        feature.featureId);
                                  }
                                  break;
                                case FeatureType.imageBranchingScenario:
                                  final imageBranchingScenarioModel =
                                      ImageBranchingScenarioModel.fromJson(
                                          feature.data as Map<String, dynamic>);
                                  await Get.to(() => ImageBranchingScenario(
                                        imageBranchingScenarioModel:
                                            imageBranchingScenarioModel,
                                      ));
                                  break;
                                case FeatureType.textBranchingScenario:
                                  final imageBranchingScenarioModel =
                                      TextBranchingScenarioModel.fromJson(
                                          feature.data as Map<String, dynamic>);
                                  await Get.to(() => TextBranchingScenario(
                                        textBranchingScenarioModel:
                                            imageBranchingScenarioModel,
                                      ));
                                  break;
                                case FeatureType.video:
                                // TODO: Handle this case.
                                case FeatureType.quiz:
                                // TODO: Handle this case.
                                case FeatureType.interactiveImage:
                                // TODO: Handle this case.
                                case FeatureType.animationVideo:
                                // TODO: Handle this case.
                                case FeatureType.unknown:
                                // TODO: Handle this case.
                              }
                            },
                          );
                        });
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
