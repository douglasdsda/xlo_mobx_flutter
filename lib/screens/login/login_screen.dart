import 'package:flutter/material.dart';
import 'package:xlo_mobx/screens/signup/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                        TextField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
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
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                          ),
                          obscureText: true,
                        ),
                        Container(
                          height: 40,
                          margin: const EdgeInsets.only(top: 12, bottom: 12),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('ENTRAR'),
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                primary: Colors.orange,
                                textStyle: TextStyle(color: Colors.white)),
                          ),
                        ),
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