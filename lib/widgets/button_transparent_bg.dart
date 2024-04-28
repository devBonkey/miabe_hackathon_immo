import 'package:flutter/material.dart';

class ButtonTransparent extends StatelessWidget {
  final String text;
  final VoidCallback redirect;
  const ButtonTransparent(
      {super.key, required this.text, required this.redirect});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: redirect,
      style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10))),
      child: Text(text),
    );
  }
}
