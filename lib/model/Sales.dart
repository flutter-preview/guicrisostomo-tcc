class Sales {
  int id;
  String uid;
  int? addressId;
  int? table;
  String cnpj;
  String? payment;
  String? type;
  String? observation;
  String status;
  DateTime date;
  num total = 0.0;
  String nameUserCreatedSale = '';
  num change;
  int items;
  bool isEmployee = false;

  Sales({
    required this.id,
    required this.uid,
    this.addressId,
    this.table,
    required this.cnpj,
    this.payment,
    this.type,
    this.observation,
    required this.status,
    required this.date,
    this.total = 0.0,
    this.nameUserCreatedSale = '',
    this.change = 0.0,
    this.items = 0,
    this.isEmployee = false,
  });

  num getTotal() {
    return total;
  }

  void setTotal(num value) {
    total = value;
  }
}