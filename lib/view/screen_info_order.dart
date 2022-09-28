import 'package:flutter/material.dart';

import '../modal/bottonNavigationCustomer.dart';

class ScreenInfoOrder extends StatefulWidget {
  const ScreenInfoOrder({super.key});

  @override
  State<ScreenInfoOrder> createState() => _ScreenInfoOrderState();
}

class _ScreenInfoOrderState extends State<ScreenInfoOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(50, 62, 64, 1),
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.people_rounded, size: 30, color: Color.fromRGBO(242, 169, 34, 1)),
                SizedBox(width: 10,),
                Text(
                  'Atendente: José',
                )
              ],
            ),

            SizedBox(height: 5,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.timer_outlined, size: 30, color: Color.fromRGBO(242, 169, 34, 1)),
                SizedBox(width: 10,),
                Text(
                  '01/12/2022 às 21:51',
                )
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.delivery_dining, size: 30, color: Color.fromRGBO(242, 169, 34, 1)),
                SizedBox(width: 10,),
                Text(
                  'Tipo: entrega',
                )
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.attach_money, size: 30, color: Color.fromRGBO(242, 169, 34, 1)),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total: R\$ 51,00',
                    ),

                    Text(
                      'Pago em dinheiro',
                    )
                  ]
                )
              ],
            ),

            SizedBox(height: 10,),

            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Itens pedidos hoje',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              )
            ),

            
          ]
        )
        
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}