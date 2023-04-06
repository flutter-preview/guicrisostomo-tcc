class ProductsCartList {
  int? id;
  String? idProduct;
  String? name;
  num? price;
  int? qtd;
  int? idVariation;
  DateTime? date;
  static num total = 0;

  ProductsCartList({
    this.id,
    this.idProduct,
    this.name,
    this.price,
    this.qtd,
    this.idVariation,
    this.date,
  });

  num getTotal() {
    return total;
  }

  void setTotal(num value) {
    total = value;
  }
}