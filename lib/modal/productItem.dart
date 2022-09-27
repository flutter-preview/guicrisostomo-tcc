import 'package:flutter/material.dart';

productItem() {
  return (
    ListView.builder(
      itemCount: 2,
      shrinkWrap:true,
      scrollDirection: Axis.vertical,
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
              ],
            )
            
          ),

          trailing: Container(
            child: Column(
              children: [
              
              Expanded(
              child: SizedBox(
                width: 25,
                height: 25,
                child: ElevatedButton(
                    
                    onPressed: () {
                    
                    },
                    
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(2),
                      backgroundColor: Color.fromRGBO(242, 169, 34, 1),
                      shape: CircleBorder(),
                      primary: Colors.white,
                    ),
                    child: Icon(Icons.add, size: 15, color: Colors.white,),
                  
                  ),
                ),
              ),
              
              SizedBox(height: 10,),

              Expanded(
                child: SizedBox(
                  width: 25,
                  height: 25,
                  
                  child: ElevatedButton(
                    
                    
                    onPressed: () {
                    
                    },
                    
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(2),
                      backgroundColor: Color.fromRGBO(242, 169, 34, 1),
                      shape: CircleBorder(),
                      primary: Colors.white,
                    ),
                    
                    child: Icon(Icons.question_mark, size: 15, color: Colors.white,),
                  
                    ),
                  )
                )
              ]
            )
          ),
          //EVENTO DE CLIQUE
          onTap: () {
            
          },
          
        ),
      );
    })
  );
}