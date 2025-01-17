import 'dart:io';
import 'dart:io';

import 'package:flutter/material.dart';

class FileImageCarousel extends StatefulWidget {
  final List<String> imagePaths;// List of image URLs

  const FileImageCarousel({super.key, required this.imagePaths});

  @override
  _FileImageCarouselState createState() => _FileImageCarouselState();
}

class _FileImageCarouselState extends State<FileImageCarousel> {
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
            itemCount: widget.imagePaths.length,
            itemBuilder: (context, index) {
              return Image.file(
                File(widget.imagePaths[index]),
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
      children: List.generate(widget.imagePaths.length, (index) {
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
