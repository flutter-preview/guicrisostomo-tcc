class ProductsCart {
  ProductsCart({required this.idSale, required this.idItem, required this.name, required this.price, required this.qtd, required this.subTotal});

  ProductsCart.fromJson(Map<String, Object?> json)
    : this(
        idSale: json['idSale']! as String,
        idItem: json['idItem']! as String,
        name: json['name']! as String,
        price: json['price']! as double,
        qtd: json['qtd']! as int,
        subTotal: json['subTotal']! as double,
      );

  final String idSale;
  final String idItem;
  final String name;
  final double price;
  final int qtd;
  final double subTotal;

  Map<String, Object?> toJson() {
    return {
      'idSale': idSale,
      'idItem': idItem,
      'name': name,
      'price': price,
      'qtd': qtd,
      'subTotal': subTotal,
    };
  }
}