// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:tcc/controller/postgres/Lists/productsCart.dart';
import 'package:tcc/controller/postgres/Lists/sales.dart';
import 'package:tcc/main.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/listCart.dart';
import 'package:tcc/globals.dart' as globals;

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
  int idSale = 0;
  
  double get largura => MediaQuery.of(context).size.width;
  Future<void> getList() async {
    await SalesController().idSale().then((value) async {
      idSale = value;
      await ProductsCartController().list(idSale).then((value) {
        list = value;
      });
    });
    print('a');
  }


  @override
  Widget build(BuildContext context) {

    print('a');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
        backgroundColor: globals.primary,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: getList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ProductsCart(product: list);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }
            ),

            Container(
              alignment: Alignment.bottomCenter,
              child: button(
                'Finalizar',
                300,
                50,
                Icons.check,
                () => {
                  Navigator.push(context, navigator('finalize_order_customer'))
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}