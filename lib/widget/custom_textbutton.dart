import 'package:flutter/material.dart';

class CustomTextbutton extends StatelessWidget {
  const CustomTextbutton({super.key, required this.text , required this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.transparent),
            ),
          ),
          child: Container(
            height: 45,
            width: 100,
            child: Center(child: Text( text, style: const TextStyle(color: Colors.white),)),
          ),
        ),
      ),
    );
  }
}
