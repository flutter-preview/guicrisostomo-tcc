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

  static String _get(String name) => dotenv.env[name] ?? '';
}