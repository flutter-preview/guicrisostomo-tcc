// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/productsCart.dart';
import 'package:tcc/controller/firebase/sales.dart';
import 'package:tcc/main.dart';
import 'package:tcc/view/widget/customer/bottonNavigationCustomer.dart';
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
  String? idSale;
  
  double get largura => MediaQuery.of(context).size.width;
  void getIdSale() async {
    await SalesController().idSale().then((value){
      setState(() {
        idSale = value;
        list = ProductsCartController().list(idSale);
      });
    });
  }
  

  @override
  void initState() {
    super.initState();
    
    list = ProductsCartController().list(idSale);
  }


  @override
  Widget build(BuildContext context) {
    if (idSale == null) {
      getIdSale();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
        backgroundColor: globals.primary,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductsCart(list),

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

      bottomNavigationBar: const BottomCustomer(),
    );
  }
}