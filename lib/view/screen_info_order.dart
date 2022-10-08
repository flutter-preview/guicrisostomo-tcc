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

            productItem(),
          ]
        )
        
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}

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
          contentPadding: EdgeInsets.fromLTRB(10, 10, 20, 10),
          leading: Icon(Icons.local_pizza, size: 40, color: Colors.white),

          title: Text(
            'TENTAÇÃO',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),

          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PIZZA - GIGANTE',
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

          trailing: Container(
            child: Column(
              children: [
              
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
                      Navigator.pushNamed(
                        context,
                        'products/info_product',
                      );
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