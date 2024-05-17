import 'package:flutter/material.dart';
class GlowingImage extends StatefulWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double left;
  final double top;

  GlowingImage({
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.left,
    required this.top,
  });

  @override
  _GlowingImageState createState() => _GlowingImageState();
}

class _GlowingImageState extends State<GlowingImage> {
  bool isGlowing = false;
  double scale = 1.0;
  double elevation = 0.0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: widget.left,
        top: widget.top,
        child: GestureDetector(
          onTapDown: (_) {
            setState(() {
              isGlowing = true;
              scale = 1.05; // Increase the scale slightly
              elevation = 8.0; // Add elevation for the pop effect
            });
          },
          onTapUp: (_) {
            setState(() {
              isGlowing = false;
              scale = 1.0; // Reset the scale
              elevation = 0.0; // Reset the elevation
            });
          },
          onTapCancel: () {
            setState(() {
              isGlowing = false;
              scale = 1.0; // Reset the scale
              elevation = 0.0; // Reset the elevation
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            transform: Matrix4.diagonal3Values(scale, scale, 1.0), // Apply the scale transformation
            child: Material(
              elevation: elevation, // Apply the elevation
              borderRadius: BorderRadius.circular(24),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    if (isGlowing)
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        blurRadius: 16,
                        spreadRadius: 4,
                      ),
                  ],
                ),
                child: Positioned(
                  left: 104.18,
                  top: 0,
                  child: Container(
                    width: widget.width,
                    height: widget.height,
                    child: Stack(
                      children: [
                        Positioned(
                          left: -0.95,
                          top: -27.04,
                          child: Container(
                            width: widget.width + 0.97,
                            height: widget.height + 63.27,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage(widget.imageUrl),
                                fit: BoxFit.cover,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  if (isGlowing)
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.5),
                                      blurRadius: 16,
                                      spreadRadius: 4,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}