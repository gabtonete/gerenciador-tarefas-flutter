
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gerenciador_tarefas_flutter/Components/RoundedButton.dart';
import 'package:gerenciador_tarefas_flutter/Constants/Colors.dart';
import 'package:gerenciador_tarefas_flutter/Models/Tarefa.dart';
import 'package:gerenciador_tarefas_flutter/Service/TarefaService.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'HomeTextField.dart';

class NovaTarefaDialog extends StatefulWidget {
  final VoidCallback listarTarefas;

  const NovaTarefaDialog({
    Key? key,
    required this.listarTarefas
  }) : super(key: key);

  @override
  _NovaTarefaDialogState createState() => _NovaTarefaDialogState();
}

class _NovaTarefaDialogState extends State<NovaTarefaDialog> {
  final nomeTarefaController = TextEditingController();
  final dataConclusaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Adicionar uma tarefa', style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold))
          ]
      ),
      content: ConstrainedBox(
        constraints: new BoxConstraints(
          maxHeight: 120,
        ),
        child: Column(
          children: [
            HomeTextField(textHint: 'Adicionar uma tarefa', controllerTextField: nomeTarefaController,),
            Padding(
              padding: EdgeInsets.only(bottom: 0, left: 0, right: 0, top: 8),
              child: HomeTextField(textHint: 'Data de Conclusão', controllerTextField: dataConclusaoController, maskFormatter: new MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') }),),
            )
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
                text: 'Adicionar',
                onPressed: () {
                  EasyLoading.show(status: 'Carregando...');

                  DateTime dataPrevistaConclusaoDT = DateFormat('dd/MM/yyyy').parse(dataConclusaoController.text);

                  Tarefa novaTarefa = Tarefa(nome: nomeTarefaController.text, dataPrevistaConclusao: dataPrevistaConclusaoDT);

                  TarefaService.criar(novaTarefa).then((tarefaCriada) {
                    if(tarefaCriada == null) {
                      EasyLoading.showError("Ocorreu um erro ao criar sua tarefa!");
                    } else {
                      EasyLoading.showSuccess("Tarefa criada com sucesso!");
                      widget.listarTarefas();
                      Navigator.pop(context, 'OK');
                    }
                  }).catchError((err) {
                    EasyLoading.dismiss();
                    EasyLoading.showError(err['erros'].toString());
                  });
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
    );
  }
}