// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/products.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/floatingButton.dart';
import 'package:tcc/view/widget/productItem.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenProducts extends StatefulWidget {
  const ScreenProducts({super.key});

  @override
  State<ScreenProducts> createState() => _ScreenProductsState();
}

class _ScreenProductsState extends State<ScreenProducts> {
  var txtProd = TextEditingController();

  var list;

  @override
  void initState() {
    super.initState();
    list = ProductsController().list();
  }
  
  @override
  Widget build(BuildContext context) {
    Widget textFieldSearch() {
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.transparent, spreadRadius: 3),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              
              constraints: const BoxConstraints( 
                minWidth: 70,
              ),
      
              child: Center(
                child: TextFormField(
                  controller: txtProd,
      
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
      
                  decoration: InputDecoration(
                    labelText: 'Procurar item',
                    labelStyle: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
      
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:  const BorderSide(color: Colors.transparent ),
                    ),
                  ),
      
                  onChanged: (value) {
                    setState(() {
                      list = ProductsController().listSearch(value);
                    });
                  },
                )
              )
            )
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.transparent, spreadRadius: 3),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    textFieldSearch(),
                    Icon(Icons.search, size: 50, color: globals.primary,),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10,),

            const Text(
              'Produtos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'Roboto',
              ),
            ),

            const SizedBox(height: 10,),
            
            ProductItem(list),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
      floatingActionButton: floatingButton(context),
    );
  }
}