import 'package:flutter/material.dart';

class Property1Variant3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 295,
          height: 207,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 146,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 80,
                      child: SizedBox(
                        width: 295,
                        child: Text(
                          'You can read thousands of articles on Blog Club, save them in the application and share them with your loved ones.',
                          style: TextStyle(
                            color: Color(0xFF2D4379),
                            fontSize: 14,
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: SizedBox(
                        width: 275,
                        child: Text(
                          'Read the article you want instantly',
                          style: TextStyle(
                            color: Color(0xFF0D253C),
                            fontSize: 24,
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 71,
                height: 8,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: ShapeDecoration(
                          color: Color(0xFFDEE7FF),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 47,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: ShapeDecoration(
                          color: Color(0xFFDEE7FF),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 63,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: ShapeDecoration(
                          color: Color(0xFFDEE7FF),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 0,
                      child: Container(
                        width: 23,
                        height: 8,
                        decoration: ShapeDecoration(
                          color: Color(0xFF376AED),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}