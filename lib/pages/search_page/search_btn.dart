import 'package:flutter/material.dart';

class BtnEff extends StatefulWidget {
  @override
  _BtnEffState createState() => _BtnEffState();
}

class _BtnEffState extends State<BtnEff> {
  bool isButtonClicked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 148,
          height: 156,
          child: Stack(
            children: [
              Positioned(
                left: 20,
                top: 20,
                child: GestureDetector(
                  onTapDown: (_) {
                    setState(() {
                      isButtonClicked = true;
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      isButtonClicked = false;
                    });
                  },
                  child: AnimatedContainer(
                    width: 108,
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    decoration: ShapeDecoration(
                      color: isButtonClicked ? Color(0xFF10246C) : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Search',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
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