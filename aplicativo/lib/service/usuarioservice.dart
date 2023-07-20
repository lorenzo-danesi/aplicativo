import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../database/usuariodao.dart';
import '../model/usuariologin.dart';


class UsuarioService {

  Map<String, String> headers = <String, String>{
    'Content-type':'application/json'
  };

  UsuarioLogin? getUsuarioLogado() {
    print('vai retornar o usuário ......');
    new UsuarioDao().getUserLogado().then((value) {
      return value;
    });
  }

  Future<bool> login({required String email, required String senha}) async{
    final conteudo = json.encode(<String, String>{'login': email, 'senha':senha});
    final resposta = await http.post(Uri.parse('http://192.168.100.10:8080/login'), headers: headers, body: conteudo, encoding: null);

    debugPrint('-->'+resposta.statusCode.toString());
    debugPrint('-->'+resposta.body.toString());

    if(resposta.statusCode == 200){
      UsuarioLogin u = UsuarioLogin.fromJson(jsonDecode(resposta.body));
      debugPrint('-->'+resposta.body.toString());
      new UsuarioDao().usuarioLogado(u);
     /* localStorage.setItem("USUARIO_LOGADO", u.toMap());
      Map<String, dynamic> data = localStorage.getItem("USUARIO_LOGADO");
      print('vai retornar o usuário ......'+data.toString());*/
      return true;
    }
      return false;
  }

}


