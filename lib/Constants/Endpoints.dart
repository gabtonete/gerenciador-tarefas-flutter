import 'package:flutter_dotenv/flutter_dotenv.dart';

var ENDPOINT_LOGIN = '${dotenv.env['BASE_URL']}/api/login';
var ENDPOINT_CRIAR_TAREFA = '${dotenv.env['BASE_URL']}/api/tarefa';
var ENDPOINT_ATUALIZAR_TAREFA = '${dotenv.env['BASE_URL']}/api/tarefa/';
var ENDPOINT_DELETAR_TAREFA = '${dotenv.env['BASE_URL']}/api/tarefa/';
var ENDPOINT_LISTAR_TAREFA = '${dotenv.env['BASE_URL']}/api/tarefa';