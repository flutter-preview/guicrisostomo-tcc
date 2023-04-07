// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_typing_uninitialized_variables, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/main.dart';
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/view/pages/screen_add.dart';

class ProductItem extends StatefulWidget {
  List<ProductItemList> product;

  ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return (
      
          (widget.product.isNotEmpty) ?
            ListView.builder(
              itemCount: widget.product.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                ProductItemList dados = widget.product[index];
                dynamic item = dados;
                int idItem = dados.id;
                String name = dados.name;
                num price = dados.price;
                String description = dados.description;
                String category = dados.category;
                String size = dados.size;
                String? linkImage = dados.link_image;

                return Card(
                  color: Colors.white,
                  child: ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                    leading: (linkImage != null) ? Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            linkImage,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ) : null,
                    
                    title: Text(
                      name,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
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
                          'R\$ ${price.toStringAsFixed(2).replaceFirst('.', ',')}',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )
                      ]
                    ),

                    trailing: Wrap(
                      direction: Axis.horizontal,
                      spacing: 20,
                      children: [
                      
                      
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: ElevatedButton(
                            
                          onPressed: () {
                            // Navigator.pushNamed(
                            //   context,
                            //   'products/add_product',
                            //   arguments: dados.docs[index],
                            // );

                            Navigator.push(context, navigator('products/add_product', item));
                          },
                          
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(2),
                            backgroundColor: globals.primary,
                            shape: const CircleBorder(),
                            foregroundColor: Colors.white,
                          ),

                          child: const Icon(
                            Icons.add, size: 20,
                            color: Colors.white,
                          ),
                          
                        ),
                      ),
                      
                      
                      SizedBox(
                        width: 30,
                        height: 30,
                        
                        child: ElevatedButton(
                          
                          
                          onPressed: () {
                            Navigator.push(
                              context,
                              navigator('products/info_product'),
                            );
                          },
                          
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(2),
                            backgroundColor: globals.primary,
                            shape: const CircleBorder(),
                            foregroundColor: Colors.white,
                          ),
                          
                          child: const Icon(Icons.question_mark, size: 20, color: Colors.white,),
                        
                          ),
                        )
                      ]
                    ),
                    
                    onTap: () {
                      Navigator.push(
                        context,
                        navigator('products/info_product'),
                      );
                    },
                  )
                );
              },
            )
          :
            Text('Nenhum item foi encontrado')
          
        
      );
  }
}