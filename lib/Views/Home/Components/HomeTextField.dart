import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas_flutter/Constants/Colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class HomeTextField extends StatelessWidget {
  final String textHint;
  final controllerTextField;
  final MaskTextInputFormatter? maskFormatter;

  const HomeTextField({
    Key? key,
    required this.textHint,
    this.controllerTextField,
    this.maskFormatter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: new BoxConstraints(
        maxWidth: 287,
        maxHeight: 48
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 0, left: 16.5, right: 0, top: 0),
          child: TextField(
            inputFormatters: maskFormatter != null ? [maskFormatter!] : [],
            controller: controllerTextField,
            style: TextStyle(color: primaryColor, fontSize: 14),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: textHint
            ),
          ),
        ),
      ),
    );
  }
}