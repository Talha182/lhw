import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int currentPage = 0;
  final List<String> assetImages = [
    'assets/icons/1.png',
    'assets/icons/2.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 400,
          height: 170,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black87.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.5),
            image: DecorationImage(
              image: AssetImage(assetImages[currentPage]),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 60,
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white
            ),
            child: InkWell(
              onTap: (){
                setState(() {
                  currentPage= (currentPage+1) % assetImages.length;
                });
              },
              child: Center(
                child: Icon(Icons.arrow_back_ios_new,size: 20,),
              ),
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 60,
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white
            ),
            child: InkWell(
              onTap: (){
                setState(() {
                  currentPage= (currentPage+1) % assetImages.length;
                });
              },
              child: Center(
                child: Icon(Icons.arrow_forward_ios,size: 20,),
              ),
            ),
          ),

        ),
      ],
    );
  }
}
