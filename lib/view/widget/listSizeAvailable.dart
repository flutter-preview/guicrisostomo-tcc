// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/model/ProductItemList.dart';

Widget listSize(List<ProductItemList> list) {
  return (
    ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
            leading: Icon(Icons.local_pizza, size: 50, color: globals.primary),
            
            title: Text(
              list[index].variation!.size,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
  
            trailing: ElevatedButton(
                
              onPressed: () {
                GoRouter.of(context).pop();
                GoRouter.of(context).go('products/add_product', extra: list[index]);
                GoRouter.of(context).go('loading');
              },
              
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                backgroundColor: globals.primary,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add, size: 15, color: Colors.white,),
                  Text(
                    'R\$ ${list[index].price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
            
          ),
        );
      }
    )
  );
}