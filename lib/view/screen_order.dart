import 'package:flutter/material.dart';

import '../modal/bottonNavigationCustomer.dart';

class ScreenOrder extends StatefulWidget {
  const ScreenOrder({super.key});

  @override
  State<ScreenOrder> createState() => _ScreenOrderState();
}

class _ScreenOrderState extends State<ScreenOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Container(
          child: Column(
            children: [
              listViewOrder(),
            ],
          )
        ),
      ),

      bottomNavigationBar: Bottom(),
    );
  }
}

listViewOrder() {
  return ListView.builder(
    itemCount: 10,
    shrinkWrap:true,
    scrollDirection: Axis.vertical,
    itemBuilder: (context, index) {
    return Card(
      color: Color.fromRGBO(50, 62, 64, 1),
      child: ListTile(

        title: Text(
          'Data: 01/12/2022 às 21:35',
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
          ),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total: R\$ 52,00',
              style: TextStyle(
                color: Colors.white,
              ),
            ),

            Text(
              'Tipo: entrega',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ]
        ),

        //EVENTO DE CLIQUE
        onTap: () {
          
        },
        
      ),
    );
      
    }
  );
}