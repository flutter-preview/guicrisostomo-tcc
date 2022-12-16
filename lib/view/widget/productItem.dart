// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_typing_uninitialized_variables, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;

class ProductItem extends StatefulWidget {
  final product;

  const ProductItem(this.product,
      {Key? key})
      : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: (
        StreamBuilder<QuerySnapshot>(
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
                      String idItem = dados.docs[index].id;
                      String name = item['name'];
                      num price = item['price'];
                      String description = item['description'];
                      String category = item['category'];
                      String size = item['size'];
    
                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          contentPadding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                          leading: Icon(Icons.local_pizza, size: 50, color: globals.primary),
                          
                          title: Text(
                            name,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          ),
    
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$category - $size',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              
                              Text(
                                'R\$ ${price.toString().replaceFirst('.', ',')}',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              )
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
                                    Navigator.pushNamed(
                                      context,
                                      'products/add_product',
                                      arguments: dados.docs[index],
                                    );
                                  },
                                  
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(2),
                                    backgroundColor: globals.primary,
                                    shape: const CircleBorder(),
                                    foregroundColor: Colors.white,
                                  ),
    
                                  child: const Icon(
                                    Icons.add, size: 15,
                                    color: Colors.white,
                                  ),
                                  
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 10,),
                            
                            
                            Expanded(
                              child: SizedBox(
                                width: 25,
                                height: 25,
                                
                                child: ElevatedButton(
                                  
                                  
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      'products/info_product',
                                    );
                                  },
                                  
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(2),
                                    backgroundColor: globals.primary,
                                    shape: const CircleBorder(),
                                    foregroundColor: Colors.white,
                                  ),
                                  
                                  child: const Icon(Icons.question_mark, size: 15, color: Colors.white,),
                                
                                  ),
                                )
                              )
                            ]
                          ),
                          
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              'products/info_product',
                            );
                          },
                        )
                      );
                    },
                  );
                } else {
                  return Text('Nenhum item foi encontrado');
                }
            }
          },
        )
      ),
    );
  }
}