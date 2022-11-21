// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc/controller/firebase/productsCart.dart';
import 'package:tcc/controller/firebase/sales.dart';
import 'package:tcc/view/widget/snackBars.dart';
import 'package:tcc/view/widget/textFieldNumberGeneral.dart';

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
    var txtQtd = TextEditingController();

    return Padding(
      padding: EdgeInsets.all(20),
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
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    dynamic item = dados.docs[index].data();
                    String uid;
                    String idItem = dados.docs[index].id;
                    String name = item['name'];
                    num price = item['price'];
                    int qtd = item['qtd'];
                    num subTotal = item['subTotal'];

                    return Card(
                      color: const Color.fromRGBO(50, 62, 64, 1),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(
                            name,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                      
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Preço: R\$ ${price.toString().replaceFirst('.', ',')}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                      
                              Text(
                                "Quantidade: $qtd",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                      
                              Text(
                                'Sub-total: R\$ ${subTotal.toString().replaceFirst('.', ',')}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ]
                          ),
                      
                          trailing: Column(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: ElevatedButton(
                                      
                                    onPressed: () {
                                      txtQtd.text = item['qtd'].toString();
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                            'Informe a quantidade',
                                            style: GoogleFonts.roboto(
                                              fontSize: 36,
                                              color: Colors.blueGrey.shade700,
                                            ),
                                          ),
                                          titlePadding: EdgeInsets.all(20),
                                          content: SizedBox(
                                            width: 350,
                                            height: 90,
                                            child: Column(
                                              children: [
                                                textFieldNumberGeneral('Quantidade', txtQtd, context),
                                              ],
                                            ),
                                          ),
                                          backgroundColor: Colors.blueGrey.shade50,
                                          actionsPadding: EdgeInsets.fromLTRB(0, 0, 20, 20),
                                          actions: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                minimumSize: Size(120, 50),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Cancelar',
                                                style: GoogleFonts.roboto(
                                                  fontSize: 20,
                                                  color: Colors.blueAccent.shade700,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor: Colors.blueAccent.shade700,
                                                minimumSize: Size(120, 50),
                                              ),
                                              onPressed: () async {
                                                if (txtQtd.text.isNotEmpty) {
                                                  String? idSale;

                                                  await SalesController().idSale().then((res) async {
                                                    idSale = res;

                                                    await SalesController().getTotal().then((res){
                                                      SalesController().updateTotal(idSale, (res - subTotal) + (num.parse(price.toString()) * int.parse(txtQtd.text)));
                                                      ProductsCartController().update(idItem, int.parse(txtQtd.text), num.parse(price.toString()) * int.parse(txtQtd.text));

                                                      Navigator.pop(context);
                                                      
                                                      success(context, 'Quantidade atualizada com sucesso.');
                                                    }).catchError((e){
                                                      error(context, 'Ocorreu um erro ao atualizar a quantidade: ${e.code.toString()}');
                                                    });
                                                    
                                                  }).catchError((e){
                                                    error(context, 'Ocorreu um erro ao atualizar a quantidade: ${e.code.toString()}');
                                                  });
                                                  
                                                } else {
                                                  error(context, 'Informe a quantidade.');
                                                }
                                              },
                                              child: Text(
                                                'Atualizar',
                                                style: GoogleFonts.roboto(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(2),
                                      backgroundColor: const Color.fromRGBO(242, 169, 34, 1),
                                      shape: const CircleBorder(),
                                      foregroundColor: Colors.white,
                                    ),
                          
                                    child: const Icon(
                                      Icons.edit, size: 15,
                                      color: Colors.white,
                                    ),
                                    
                                  ),
                                ),
                              ),
                              
                              const SizedBox(height: 10,),
                              
                              
                              Expanded(
                                child: SizedBox(
                                  width: 35,
                                  height: 35,
                                  
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
                                    child: const Icon(Icons.delete, size: 15, color: Colors.white,),
                      
                                  ),
                                )
                              )
                            ]
                          ),
                        ),
                      )
                    );
                  },
                );
              } else {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text('O carrinho está vazio.')
                  )
                );
              }
          }
        },
      )
    );
  }
}