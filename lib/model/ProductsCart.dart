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
    this.id = 0,
    this.idProduct = '',
    this.name = '',
    this.price = 0,
    this.qtd = 0,
    this.idVariation = 0,
    this.date = null,
  });

  num getTotal() {
    return total;
  }

  void setTotal(num value) {
    total = value;
  }

  ProductsCartList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idProduct = json['id_product'];
    name = json['name'];
    price = json['price'];
    qtd = json['qtd'];
    idVariation = json['id_variation'];
    date = json['date'];
  }
}