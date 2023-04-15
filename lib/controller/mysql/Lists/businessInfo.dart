import 'package:tcc/controller/mysql/utils.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/model/Business.dart';

class BusinessInformationController {
  Future<bool?> getInfoCalcValue() async {
    return await connectSupadatabase().then((conn) async {
      
      return await conn.query('SELECT highvalue FROM business WHERE cnpj = @cnpj', substitutionValues: {
        'cnpj': globals.businessId
      }).then((List value) {
        conn.close();
        // for (var row in value) {
        //   Business results = Business.fromJson(row);
        //   return results.highValue;
        // }
        return value.first[0];
      });
      // return await conn.from('business').select('highValue').eq('cnpj', globals.businessId).single().then((value) {
      //   Business results = Business.fromJson(value);
      //   return results.highValue;
      // });
      
    });
  }
}