// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_typing_uninitialized_variables, file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcc/controller/postgres/Lists/products.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/model/Variation.dart';
import 'package:tcc/view/widget/snackBars.dart';

class ProductItem extends StatefulWidget {
  final List<ProductItemList> product;

  const ProductItem({
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
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                children: const [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Colors.black45,
                  ),
                        
                  SizedBox(width: 5,),
                        
                  Flexible(
                    child: Text(
                      'Clique no item para saber mais sobre o produto',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10,),

            ListView.builder(
              itemCount: widget.product.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                ProductItemList dados = widget.product[index];
                ProductItemList item = dados;
                int idItem = dados.id;
                String name = dados.name;
                num price = dados.price;
                String description = dados.description ?? '';
                Variation variation = dados.variation!;
                String? linkImage = dados.linkImage;
                bool isFavorite = dados.isFavorite;    
            
                return Card(
                  color: Colors.white,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: (linkImage != null) ? Container(
                      width: 50,
                      height: 50,
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
                      name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
            
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children: [
                        Text(
                          '${variation.category} - ${variation.size}',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
        
                        const SizedBox(height: 5,),
        
                        Text(
                          description,
                          style: TextStyle(
                            color: Colors.black54,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
            
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                            
                          onPressed: () async {
                            // Navigator.pushNamed(
                            //   context,
                            //   'products/add_product',
                            //   arguments: dados.docs[index],
                            // );

                            GoRouter.of(context).go('products/add_product', extra: item);
                            GoRouter.of(context).go('loading');
                          },
                          
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            backgroundColor: globals.primary,
                            foregroundColor: Colors.white,
                          ),
            
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add, size: 20,
                                  color: Colors.white,
                                ),
        
                                const SizedBox(width: 5,),
        
                                Text(
                                  'R\$ ${price.toStringAsFixed(2).replaceFirst('.', ',')}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                        ),

                        IconButton(
                          onPressed: () async {
                            setState(() {
                              item.isFavorite = !item.isFavorite;
                            });
                            await ProductsController().setProductFavorite(idItem, isFavorite).then((value) {
                              success(context, 'Produto ${item.isFavorite ? 'adicionado' : 'removido'} dos favoritos com sucesso!');
                            });
                          }, 
                          icon: item.isFavorite ? 
                            Icon(Icons.favorite, color: Colors.red,) 
                            : Icon(Icons.favorite_border, color: Colors.red,)
                        )
                      ],
                    ),
                    
                    onTap: () {
                      GoRouter.of(context).go('products', extra: item);
                    },
                  )
                );
              },
            ),
          ],
        )
      :
        Text('Nenhum item foi encontrado')
      
    
      );
  }
}