// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/productsCart.dart';
import 'package:tcc/controller/firebase/sales.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
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

  Widget? buttonFinalize() {
    if (list = false) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(largura, 50), 
            backgroundColor: const Color.fromRGBO(50, 62, 64, 1),
          ),
          
          child: const Text(
            'Finalizar pedido',
            style: TextStyle(
              fontSize: 24,
            )
          ),
          
          onPressed: () {
            SalesController().update(idSale, 1, context);
            Navigator.pop(context);
            Navigator.pushNamed(context, 'home');
          },
        ),
      );
    }

    return null;
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
        backgroundColor: const Color.fromRGBO(50, 62, 64, 1),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductsCart(list),

            Container(
              alignment: Alignment.bottomCenter,
              child: buttonFinalize(),
            )
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}