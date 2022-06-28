
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gerenciador_tarefas_flutter/Constants/Colors.dart';

class CustomSelect extends StatefulWidget {
  const CustomSelect({Key? key}) : super(key: key);

  @override
  State<CustomSelect> createState() => _CustomSelectState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _CustomSelectState extends State<CustomSelect> {
  String dropdownValue = 'Status';

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: new BoxConstraints(
        minHeight: 48,
        minWidth: 287,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor,),
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: DropdownButton<String>(
          hint: Text("Status"),
          value: dropdownValue,
          icon: Padding(
              padding: EdgeInsets.only(bottom: 0, left: 0, right: 10, top: 0),
              child: ImageIcon(AssetImage('assets/icons/flecha_baixo_icon.png'))
          ),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 0
          ),
          isExpanded: true,
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['Status', 'Concluídos', 'Não concluídos', 'Todos']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 0, left: 16.5, right: 0, top: 0),
                  child: Text(value)
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
