import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas_flutter/Constants/Colors.dart';

class CustomBox extends StatelessWidget {
  final bool spaceBetween;
  final Widget firstWidget;
  final Widget secondWidget;
  final VoidCallback onTap;

  const CustomBox({
    Key? key,
    required this.size,
    required this.spaceBetween,
    required this.firstWidget,
    required this.secondWidget,
    required this.onTap
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: new BoxConstraints(
          minHeight: 48,
          minWidth: size.width-16,
          maxWidth: size.width-16,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 0, right: 0, top: 12),
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: lightGrayColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(12))
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0, left: 16, right: 16, top: 0),
              child: Row(
                  mainAxisAlignment: spaceBetween ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                  children: [
                    firstWidget,
                    secondWidget
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}