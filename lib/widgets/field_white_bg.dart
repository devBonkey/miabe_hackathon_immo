import 'package:flutter/material.dart';

class FieldWhiteBg extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  const FieldWhiteBg(
      {super.key,
      required this.hintText,
      required this.keyboardType,
      required this.controller});

  @override
  State<FieldWhiteBg> createState() => _FieldWhiteBgState();
}

class _FieldWhiteBgState extends State<FieldWhiteBg> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez renseigner ce champ';
        }
        return null;
      },
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white54,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white))),
    );
  }
}
