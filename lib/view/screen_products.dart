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
        padding: EdgeInsets.all(20),
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(50, 62, 64, 1),
                  boxShadow: [
                    BoxShadow(color: Colors.transparent, spreadRadius: 3),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      textFieldSearch('Procurar item', txtProd, context),
                      Icon(Icons.search, size: 50, color: Color.fromRGBO(242, 169, 34, 1),),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10,),

              Text(
                'Produtos',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                ),
              ),

              SizedBox(height: 10,),
              
              productItem(),
            ],
          )
          

          

        ),
      ),

      bottomNavigationBar: Bottom(),
    );
  }
}

textFieldSearch(rotulo, variavel, context) {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    width: MediaQuery.of(context).size.width - 120,
    height: 70,
    child: Center(
      child: TextFormField(
        controller: variavel,
        
        style: TextStyle(
          fontSize: 28,
          
        ),

        decoration: InputDecoration(
          labelText: rotulo,
          labelStyle: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),

          enabledBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(20.0),
            borderSide:  BorderSide(color: Colors.transparent ),

          ),
        ),
        
        //
        // VALIDAÇÃO
        //

        validator: (value) {
          
        },
      )
    )
  );
}