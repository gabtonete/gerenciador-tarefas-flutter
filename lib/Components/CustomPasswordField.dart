import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas_flutter/Constants/Colors.dart';

class CustomPasswordField extends StatefulWidget {
  final String hintText;
  final controller;

  const CustomPasswordField({
    Key? key,
    required this.hintText,
    this.controller
  }) : super(key: key);

  @override
  _CustomPasswordFieldState createState() => new _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      controller: widget.controller,
      textAlignVertical: TextAlignVertical.bottom,
      style: TextStyle(color: primaryColor, fontSize: 14),
      decoration: InputDecoration(
          icon: Padding(
              padding: const EdgeInsets.only(bottom: 0, left: 0, right: 0, top: 15),
              child: ImageIcon(AssetImage("assets/icons/cadeado_icon.png"), color: primaryColor)
          ),
          hintText: widget.hintText,
          suffixIcon: IconButton(
            icon: Padding(
                padding: const EdgeInsets.only(bottom: 0, left: 0, right: 0, top: 15),
                child: ImageIcon(AssetImage("assets/icons/olho_icon.png"), color: mediumGrayColor)
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
      ),
    );
  }
}