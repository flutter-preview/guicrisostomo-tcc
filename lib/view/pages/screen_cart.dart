import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/productsCart.dart';
import 'package:tcc/controller/firebase/sales.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/floatingButton.dart';
import 'package:tcc/view/widget/listCart.dart';

class ScreenCart extends StatefulWidget {
  const ScreenCart({super.key});

  @override
  State<ScreenCart> createState() => _ScreenCartState();
}

class _ScreenCartState extends State<ScreenCart> {
  /*final productsCartsRef = FirebaseFirestore.instance.collection('ProductsCarts').withConverter<ProductsCart>(
    fromFirestore: (snapshot, _) => ProductsCart.fromJson(snapshot.data()!),
    toFirestore: (productsCart, _) => productsCart.toJson(),
  );

  Future<void> main() async {
    List<QueryDocumentSnapshot<ProductsCart>> productsCarts = await productsCartsRef
      .where('genre', isEqualTo: 'Sci-fi')
      .get()
      .then((snapshot) => snapshot.docs);
  }*/

  var list;
  String? idSale;
  void getIdSale() async {
    await SalesController().idSale().then((value){
      idSale = value;
    });
  }
  

  @override
  void initState() {
    super.initState();
    
    list = ProductsCartController().list(idSale);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(50, 62, 64, 1),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductsCart(list)
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}