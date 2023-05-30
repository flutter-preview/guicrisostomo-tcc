import 'package:postgres/postgres.dart';
import 'package:tcc/shared/config.dart';

Future<PostgreSQLConnection> connectSupadatabase() async {
  PostgreSQLConnection conn = PostgreSQLConnection(
    Config.supabaseHost,
    Config.supabasePort,
    Config.supabaseDatabase,
    username: Config.supabaseUser,
    password: Config.supabasePassword,
    
  );
  await conn.open().catchError((onError) {
  });
  return conn;
}