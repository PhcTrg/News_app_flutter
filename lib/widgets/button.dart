import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final void Function()? onPressedFunc;
  final String btnText;

  const MainButton(
      {super.key, required this.onPressedFunc, required this.btnText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: onPressedFunc,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            btnText,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
