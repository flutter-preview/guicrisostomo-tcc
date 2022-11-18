import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductsCartController {

  list() {
    return FirebaseFirestore.instance
      .collection('cart')
      .where('idSale', isEqualTo: FirebaseAuth.instance.currentUser!.uid);
  }

  void add(titulo, descricao) {
    FirebaseFirestore.instance.collection('cart').add(
      {
        'titulo': titulo,
        'descricao': descricao,
        'status': '0',
        'uid': FirebaseAuth.instance.currentUser!.uid,
      },
    );
  }

  void remove(id) {
    FirebaseFirestore.instance.collection('cart').doc(id).delete();
  }

  void update(id, status) {
    
  }
}