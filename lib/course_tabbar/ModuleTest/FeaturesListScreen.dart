import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../models/submodule_model.dart';

class FeaturesListScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseTitle), // Use the course title here
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
                  gradient: gradient,
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
                            courseTitle, // Example text, replace with dynamic data if necessary
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
                                '${courseModuleCount} ماڈیولز', // Example text, replace with dynamic data if necessary
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
                                '${courseQuizCount} کوئز', // Example text, replace with dynamic data if necessary
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
                        imagePath,
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
                submodule
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
                  itemCount: submodule.featureCallbacks.length,
                  itemBuilder: (context, index) {
                    final feature = submodule.featureCallbacks[index];
                    return ListTile(
                      leading: Icon(feature.icon,
                          color: feature
                              .iconColor), // Uses icon and color based on completion
                      title: Text(
                        feature.title,
                        style: const TextStyle(
                          fontFamily: 'UrduType',
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: feature.callback,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
