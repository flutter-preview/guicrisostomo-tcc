// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc/controller/firebase/productsCart.dart';
import 'package:tcc/view/widget/snackBars.dart';

class ProductsCart extends StatefulWidget {
  final product;

  const ProductsCart(this.product,
      {Key? key})
      : super(key: key);

  @override
  State<ProductsCart> createState() => _ProductsCartState();
}

class _ProductsCartState extends State<ProductsCart> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: StreamBuilder<QuerySnapshot>(
          stream: widget.product.snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(
                  child: Text('Não foi possível conectar.'),
                );
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                final dados = snapshot.requireData;
                if (dados.size > 0) {
                  return ListView.builder(
                    itemCount: dados.size,
                    itemBuilder: (context, index) {
                      dynamic item = dados.docs[index].data();
                      String uid;
                      String idItem = item.id;
                      String name = item['name'];
                      double price = item['price'];
                      int qtd = item['qtd'];
                      double subTotal = item['subTotal'];

                      return Card(
                        color: const Color.fromRGBO(50, 62, 64, 1),
                        child: ListTile(
                          title: Text(
                            name,
                            style: GoogleFonts.roboto(fontSize: 22),
                          ),
                          subtitle: Column(
                            children: [
                              Text(
                                "Preço: $price",
                                style: GoogleFonts.roboto(fontSize: 18),
                              ),

                              const SizedBox(height: 5,),

                              Text(
                                "Quantidade: $qtd",
                                style: GoogleFonts.roboto(fontSize: 18),
                              ),

                              const SizedBox(height: 5,),

                              Text(
                                "Sub-total: $subTotal",
                                style: GoogleFonts.roboto(fontSize: 18),
                              ),
                            ]
                          ),
                          trailing: SizedBox(
                            width: 25,
                            height: 25,
                            
                            child: ElevatedButton(
                                
                              onPressed: () {
                                ProductsCartController().remove(
                                  dados.docs[index].id,
                                );

                                success(
                                  context,
                                  'Produto removido com sucesso.',
                                );
                              },
                              
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(2),
                                backgroundColor: const Color.fromRGBO(242, 169, 34, 1),
                                shape: const CircleBorder(),
                                foregroundColor: Colors.white,
                              ),
                              child: const Icon(Icons.add, size: 15, color: Colors.white,),
                            )
                          )
                        )
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('O carrinho está vazio.'),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}