// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsCartController {
  
  list(idSale) {
    return FirebaseFirestore.instance
      .collection('cart')
      .where('idSale', isEqualTo: idSale);
  }

  void add(String idSale, String idItem, String name, num price, int qtd, num subTotal, String category, String size) {
    FirebaseFirestore.instance.collection('cart').add(
      {
        'idSale': idSale,
        'idItem': idItem,
        'name': name,
        'price': price,
        'qtd': qtd,
        'subTotal': subTotal,
        'category': category,
        'size': size,
      },
    );
  }

  void remove(String id) {
    FirebaseFirestore.instance.collection('cart').doc(id).delete();
  }

  void update(String id, int qtd, num subTotal) {
    FirebaseFirestore.instance.collection('cart').doc(id).update(
      {
        'qtd': qtd,
        'subTotal': subTotal,
      },
    );
  }
}