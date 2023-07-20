class Evento {
  late int id;
  String nome;
  String data;
  String hora;

  Evento(
    this.nome,
    this.data,
    this.hora
  );

  // construtor de objetos 'evento' a partir de JSON
  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      json['nome'],
      json['data'],
      json['hora']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'data': data,
      'hora': hora
    };
  }

}