import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gerenciador_tarefas_flutter/Components/CustomPasswordField.dart';
import 'package:gerenciador_tarefas_flutter/Components/CustomTextField.dart';
import 'package:gerenciador_tarefas_flutter/Components/RoundedButton.dart';
import 'package:gerenciador_tarefas_flutter/Service/AuthService.dart';
import 'package:gerenciador_tarefas_flutter/Views/Home/HomeView.dart';
import 'package:localstorage/localstorage.dart';


class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var emailController = TextEditingController(text: "");
  var senhaController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final LocalStorage storage = new LocalStorage('main');

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  child: Image.asset("assets/images/logo_devaria.png"),
                  top: 192,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0, left: 52, right: 52, top: 120),
                    child: CustomTextField(
                      textHint: 'E-mail',
                      assetImage: AssetImage("assets/icons/email_icon.png"),
                      controller: emailController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0, left: 52, right: 52, top: 5),
                    child: CustomPasswordField(
                      hintText: 'Senha',
                      controller: senhaController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0, left: 52, right: 52, top: 30),
                    child: RoundedButton(
                      text: 'Login',
                      onPressed: () {
                        EasyLoading.show(status: 'Carregando...');

                        AuthService.login(emailController.text, senhaController.text).then((usuarioLogado) {
                          EasyLoading.dismiss();

                          if(usuarioLogado != null) {
                            storage.setItem('usuarioLogado', usuarioLogado);

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => HomeView()),
                                ModalRoute.withName('/home')
                            );
                          } else {
                            EasyLoading.showError("Usuário ou Senha incorretos!");
                          }
                        }).catchError((e) {
                          EasyLoading.dismiss();
                          EasyLoading.showError("Ocorreu um erro ao processar sua requisição.");
                        });
                      }
                    ),
                  )
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}



