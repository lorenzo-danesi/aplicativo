import 'package:sqflite/sqflite.dart';

import '../model/login.dart';
import 'openDatabaseDB.dart';


class LoginDao {
  adicionar(Login u) async {

    final Database db = await getDatabase();
    db.insert('LOGIN',u.toMap());

  }

  Future<Login?> getUsuarioLogado() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('login');

    if(maps.length > 0) {
      return List.generate(maps.length, (i){

        print("id - "+i.toString());
        print("--> "+maps[i]['token']);

        return Login(maps[i]['login'], maps[i]['senha'], maps[i]['permissao'],
            maps[i]['token']);
      })[maps.length -1];
    } else {
      return null;
    }
  }

}