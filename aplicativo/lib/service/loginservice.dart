import 'dart:convert';
import 'package:aplicativo/database/logindao.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/login.dart';

class LoginService {

  Map<String, String> headers = <String, String> {
    "Content-type":"application/json",
  };

  String? tokenUsuarioLogado(){
    LoginDao().getUsuarioLogado().then((value) {
      print("-->> token: "+value!.token);
      return value!.token;
    });
  }

  Future<bool> login( String login, String senha ) async {
    final conteudo = json.encode(<String, String>{'login': login, 'senha': senha});

    final resposta = await http.post(Uri.parse('http://192.168.100.10:8080/login'), headers: headers, body: conteudo);
    debugPrint("Status Code: "+resposta.statusCode.toString());
    debugPrint("valor: "+resposta.body.toString());

    if(resposta.statusCode == 200){

      Login usuarioLogado = Login.fromJson(jsonDecode(resposta.body));

      new LoginDao().adicionar(usuarioLogado);
      return true;
    }

    return false;
  }

}