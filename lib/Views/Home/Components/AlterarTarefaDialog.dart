
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

class AlterarTarefaDialog extends StatefulWidget {
  final VoidCallback listarTarefas;
  final Tarefa tarefaSelecionada;

  const AlterarTarefaDialog({
    Key? key,
    required this.listarTarefas,
    required this.tarefaSelecionada
  }) : super(key: key);

  @override
  _AlterarTarefaDialogState createState() => _AlterarTarefaDialogState();
}

class _AlterarTarefaDialogState extends State<AlterarTarefaDialog> {
  final nomeTarefaController = TextEditingController();
  final dataPrevistaConclusaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nomeTarefaController.text = widget.tarefaSelecionada.nome;
    dataPrevistaConclusaoController.text = DateFormat("dd/MM/yyyy").format(widget.tarefaSelecionada.dataPrevistaConclusao);

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
          ),
          SizedBox(
            width: 130,
            child: Text('Alterar tarefa', style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkResponse(
                    child: Image.asset('assets/icons/fechar_icon.png'),
                    onTap: () {
                      Navigator.pop(context, 'Cancel');
                    },
                  )

                ],
              )
          ),
        ],
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
              child: HomeTextField(textHint: 'Data de Conclusão', controllerTextField: dataPrevistaConclusaoController, maskFormatter: new MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') }),),
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
                text: 'Salvar alterações',
                onPressed: () {
                  EasyLoading.show(status: "Carregando");

                  Tarefa tarefaAtualizada = new Tarefa(
                    id: widget.tarefaSelecionada.id,
                    nome: nomeTarefaController.text,
                    dataPrevistaConclusao: DateFormat('dd/MM/yyyy').parse(dataPrevistaConclusaoController.text),
                    dataConclusao: widget.tarefaSelecionada.dataConclusao,
                    idUsuario: widget.tarefaSelecionada.idUsuario
                  );

                  TarefaService.atualizar(tarefaAtualizada).then((value) {
                    EasyLoading.showSuccess("Tarefa atualizada com sucesso!");
                    widget.listarTarefas();
                    Navigator.pop(context, 'OK');
                  }).catchError((err) {
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
                    TarefaService.deletar(widget.tarefaSelecionada.id!).then((value) {
                      EasyLoading.showSuccess("Tarefa excluída com sucesso!");
                      widget.listarTarefas();
                      Navigator.pop(context, 'Excluir');
                    }).catchError((err) {
                      EasyLoading.showError(err['erros'].toString());
                    });
                  },
                  style: TextButton.styleFrom(
                      primary: primaryColor,
                      textStyle: TextStyle(decoration: TextDecoration.underline)
                  ),
                  child: const Text('Excluir tarefa'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}