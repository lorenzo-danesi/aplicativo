import 'package:flutter/material.dart';

import '../../service/loginservice.dart';
import 'cadastro.dart';
import 'dashboard.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = TextEditingController();
    final senhaController = TextEditingController();

    return MaterialApp(
      title: "Aplicativo",
      home: Scaffold(
          appBar: AppBar(
            title: Text("LOGIN"),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      //color: Colors.red,
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: FlutterLogo(size: 80),
                    ),
                    Container(
                      //color: Colors.lightGreen,
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: loginController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(80.0)
                            ),
                            labelText: 'Digite seu login'
                        ),
                      ),
                    ),
                    Container(
                      //color: Colors.amber,
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: senhaController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(80.0)
                            ),
                            labelText: 'Digite a senha'
                        ),
                      ),
                    ),
                    Container(
                      //color: Colors.red,
                      padding: EdgeInsets.all(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50)
                        ),
                        child: Text("Fazer login"),
                        onPressed: (){
                          //realiza navegação para outra rota como ação do botão
                          //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Dashboard())):
                          logar(loginController.text, senhaController.text, context);
                        },
                      ),
                    ), Container(
                      padding: EdgeInsets.only(left: 25, top: 20),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => Cadastro()
                                    )
                                );
                              },
                              child: const Text('Criar conta',
                                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),
                              )
                          )

                        ],
                      ),
                    )
                  ]
              ),
            ),
          )
      ),
    );
  }

  alert(BuildContext context){
    return AlertDialog(
      title: Text('Usuário e/ou senha incorretos'),
      actions: <Widget>[
        TextButton(onPressed: ()=> Navigator.pop(context, 'OK'), child: Text('OK'))
      ],
    );
  }

  logar(String login, String senha, BuildContext context){
    bool valor;
    new LoginService().login(login, senha).then((value) {
      if(value){
        print('Usuario logado... '+ value.toString());
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const Dashboard())
        );
      }else{
        print('Usuario ou senha incorretos');
        showDialog(context: context, builder: (BuildContext context) => this.alert(context));

      }
    });
  }
}
