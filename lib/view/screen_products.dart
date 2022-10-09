import 'package:flutter/material.dart';
import 'package:tcc/modal/productItem.dart';

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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromRGBO(50, 62, 64, 1),
                boxShadow: const [
                  BoxShadow(color: Colors.transparent, spreadRadius: 3),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    textFieldSearch('Procurar item', txtProd, context),
                    const Icon(Icons.search, size: 50, color: Color.fromRGBO(242, 169, 34, 1),),
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
            
            productItem(),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}

textFieldSearch(rotulo, variavel, context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    width: MediaQuery.of(context).size.width - 120,
    height: 70,
    child: Center(
      child: TextFormField(
        controller: variavel,
        
        style: const TextStyle(
          fontSize: 28,
          
        ),

        decoration: InputDecoration(
          labelText: rotulo,
          labelStyle: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide:  const BorderSide(color: Colors.transparent ),

          ),
        ),
      )
    )
  );
}