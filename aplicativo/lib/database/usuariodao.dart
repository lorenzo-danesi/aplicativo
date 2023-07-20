import 'package:sqflite/sqflite.dart';

import '../model/Usuario.dart';
import '../model/usuariologin.dart';
import 'openDatabaseDB.dart';

class UsuarioDao {

  usuarioLogado(UsuarioLogin u) async {
    final Database db = await getDatabase();
    db.insert('USUARIO',u.toMap());

  }

  adicionar(Usuario u) async{
    final Database db = await getDatabase();
    db.insert('USUARIO',u.toMap());

  }

  Future<UsuarioLogin?> getUserLogado() async {
    print('GET USUARIO');
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('usuario');

    if (maps.length > 0) {
      return List.generate(maps.length, (i) {
        return UsuarioLogin(maps[i]['login'], maps[i]['senha'], maps[i]['token']);
      })[0];
    } else {
      return null;
    }
  }

}