import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyCarousel extends StatefulWidget {
  List<dynamic> images;
  CarouselController? carouselController;
  double? aspectRatio;
  dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
  MyCarousel(
      {super.key,
      required this.images,
      required index,
      required carouselController,
      this.aspectRatio,
      this.onPageChanged});

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: CarouselSlider(
        carouselController:widget. carouselController,
        items: widget.images
            .map((e) => ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    e.toString(),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ))
            .toList(),
        options: CarouselOptions(
          padEnds: true,
          viewportFraction: 1,
          aspectRatio: widget.aspectRatio ?? 16 / 6,
          enableInfiniteScroll: true,
          autoPlay: true,
          animateToClosest: true,
          autoPlayInterval: const Duration(seconds: 2),

          // autoPlayAnimationDuration: const Duration(milliseconds: 50),
          autoPlayCurve: Curves.linear,
          enlargeCenterPage: true,
          onPageChanged: widget.onPageChanged,
        ),
      ),
    );
  }
}
