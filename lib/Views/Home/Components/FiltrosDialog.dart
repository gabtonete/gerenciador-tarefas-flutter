
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gerenciador_tarefas_flutter/Components/CustomSelect.dart';
import 'package:gerenciador_tarefas_flutter/Components/RoundedButton.dart';
import 'package:gerenciador_tarefas_flutter/Constants/Colors.dart';
import 'package:gerenciador_tarefas_flutter/Models/Tarefa.dart';
import 'package:gerenciador_tarefas_flutter/Service/TarefaService.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'HomeTextField.dart';

class FiltrosDialog extends StatefulWidget {
  final Function([Map<String, dynamic>?]) listarTarefas;
  final dataPrevistaInicialController;
  final dataPrevistaFinalController;

  const FiltrosDialog({
    Key? key,
    required this.listarTarefas,
    this.dataPrevistaInicialController,
    this.dataPrevistaFinalController
  }) : super(key: key);

  @override
  _FiltrosDialogState createState() => _FiltrosDialogState();
}

class _FiltrosDialogState extends State<FiltrosDialog> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: AlertDialog(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Filtrar tarefas', style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold))
            ]
        ),
        content: ConstrainedBox(
          constraints: new BoxConstraints(
              maxHeight: 170,
              maxWidth: size.width
          ),
          child: Column(
            children: [
              HomeTextField(textHint: 'Data prevista de conclusão (inicial)', controllerTextField: widget.dataPrevistaInicialController, maskFormatter: new MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') }),),
              Padding(
                padding: EdgeInsets.only(bottom: 8, left: 0, right: 0, top: 8),
                child: HomeTextField(textHint: 'Data prevista de conclusão (final)', controllerTextField: widget.dataPrevistaFinalController, maskFormatter: new MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') }),),
              ),
              CustomSelect()
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 0, left: 0, right: 0, top: 0),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedButton(
                  text: 'Aplicar filtros',
                  onPressed: () {
                    Map<String, dynamic> filtros = { };

                    if(widget.dataPrevistaInicialController.text != "") filtros['periodoDe'] = DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy').parse(widget.dataPrevistaInicialController.text));
                    if(widget.dataPrevistaFinalController.text != "") filtros['periodoAte'] = DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy').parse(widget.dataPrevistaFinalController.text));

                    widget.listarTarefas(filtros);

                    Navigator.pop(context, 'OK');
                  },
                  width: 120,
                  height: 48,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 0, left: 27, right: 0, top: 0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'Cancelar');
                    },
                    style: TextButton.styleFrom(
                        primary: primaryColor,
                        textStyle: TextStyle(decoration: TextDecoration.underline)
                    ),
                    child: const Text('Cancelar'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}