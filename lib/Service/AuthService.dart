import 'dart:convert';

import 'package:gerenciador_tarefas_flutter/Constants/Endpoints.dart';
import 'package:gerenciador_tarefas_flutter/Models/User.dart';
import 'package:http/http.dart' as http;

class AuthService {

  static Future<User?> login(String email, String senha) async {
    User? usuarioLogado;

    var url = Uri.parse(ENDPOINT_LOGIN);

    var data = {
      'login': email,
      'senha': senha
    };

    var headers = {
      'Content-Type': 'application/json'
    };

    var response = await http.post(url, body: jsonEncode(data), headers: headers );

    switch (response.statusCode) {
        case 200:
          final parsedBody = jsonDecode(response.body);
          usuarioLogado = User.fromJson(parsedBody);
    }

    return usuarioLogado;
  }
}