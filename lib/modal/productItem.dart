import 'package:flutter/material.dart';

productItem() {
  return (
    ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
      return Card(
        color: Color.fromRGBO(50, 62, 64, 1),
        child: ListTile(

          leading: Icon(Icons.public, size: 20, color: Colors.white),

          title: Text(
            'TENTAÇÃO',
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
          ),

          subtitle: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
              Text(
                'PIZZA - GIGANTE',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),

              Text(
                'PIZZA - GIGANTE',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ]
            )
            
          ),

          trailing: Column(
            children: [
              Icon(Icons.add_circle, size: 20, color: Colors.white),
              Icon(Icons.help, size: 20, color: Colors.white),
            ]
          ),
          //EVENTO DE CLIQUE
          onTap: () {
            
          },
          
        ),
      );
    })
  );
}