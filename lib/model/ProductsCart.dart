import 'package:tcc/model/Variation.dart';

class ProductsCartList {
  int? id;
  int? idRelative;
  int? idProduct;
  String? name;
  num? price;
  int? qtd;
  Variation? variation;
  DateTime? date;
  String? textVariation;
  int agregateItems = 0;
  static num total = 0;

  ProductsCartList({
    this.id = 0,
    this.idRelative = 0,
    this.idProduct = 0,
    this.name = '',
    this.price = 0,
    this.qtd = 0,
    this.variation,
    this.date,
    this.textVariation = '',
    this.agregateItems = 0,
  });

  num getTotal() {
    return total;
  }

  void setTotal(num value) {
    total = value;
  }
}