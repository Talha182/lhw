import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lhw/Discussion_Group/MessageScreen.dart';

class GroupsDiscussion extends StatelessWidget {
  final bool showAppBar; // Add this line

  const GroupsDiscussion({super.key, required this.showAppBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar // Check the condition here
          ? PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 1,
            backgroundColor: Colors.white,
            flexibleSpace: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                          child: SvgPicture.asset(
                            'assets/images/bell.svg',
                            color: Colors.black,
                          ),
                          onTap: () {},
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          child: SvgPicture.asset(
                            'assets/images/magnifier.svg',
                            color: Colors.black,
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Text(
                      "ڈسکشن گروپس",
                      style: TextStyle(
                        fontFamily: 'UrduType',
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )):null,
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: [
              const Text(
                "تبادلہ خیال: بڑھیں اور ایک ساتھ سیکھیں۔",
                style: TextStyle(
                  fontFamily: 'UrduType',
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                "LHW کمیونٹی آپس میں جڑنے، بات چیت شروع کرنے، سوالات پوچھنے، ایک دوسرے کی مدد کرنے اور ایک ساتھ سیکھنے کی جگہ ہے۔ یہ جگہ آپ کے لیے ہے، اور ہمیں بہت خوشی ہے کہ آپ یہاں ہیں۔ شروع کرنے کے لیے تیار ہیں؟ ڈومین گفتگو چلا کر اپنے ساتھیوں کے ساتھ مشغول رہیں۔ ہر کورس کے لیے ایک گروپ وقف ہوتا ہے۔ کورس میں داخلہ لینے پر آپ خود بخود چیٹ میں شامل ہو جائیں گے۔",
                style: TextStyle(
                  fontFamily: 'UrduType',
                  fontSize: 14,
                  color: Color(0xff7A7D84),
                  fontWeight: FontWeight.w600,
                ),
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.right,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withOpacity(0.1))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 55,
                            height: 55,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(colors: [
                                  Color(0xffED8DCE),
                                  Color(0xffED8DCE)
                                ])),
                            child: ClipOval(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SvgPicture.asset(
                                  "assets/images/samina_group.svg",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "جنرل چیٹ",
                            style:
                                TextStyle(fontFamily: "UrduType", fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "بحث شروع کریں۔",
                            style: TextStyle(
                                fontFamily: "UrduType",
                                fontSize: 18,
                                color: Color(0xffFE8BD1)),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          SvgPicture.asset(
                            "assets/images/Icon.svg",
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(
                            width: 5,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "کورس گروپس",
                style: TextStyle(
                  fontFamily: "UrduType",
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const MessageScreen(),
                      transition: Transition.fadeIn,
                      duration: const Duration(milliseconds: 300));
                },
                child: Container(
                  width: Get.width,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black.withOpacity(0.1))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(colors: [
                                    Color(0xffED8DCE),
                                    Color(0xffED8DCE)
                                  ])),
                              child: ClipOval(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Image.asset(
                                    "assets/images/1.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "باب 1 تعارف",
                              style: TextStyle(
                                  fontFamily: "UrduType", fontSize: 18),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                                width: 35,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: const Color(0xff72C391),
                                    borderRadius: BorderRadius.circular(13)),
                                child: const Center(
                                  child: Text(
                                    "21",
                                    style: TextStyle(
                                        fontFamily: "UrduType",
                                        color: Colors.white),
                                  ),
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/Icon.svg",
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(
                              width: 5,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DiscussionGroupsChatCard(
                gradient: const LinearGradient(
                    colors: [Color(0xffF48C14), Color(0xffFABC74)]),
                image: Image.asset(
                  "assets/images/2.png",
                  fit: BoxFit.fill,
                ),
                titleText: "باب 2: کمیونٹی کے ساتھ کام کرنا",
                endImage: "assets/images/Icon.svg",
              ),
              const SizedBox(
                height: 20,
              ),
              DiscussionGroupsChatCard(
                gradient: const LinearGradient(
                    colors: [Color(0xff937FFB), Color(0xffA896FC)]),
                image: Image.asset(
                  "assets/images/community.png",
                  fit: BoxFit.fill,
                ),
                titleText: "باب 3: باہمی رابطے اور صحت کی تعلیم",
                endImage: "assets/images/Icon.svg",
              ),
              const SizedBox(
                height: 20,
              ),
              DiscussionGroupsChatCard(
                gradient: const LinearGradient(
                    colors: [Color(0xff34B2D5), Color(0xff5DCBE9)]),
                image: Image.asset(
                  "assets/images/3.png",
                  fit: BoxFit.fill,
                ),
                titleText: "باب 4: خاندانی منصوبہ بندی",
                endImage: "assets/images/Icon.svg",
              ),
              const SizedBox(
                height: 20,
              ),
              DiscussionGroupsChatCard(
                gradient: const LinearGradient(
                    colors: [Color(0xffF66592), Color(0xffFB80A9)]),
                image: Image.asset(
                  "assets/images/4.png",
                  fit: BoxFit.fill,
                ),
                titleText: "باب 5: قبل از پیدائش کی دیکھ بھال",
                endImage: "assets/images/locked_group.svg",
              ),
              const SizedBox(
                height: 20,
              ),
              DiscussionGroupsChatCard(
                gradient: const LinearGradient(
                    colors: [Color(0xff6DB374), Color(0xffAFD6B3)]),
                image: Image.asset(
                  "assets/images/5.png",
                  fit: BoxFit.fill,
                ),
                titleText: "باب 6: حمل کے دوران دیکھ بھال ",
                endImage: "assets/images/locked_group.svg",
              ),
              const SizedBox(
                height: 20,
              ),
              DiscussionGroupsChatCard(
                gradient: const LinearGradient(
                    colors: [Color(0xffEDBB71), Color(0xffF4D5A8)]),
                image: Image.asset(
                  "assets/images/two_women.png",
                  fit: BoxFit.fill,
                ),
                titleText: "باب 7: نوزائیدہ بچوں کی دیکھ بھال ",
                endImage: "assets/images/locked_group.svg",
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DiscussionGroupsChatCard extends StatelessWidget {
  final LinearGradient gradient;
  final Image image;
  final String titleText;
  final String endImage;

  const DiscussionGroupsChatCard({
    Key? key,
    required this.gradient,
    required this.image,
    required this.titleText,
    required this.endImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black.withOpacity(0.1))),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, gradient: gradient),
                  child: ClipOval(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: image,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  titleText,
                  style: const TextStyle(fontFamily: "UrduType", fontSize: 18),
                ),
              ],
            ),
            Row(
              children: [
                SvgPicture.asset(
                  endImage,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(
                  width: 5,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
