import 'package:tcc/controller/mysql/utils.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/model/Business.dart';

class BusinessInformationController {
  Future<bool?> getInfoCalcValue() async {
    return await connectSupadatabase().then((conn) async {
      final result = await conn.from('business').select('highValue').eq('cnpj', globals.businessId).single();
      final Business infoBusiness = Business.fromJson(result as Map<String, dynamic>);
      return infoBusiness.highValue;
    });
  }
}