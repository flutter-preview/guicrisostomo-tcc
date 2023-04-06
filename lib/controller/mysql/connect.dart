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