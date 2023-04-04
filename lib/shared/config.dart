import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get projectId => _get('PROJECTID');
  static String get storageBucket => _get('STORAGEBUCKET');
  static String get messagingSenderId => _get('MESSAGINGSENDERID');

  static String get apiKeyWeb => _get('APIKEYWEB');
  static String get appIdWeb => _get('APPIDWEB');
  static String get authDomainWeb => _get('AUTHDOMAINWEB');

  static String get apiKeyAndroid => _get('APIKEYANDROID');
  static String get appIdAndroid => _get('APPIDANDROID');

  static String get mysqlHost => _get('MYSQLHOST');
  static String get mysqlUser => _get('MYSQLUSER');
  static String get mysqlPassword => _get('MYSQLPASSWORD');
  static String get mysqlDatabase => _get('MYSQLDB');
  static String get mysqlPort => _get('MYSQLPORT');

  static String _get(String name) => dotenv.env[name] ?? '';
}