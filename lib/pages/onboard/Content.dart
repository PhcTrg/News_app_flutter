import 'package:flutter/material.dart';

import 'SliderVariants/Variant1.dart';
import 'SliderVariants/Variant2.dart';
import 'SliderVariants/Variant3.dart';
import 'SliderVariants/Variant4.dart';

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int _currentIndex = 0;

  final List<Widget> _variants = [
    Property1Default(),
    Property1Variant2(),
    Property1Variant3(),
    Property1Variant4(),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _isDragging = false;
    return Column(
      children: [
        Container(
          width: 1608,
          height: 234,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide.none, // Set side to BorderSide.none
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 20,
                top: 20,
                child: GestureDetector(
                  onHorizontalDragStart: (details) {
                    _isDragging = true; // Set the flag when a drag gesture starts
                  },
                  onHorizontalDragUpdate: (details) {
                    if (_isDragging) {
                      // Check if a drag gesture is in progress
                      if (details.delta.dx > 0) {
                        // Swiped to the right
                        if (_currentIndex >= 3) _currentIndex = -1;
                        if (_currentIndex < _variants.length - 1) {
                          _currentIndex++;
                          _animationController.forward(from: 0.0);
                          print('New index: $_currentIndex');
                          _isDragging = false; // Reset the flag after changing the index
                        }
                      } else if (details.delta.dx < 0) {
                        // Swiped to the left
                        if (_currentIndex <= 0) _currentIndex = 4;
                        if (_currentIndex > 0) {
                          _currentIndex--;
                          _animationController.forward(from: 0.0);
                          print('New index: $_currentIndex');
                          _isDragging = false; // Reset the flag after changing the index
                        }
                      }
                    }
                  },
                  onHorizontalDragEnd: (details) {
                    _isDragging = false; // Reset the flag when the drag gesture ends
                  },
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, _) {
                      return _variants[_currentIndex];
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
