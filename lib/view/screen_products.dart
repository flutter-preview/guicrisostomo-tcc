import 'package:flutter/material.dart';
import 'package:tcc/modal/textField.dart';

import '../modal/bottonNavigationCustomer.dart';

class ScreenProducts extends StatefulWidget {
  const ScreenProducts({super.key});

  @override
  State<ScreenProducts> createState() => _ScreenProductsState();
}

class _ScreenProductsState extends State<ScreenProducts> {
  var txtProd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromRGBO(50, 62, 64, 1),
            boxShadow: [
              BoxShadow(color: Colors.transparent, spreadRadius: 3),
            ],
          ),

          child: Column(
            children: [
              textField('Procurar item', txtProd),
              Icon(Icons.search, size: 50, color: Color.fromRGBO(242, 169, 34, 1),),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Bottom(),
    );
  }
}