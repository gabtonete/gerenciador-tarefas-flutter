
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gerenciador_tarefas_flutter/Components/CustomTextField.dart';
import 'package:gerenciador_tarefas_flutter/Components/RoundedButton.dart';
import 'package:gerenciador_tarefas_flutter/Constants/Colors.dart';
import 'package:gerenciador_tarefas_flutter/Models/Tarefa.dart';
import 'package:gerenciador_tarefas_flutter/Service/TarefaService.dart';
import 'package:gerenciador_tarefas_flutter/Views/Home/Components/CustomItemList.dart';
import 'package:gerenciador_tarefas_flutter/Views/Home/Components/HomeTextField.dart';
import 'package:gerenciador_tarefas_flutter/Views/Login/LoginView.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

import 'Components/AlterarTarefaDialog.dart';
import 'Components/CustomBox.dart';
import 'Components/FiltrosDialog.dart';
import 'Components/NovaTarefaDialog.dart';

class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final LocalStorage storage = new LocalStorage('main');

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/images/logo_devaria.png", height: 24,),
            Row(
              children: [
                Text("Olá, ${storage.getItem('usuarioLogado')['nome']}", style: const TextStyle(color: primaryColor, fontSize: 12, fontWeight: FontWeight.w400),),
                SizedBox(
                    height: 38,
                    width: 38,
                    child: IconButton(
                      onPressed: () {
                        storage.clear();

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => LoginView()),
                            ModalRoute.withName('/login')
                        );
                      },
                      icon: ImageIcon(AssetImage('assets/icons/sair_icon.png'), color: primaryColor),
                    )
                )
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: BodyHomeView(size: size),
      ),
    );
  }
}

class BodyHomeView extends StatefulWidget {
  const BodyHomeView({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _BodyHomeViewState createState() => _BodyHomeViewState();
}

class _BodyHomeViewState extends State<BodyHomeView> {

  List<Tarefa> tarefas = List<Tarefa>.empty();
  var dataPrevistaInicialController = TextEditingController(text: "");
  var dataPrevistaFinalController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();

    TarefaService.listar().then((tarefasEncontradas) {
      setState(() {
        tarefas = tarefasEncontradas;
      });
    });
  }

  void listarTarefas([Map<String, dynamic>? filtros]) {
    TarefaService.listar(filtros).then((tarefasEncontradas) {
      setState(() {
        tarefas = tarefasEncontradas;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 510,
      width: widget.size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomBox(
            size: widget.size,
            spaceBetween: true,
            firstWidget: Text("Tarefas", style: const TextStyle(color: primaryColor, fontSize: 18, fontWeight: FontWeight.w600)),
            secondWidget: IconButton(onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => FiltrosDialog(
                  listarTarefas: listarTarefas,
                  dataPrevistaInicialController: dataPrevistaInicialController,
                  dataPrevistaFinalController: dataPrevistaFinalController,
              ),
            ), icon: ImageIcon(AssetImage('assets/icons/filtro_icon.png'), color: primaryColor),),
            onTap: () { },
          ),
          tarefas.length > 0 ?
          SizedBox(
            height: 365,
            child: ListView.builder(
                itemCount: tarefas.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 0, left: 8, right: 8, top: 0),
                    child: CustomItemList(
                        size: widget.size,
                        titulo: tarefas[index].nome,
                        estaConcluido: tarefas[index].dataConclusao != null,
                        subtitulo: 'Conclusão em: ${DateFormat('dd/MM/yyyy').format(tarefas[index].dataPrevistaConclusao)}',
                        tarefaId: tarefas[index].id,
                        listarTarefas: listarTarefas,
                        onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlterarTarefaDialog(listarTarefas: listarTarefas, tarefaSelecionada: tarefas[index],),
                        )
                    ),
                  );
                }
            ),
          ) : Column(
            children: [
              Image.asset("assets/images/sem_tarefas.png", height: 53.5,),
              Text("Você ainda não possui tarefas cadastras!", style: const TextStyle(color: primaryColor, fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
          CustomBox(
              size: widget.size,
              spaceBetween: false,
              firstWidget: IconButton(onPressed: () { }, icon: ImageIcon(AssetImage('assets/icons/adicionar_icon.png'), color: primaryColor),),
              secondWidget: Text("Adicionar uma tarefa", style: TextStyle(color: primaryColor, fontSize: 14, fontWeight: FontWeight.w500)),
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => NovaTarefaDialog(listarTarefas: listarTarefas),
              )
          )
        ],
      ),
    );
  }
}




