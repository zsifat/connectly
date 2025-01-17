import 'dart:io';

import 'package:flutter/material.dart';

class NetworkImageCarousel extends StatefulWidget {
  final List<String> imageUrls;// List of image URLs

  const NetworkImageCarousel({super.key, required this.imageUrls});

  @override
  _NetworkImageCarouselState createState() => _NetworkImageCarouselState();
}

class _NetworkImageCarouselState extends State<NetworkImageCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index) {
              return Image.network(
                widget.imageUrls[index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        _buildIndicator(),
      ],
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.imageUrls.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1, color: const Color(0xFF6B4EFF)),
            color: _currentPage == index ? const Color(0xFF6B4EFF) : Colors.white,
          ),
        );
      }),
    );
  }
}
