import 'package:flutter/material.dart';

class ButtonWhite extends StatelessWidget {
  final String text;
  final VoidCallback redirect;
  const ButtonWhite({super.key, required this.text, required this.redirect});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: redirect,
      style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Text(text),
    );
  }
}
