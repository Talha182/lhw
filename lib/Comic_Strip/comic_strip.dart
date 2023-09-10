  import 'package:carousel_slider/carousel_slider.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:percent_indicator/percent_indicator.dart';
  import 'package:step_progress_indicator/step_progress_indicator.dart';

  class ComicStrip extends StatefulWidget {
    const ComicStrip({super.key});

    @override
    _ComicStripState createState() => _ComicStripState();
  }

  class _ComicStripState extends State<ComicStrip> with SingleTickerProviderStateMixin {
    int _current = 0;
    double _progress = 0.0;
    late List<Widget> _carouselItems;
    late AnimationController _progressController;
    late Animation<double> _progressAnimation;


    @override
    void initState() {
      super.initState();


      _carouselItems = [
        _buildSlide('assets/images/Strip1.png', 'assets/images/Strip2.png'),
        _buildSlide('assets/images/Strip1.png', 'assets/images/Strip2.png'),
        _buildSlide('assets/images/Strip1.png', 'assets/images/Strip2.png'),
        _buildSlide('assets/images/Strip1.png', 'assets/images/Strip2.png'),
        _buildSlide('assets/images/Strip1.png', 'assets/images/Strip2.png'),
      ];
      _progressController = AnimationController(
          duration: Duration(milliseconds: 400), vsync: this)
        ..addListener(() {
          setState(() {
            _progress = _progressAnimation.value;
          });
        });
    }
    @override
    void dispose() {
      _progressController.dispose();
      super.dispose();
    }

    Widget _buildSlide(String imagePathA, String imagePathB) {
      return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 5.0), // Add horizontal padding here
        child: Column(
          children: [
            _buildContainer(imagePathA),
            SizedBox(height: 20),
            _buildContainer(imagePathB),
          ],
        ),
      );
    }

    Widget _buildContainer(String imagePath) {
      return Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(imagePath), // Using the provided image path
            fit: BoxFit.cover, // The image will cover the entire container
          ),
        ),
      );
    }



    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(
            0,
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: const Alignment(0, -0.2),
                colors: [
                  const Color(0xff80B8FB).withOpacity(0.5),
                  Colors.transparent,
                ],
              )),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Row(
                      children: [
                        const InkWell(
                          child: Icon(
                            Icons.close,
                            size: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: new LinearPercentIndicator(
                            animation: false,
                            animationDuration: 400,
                            lineHeight: 10.0,
                            percent: _progress,
                            progressColor: Color(0xffFE8BD1),
                            backgroundColor: Colors.white,
                            clipLinearGradient: true,
                            barRadius: Radius.circular(20),
                          ),
                        ),


                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/images/cloud.png',
                        width: 45,
                        height: 45,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'آپ ڈیلیوری کے بعد چوتھے دن ماں سے ملنے جاتے ہیں۔ وہ اچانک بھاری اندام نہانی خارج ہونے کی شکایت کرتی ہے۔',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "UrduType", fontSize: 22),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: CarouselSlider.builder(
                        itemCount: _carouselItems.length,
                        itemBuilder: (context, index, realIdx) {
                          return _carouselItems[index];
                        },
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 440,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });

                            double endValue = index / (_carouselItems.length - 1).toDouble();
                            _progressAnimation = Tween<double>(
                                begin: _progress,
                                end: endValue
                            ).animate(_progressController);

                            _progressController.forward(from: 0);  // Start the animation
                          },


                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _carouselItems.map((url) {
                      int index = _carouselItems.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin:
                            EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Color.fromRGBO(0, 0, 0, 0.9)
                              : Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      );
                    }).toList(),
                  ),
                  const Spacer(),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.black87.withOpacity(0.2),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 2),
                      backgroundColor: const Color(0xffFE8BD1),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(150, 37),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'جاری رہے',
                      style: TextStyle(
                        fontFamily: 'UrduType',
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2 -
                  (50 *
                      1.5), // Centering based on 3 buttons of approx height 50 each
              right: 10,
              child: Column(
                children: [
                  InkWell(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.black87.withOpacity(0.4),
                          shape: BoxShape.circle),
                      child: (Center(
                          child: Image.asset("assets/images/dislike.png"))),
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.black87.withOpacity(0.4),
                            shape: BoxShape.circle),
                        child:
                            Center(child: Image.asset("assets/images/like.png"))),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.black87.withOpacity(0.4),
                            shape: BoxShape.circle),
                        child: Center(
                            child: Image.asset("assets/images/fullscreen.png"))),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
