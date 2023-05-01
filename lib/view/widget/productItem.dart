// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_typing_uninitialized_variables, file_names

import 'package:flutter/material.dart';
import 'package:tcc/controller/postgres/Lists/productsCart.dart';
import 'package:tcc/controller/postgres/Lists/sales.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/main.dart';
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/model/Variation.dart';
import 'package:tcc/view/widget/snackBars.dart';

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
        Column(
          children: [
            Text(
              'Clique no item para saber mais sobre o produto',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black45,
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
                String? linkImage = dados.link_image;
            
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
            
                    trailing: ElevatedButton(
                        
                      onPressed: () async {
                        // Navigator.pushNamed(
                        //   context,
                        //   'products/add_product',
                        //   arguments: dados.docs[index],
                        // );
                        Navigator.push(context, navigator('products/add_product', item));
                        return await SalesController().idSale().then((idOrder) async {
                          return await ProductsCartController().getVariationItem(idOrder).then((value) {
                            if (item.variation?.id != value && value != 0) {
                              error(context, 'Não é possível adicionar produtos de variações diferentes no mesmo item');
                              Navigator.pop(context);
                              return;
                            }
                          });
                        });
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
                    
                    onTap: () {
                      Navigator.push(
                        context,
                        navigator('products/info_product', item),
                      );
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