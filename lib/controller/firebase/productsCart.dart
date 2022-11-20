// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;

class ProductsCartController {
  
  list(uid) {
    return FirebaseFirestore.instance
      .collection('cart')
      .where('idSale', isEqualTo: uid);
  }

  void add(idSale, idItem, name, num price, int qtd, num subTotal) {
    FirebaseFirestore.instance.collection('cart').add(
      {
        'idSale': idSale,
        'idItem': idItem,
        'name': name,
        'price': price,
        'qtd': qtd,
        'subTotal': subTotal,
      },
    );
  }

  void remove(id) {
    FirebaseFirestore.instance.collection('cart').doc(id).delete();
  }

  void update(id, int qtd, num subTotal) {
    FirebaseFirestore.instance.collection('cart').doc(id).update(
      {
        'qtd': qtd,
        'subTotal': subTotal,
      },
    );
  }
}