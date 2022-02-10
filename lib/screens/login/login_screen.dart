import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/screens/signup/signup_screen.dart';
import 'package:xlo_mobx/stores/login_store.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LoginStore loginStore = LoginStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Entrar'),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Acessar com E-mail',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[900],
                            )),
                        Observer(builder: (_) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ErrorBox(message: loginStore.error),
                          );
                        }),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 3, right: 4, top: 8),
                          child: Text(
                            'E-mail',
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Observer(builder: (_) {
                          return TextField(
                            enabled: !loginStore.loading,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                isDense: true,
                                errorText: loginStore.emailError),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: loginStore.setEmail,
                          );
                        }),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3, right: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Senha',
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              GestureDetector(
                                  child: Text(
                                    'Esqueceu sua senha?',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.purple,
                                    ),
                                  ),
                                  onTap: () {}),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Observer(builder: (_) {
                          return TextField(
                            enabled: !loginStore.loading,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                isDense: true,
                                errorText: loginStore.passwordError),
                            obscureText: true,
                            onChanged: loginStore.setPassword,
                          );
                        }),
                        Observer(builder: (_) {
                          return Container(
                            height: 40,
                            margin: const EdgeInsets.only(top: 12, bottom: 12),
                            child: ElevatedButton(
                              onPressed: loginStore.loginPressed,
                              child: loginStore.loading
                                  ? CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    )
                                  : Text('ENTRAR'),
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  onSurface: Colors.orange.withAlpha(120),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  primary: Colors.orange,
                                  textStyle: TextStyle(color: Colors.white)),
                            ),
                          );
                        }),
                        Divider(
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Wrap(
                            // se nao caber vai para linha de baixo
                            alignment: WrapAlignment.center,
                            children: [
                              const Text(
                                'Não tem uma conta?',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => SignUpScreen()));
                                },
                                child: Text(
                                  'Cadastre-se',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.purple,
                                      fontSize: 16),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
