import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lhw/models/question_model.dart';
import '../controllers/QuizController.dart';

class ResultsScreen extends StatelessWidget {
  void _showOptionsDialog(BuildContext context, Question question) {
    showAnimatedDialog(
      curve: Curves.fastOutSlowIn,
      animationType: DialogTransitionType.sizeFade,
      duration: const Duration(seconds: 1),
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(question.question,style: TextStyle(
            fontFamily: "UrduType"
          ),textAlign: TextAlign.center,),
          content: SingleChildScrollView(
            child: ListBody(
              children: question.options.map((option) {
                // Highlight incorrect answers in red and the correct one in green
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: option == question.correctAnswer
                        ? Colors.green[100]
                        : Colors.red[100], // Mark incorrect options in red
                    borderRadius: BorderRadius.circular(15)
                  ),

                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      option,
                      style: const TextStyle(fontSize: 16,fontFamily: "UrduType"),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ResultsController controller = Get.find<ResultsController>();

    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: const Alignment(0, -0.2),
            colors: [
              const Color(0xff80B8FB).withOpacity(0.3),
              Colors.transparent,
            ],
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 80),
              child: Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  'assets/images/cloud.svg',
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "اپنے سکور گارڈ کو چیک کریں۔",
                      style: TextStyle(
                        fontFamily: "UrduType",
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "حل کو ظاہر کرنے کے لیے نیچے ٹائلز پر کلک کریں۔",
                      style: TextStyle(
                        fontFamily: "UrduType",
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Obx(() => Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 130),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two items per row
                      crossAxisSpacing: 10.0, // Adjust spacing as needed
                      mainAxisSpacing: 15.0, // Adjust spacing as needed
                      childAspectRatio: 3 / 3, // Adjust aspect ratio as needed
                    ),
                    itemCount: controller.questionsAndAnswers.length,
                    itemBuilder: (context, index) {
                      final question = controller.questionsAndAnswers[index];
                      return GestureDetector(
                        onTap: () => _showOptionsDialog(context, question),
                        child: Container(
                          decoration: BoxDecoration(
                              color:
                                  question.correctAnswer == question.userAnswer
                                      ? Colors.green[400]
                                      : Colors.red[400],
                              borderRadius: BorderRadius.circular(10)),
                          // Background color for correctness
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: question.correctAnswer ==
                                        question.userAnswer
                                    ? Colors.green[100]
                                    : Colors.red[100],
                                borderRadius: BorderRadius.circular(
                                    8), // Optional: for rounded corners
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    question.question,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                      height:
                                          8), // Provide spacing between text
                                  Text(
                                    'Your answer: ${question.userAnswer}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors
                                          .white, // White text for better visibility
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(
                // Container for easier styling and padding
                padding: const EdgeInsets.all(10), // Add padding if needed
                child: Column(
                  children: [
                    Divider(thickness: 1, color: Colors.grey[300]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceAround, // Adjust based on your layout needs
                      children: [
                        GestureDetector(
                          child: Container(
                              width: 150,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: const Color(0xffFE8BD1), width: 2)),
                              child: const Center(
                                child: Text(
                                  "اسکورز کا جائزہ لیں۔",
                                  style: TextStyle(
                                      color: Color(0xffFE8BD1),
                                      fontFamily: "UrduType",fontSize: 16),
                                ),
                              )),
                        ),
                        GestureDetector(
                          child: Container(
                            width: 150,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xffFE8BD1)),
                            child: const Center(
                              child: Text(
                                'جاری رہے',
                                style: TextStyle(color: Colors.white,                                    fontFamily: "UrduType",fontSize: 16),
                          
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
