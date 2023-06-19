import 'package:go_router/go_router.dart';
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
    GoRouter.of(Config.navigatorKey.currentContext!).go(
      '/error',
      extra: 'Erro ao conectar com o banco de dados.'
    );
  });
  return conn;
}