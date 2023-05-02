import 'package:flutter/material.dart';

class PrimaryBtn extends StatelessWidget {
  PrimaryBtn({super.key, required this.btnText, this.onPress, this.bgColor});

  String? btnText;
  Color? bgColor;
  VoidCallback? onPress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Text(
        btnText!,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
