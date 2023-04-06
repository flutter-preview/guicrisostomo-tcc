import 'package:mysql1/mysql1.dart';
import 'package:tcc/shared/config.dart';

Future<MySqlConnection> connectMySQL() async {
    return await MySqlConnection.connect(ConnectionSettings(
      host: Config.mysqlHost,
      port: int.parse(Config.mysqlPort),
      user: Config.mysqlUser,
      db: Config.mysqlDatabase,
      password: Config.mysqlPassword,
    ));
}

getIdVariation(String category, String size) async {
  return await connectMySQL().then((conn) async {
    var results = await conn.query('SELECT id FROM variations WHERE category = ? AND size = ?', [category, size]);
    await conn.close();
    return results;
  });
}