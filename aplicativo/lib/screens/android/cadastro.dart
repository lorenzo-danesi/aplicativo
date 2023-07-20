import 'package:flutter/material.dart';

import '../../model/usuariologin.dart';

class Cadastro extends StatefulWidget {

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CADASTRO"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
                child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        controller: nomeController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Nome",
                            helperText: "Digite seu nome completo"
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: loginController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Login",
                            helperText: "Insira seu endereço de e-mail"
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        controller: senhaController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Crie uma senha",
                            helperText: "A senha deve possuir 4 caracteres"
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        //color: Colors.red,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(18),
                            elevation: 5.0,
                            //color: Colors.blue,
                          ),
                          onPressed: () {
                            //verifica se o campo tem algo, caso contrário não salva
                            if (_formKey.currentState!.validate()) {
                              UsuarioLogin u = UsuarioLogin(
                                nomeController.text,
                                loginController.text,
                                senhaController.text
                              );
                              Navigator.of(context).pop();
                            } else {
                              debugPrint('formulário inválido');
                            }
                          },
                          child: Text('Criar conta'),
                        ),
                      )
                    ]
                )
            )
        ),
      ),
    );
  }
}
