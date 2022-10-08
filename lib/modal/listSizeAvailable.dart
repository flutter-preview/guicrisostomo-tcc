import 'package:flutter/material.dart';

listSize(nameSize) {
  return (
    ListView.builder(
      itemCount: 1,
      shrinkWrap:true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
      return Card(
        color: Color.fromRGBO(50, 62, 64, 1),
        child: ListTile(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
          leading: Icon(Icons.local_pizza, size: 50, color: Colors.white),
          
          title: Text(
            nameSize,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),

          trailing: SizedBox(
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
                padding: EdgeInsets.all(2),
                backgroundColor: Color.fromRGBO(242, 169, 34, 1),
                shape: CircleBorder(),
                primary: Colors.white,
              ),
              child: Icon(Icons.add, size: 15, color: Colors.white,),
            )
          ),
        ),
      );
    })
  );
}