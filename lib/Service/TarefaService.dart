import 'dart:convert';

import 'package:gerenciador_tarefas_flutter/Constants/Endpoints.dart';
import 'package:gerenciador_tarefas_flutter/Models/Tarefa.dart';
import 'package:gerenciador_tarefas_flutter/Models/User.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

class TarefaService {
  static final LocalStorage storage = new LocalStorage('main');

  static Future<Tarefa?> criar(Tarefa novaTarefa) async {
    Tarefa? tarefaCriada;

    var url = Uri.parse(ENDPOINT_CRIAR_TAREFA);

    var data = {
      'nome': novaTarefa.nome,
      'dataPrevistaConclusao': DateFormat('yyyy-MM-dd').format(novaTarefa.dataPrevistaConclusao)
    };

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${storage.getItem('usuarioLogado')['token']}'
    };

    var response = await http.post(url, body: jsonEncode(data), headers: headers );

    print(response.body);

    switch (response.statusCode) {
        case 201:
          final parsedBody = jsonDecode(response.body);
          tarefaCriada = Tarefa.fromJson(parsedBody);
          break;
        case 400:
          final parsedBody = jsonDecode(response.body);
          throw parsedBody;
    }

    return tarefaCriada;
  }

  static Future<List<Tarefa>> listar([Map<String, dynamic>? filtros]) async {
    List<Tarefa> tarefas = new List<Tarefa>.empty();

    Map<String, String> filtrosAplicados = { };

    if(filtros != null) {
      if(filtros.containsKey('periodoDe')) filtrosAplicados['periodoDe'] = filtros['periodoDe'].toString();
      if(filtros.containsKey('periodoAte')) filtrosAplicados['periodoAte'] = filtros['periodoAte'].toString();
      if(filtros.containsKey('status')) filtrosAplicados['status'] = filtros['status'].toString();
    }

    var url = Uri.parse(ENDPOINT_LISTAR_TAREFA+'?'+Uri(queryParameters: filtrosAplicados).query);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${storage.getItem('usuarioLogado')['token']}'
    };

    var response = await http.get(url, headers: headers );

    switch (response.statusCode) {
      case 200:
        final parsedBody = jsonDecode(response.body);
        tarefas = parsedBody.map<Tarefa>((tarefa) => Tarefa.fromJson(tarefa)).toList();
    }

    return tarefas;
  }


  static Future<bool> atualizar(Tarefa tarefa) async {
    var url = Uri.parse(ENDPOINT_ATUALIZAR_TAREFA+tarefa.id.toString());

    var data = {
      'nome': tarefa.nome,
      'dataPrevistaConclusao': DateFormat('yyyy-MM-dd').format(tarefa.dataPrevistaConclusao)
    };

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${storage.getItem('usuarioLogado')['token']}'
    };

    var response = await http.put(url, body: jsonEncode(data), headers: headers );

    switch (response.statusCode) {
      case 500:
        throw {
                'erros': 'Ocorreu um erro ao processar sua requisição.'
              };
      case 400:
        final parsedBody = jsonDecode(response.body);
        throw parsedBody;
    }

    return true;
  }

  static Future<bool> concluir(int idTarefa) async {
    var url = Uri.parse(ENDPOINT_ATUALIZAR_TAREFA+idTarefa.toString());

    var data = {
      'dataConclusao': DateFormat('yyyy-MM-dd').format(DateTime.now())
    };

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${storage.getItem('usuarioLogado')['token']}'
    };

    var response = await http.put(url, body: jsonEncode(data), headers: headers );

    switch (response.statusCode) {
      case 500:
        throw {
          'erros': 'Ocorreu um erro ao processar sua requisição.'
        };
    }

    return true;
  }

  static Future<bool> deletar(int idTarefa) async {
    var url = Uri.parse(ENDPOINT_DELETAR_TAREFA+idTarefa.toString());

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${storage.getItem('usuarioLogado')['token']}'
    };

    var response = await http.delete(url, headers: headers );

    switch (response.statusCode) {
      case 500:
        throw {
          'erros': 'Ocorreu um erro ao processar sua requisição.'
        };
    }

    return true;
  }

}