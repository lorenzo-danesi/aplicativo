class UsuarioLogin{
  //int id;
  //String nome;
  String login;
  String senha;
  //String permissao;
  String token;

  UsuarioLogin(this.login, this.senha,  this.token);

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'senha': senha,
      'token': token,
    };
  }

  factory UsuarioLogin.fromJson(Map<String, dynamic> json){
    return UsuarioLogin(
        json['login'], json['senha'], json['token']);
  }

}