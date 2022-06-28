import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas_flutter/Constants/Colors.dart';

class CustomTextField extends StatelessWidget {
  final String textHint;
  final AssetImage assetImage;
  final controller;

  const CustomTextField({
    Key? key,
    required this.textHint,
    required this.assetImage,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlignVertical: TextAlignVertical.bottom,
      style: TextStyle(color: primaryColor, fontSize: 14),
      decoration: InputDecoration(
          icon: Padding(
              padding: const EdgeInsets.only(bottom: 0, left: 0, right: 0, top: 15),
              child: ImageIcon(assetImage, color: primaryColor)
          ),
          hintText: textHint
      ),
    );
  }
}