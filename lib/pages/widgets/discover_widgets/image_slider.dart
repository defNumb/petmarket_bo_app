import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../constants/app_constants.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  // index
  int activeIndex = 0;
  // Replace the colors with actual images
  final urlImages = [
    "assets/images/act1.jpg",
    "assets/images/act2.jpg",
    "assets/images/act3.jpg",
    "assets/images/act4.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
              aspectRatio: 16 / 9,
              autoPlay: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) => setState(
                    (() => activeIndex = index),
                  )),
          itemCount: urlImages.length,
          itemBuilder: (context, index, realIndex) {
            final urlImage = urlImages[index];
            return buildImage(urlImage, index);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        buildIndicator(),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
      width: double.infinity,
      color: primaryColor,
      child: Image.asset(
        urlImage,
        fit: BoxFit.contain,
      ));

  Widget buildIndicator() => AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: urlImages.length,
      effect: const SlideEffect(dotHeight: 10, dotWidth: 10));
}
