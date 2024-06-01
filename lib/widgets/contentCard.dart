// this page is used to manage theme and color and custom widget
// Responsibilities: Nguyen Phuoc Truong
import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  final Widget widget;

  ContentCard({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        //shaddow
        elevation: 5,
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
        shadowColor: Colors.black,

        // radious
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: widget,
        ),
      ),
    );
  }
}
