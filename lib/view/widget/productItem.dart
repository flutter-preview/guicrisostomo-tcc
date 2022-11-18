// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_typing_uninitialized_variables, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                      String description = item['description'];
                      String category = item['category'];
                      String size = item['size'];

                      return Card(
                        color: const Color.fromRGBO(50, 62, 64, 1),
                        child: ListTile(
                          contentPadding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                          leading: const Icon(Icons.local_pizza, size: 50, color: Colors.white),
                          
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
                                '$category - $size',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              
                              Text(
                                "R\$ $price",
                                style: TextStyle(
                                  color: Colors.white,
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
                                    );
                                  },
                                  
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(2),
                                    backgroundColor: const Color.fromRGBO(242, 169, 34, 1),
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
                                    backgroundColor: const Color.fromRGBO(242, 169, 34, 1),
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
                  return Center(
                    child: Text('Nenhum produto cadastrado.'),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}