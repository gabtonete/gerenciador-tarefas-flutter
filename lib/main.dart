import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas_flutter/Constants/Colors.dart';
import 'package:gerenciador_tarefas_flutter/Views/Login/LoginView.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:localstorage/localstorage.dart';

import 'Views/Home/HomeView.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 12.0
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..maskType = EasyLoadingMaskType.black;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LocalStorage storage = new LocalStorage('main');

    return MaterialApp(
      title: 'Gerenciador de Tarefas',
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Biennale'
      ),
      home: storage.getItem('usuarioLogado') == null ? LoginView() : HomeView(),
      builder: EasyLoading.init(),
    );
  }
}
