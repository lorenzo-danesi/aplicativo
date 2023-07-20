import 'dart:convert';
import 'package:http/http.dart' as http;

import '../database/logindao.dart';
import '../model/evento.dart';

class EventoService {

  Map<String, String> headers = <String, String>{
    "Content-type": "application/json",
    "Accept-Charset": "utf-8",
  };

  Future<List<Evento>> getEventos() async {

    return LoginDao().getUsuarioLogado().then((value) async {

      String token = " Bearer "+value!.token;
      Map<String, String> header = <String, String>{
        "Content-Type":"application/json",
        "Authorization": token
      };

      final response = await http
        .get(Uri.parse('http://192.168.100.10:8080/eventos/lista'), headers: header);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return jsonResponse.map<Evento>( (json)=> Evento.fromJson(json) ).toList();

      } else {
        throw Exception('Falha ao carregar lista de eventos');
      }
    });
  }


  Future<bool> adicionar(Evento evento) async {
    try {
      final response = await http
          .post(Uri.parse('http://192.168.100.10:8080/eventos/adicionar'),
        headers: headers,
        body: jsonEncode(evento.toMap()),
      );

      if (response.statusCode == 200) {
        //evento salvo com sucesso
        return true;
      } else {
        //problemas na requisição
        return false;
      }
    } catch (e) {
      print("Erro ao salvar evento");
      return false;
    }
  }
}