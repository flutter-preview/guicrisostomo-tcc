// ignore_for_file: file_names

import 'package:flutter/material.dart';

productItem() {
  return (
    ListView.builder(
      itemCount: 2,
      shrinkWrap:true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
      return Card(
        color: const Color.fromRGBO(50, 62, 64, 1),
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
          leading: const Icon(Icons.local_pizza, size: 50, color: Colors.white),
          
          title: const Text(
            'TENTAÇÃO',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),

          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'PIZZA - GIGANTE',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),

              Text(
                'Pedidos as',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              
              Text(
                "R\$ 33,00",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ]
          ),

          trailing: Column(
            children: [
            
            /*
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
                  child: const Icon(Icons.add, size: 15, color: Colors.white,),
                
                ),
              ),
            ),
            
            const SizedBox(height: 10,),
            */
            
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
          //EVENTO DE CLIQUE
          onTap: () {
            Navigator.pushNamed(
              context,
              'products/info_product',
            );
          },
          
        ),
      );
    })
  );
}