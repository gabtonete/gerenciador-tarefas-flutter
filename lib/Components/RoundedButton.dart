import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas_flutter/Constants/Colors.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width = 272,
    this.height = 56
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(text),
      onPressed: onPressed,
      style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: primaryColor,
          minimumSize: Size(width, height),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))
          )
      ),
    );
  }
}