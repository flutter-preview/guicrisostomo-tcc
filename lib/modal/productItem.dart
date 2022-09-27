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
              )],
            )
            
          ),

          trailing: Column(
            children: [
              
              
              SizedBox(height: 0,),
              ElevatedButton(
                //constraints: BoxConstraints(maxWidth: 20, maxHeight: 20),
                onPressed: () {
                
                },
                
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(8, 8),
                  backgroundColor: Color.fromRGBO(242, 169, 34, 1),
                  shape: CircleBorder(),
                  primary: Colors.white,
                ),
                
                child: Icon(Icons.add, size: 5, color: Colors.white,),
                
              ),
              
              ElevatedButton(
                //constraints: BoxConstraints(maxWidth: 20, maxHeight: 20),
                onPressed: () {
                
                },
                
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(242, 169, 34, 1),
                  shape: CircleBorder(),
                  primary: Colors.white,
                  fixedSize: const Size(8, 8),
                ),
                
                child: Icon(Icons.question_mark, size: 5, color: Colors.white,),
                
              ),
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