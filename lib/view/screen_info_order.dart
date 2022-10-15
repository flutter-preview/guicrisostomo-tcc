import 'package:flutter/material.dart';

import '../widget/bottonNavigationCustomer.dart';

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
        title: const Text('Informações'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(50, 62, 64, 1),
      ),

      body: Container(
        padding: const EdgeInsets.all(20),
        
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.people_rounded, size: 30, color: Color.fromRGBO(242, 169, 34, 1)),
                SizedBox(width: 10,),
                Text(
                  'Atendente: José',
                )
              ],
            ),

            const SizedBox(height: 5,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.timer_outlined, size: 30, color: Color.fromRGBO(242, 169, 34, 1)),
                SizedBox(width: 10,),
                Text(
                  '01/12/2022 às 21:51',
                )
              ],
            ),

            const SizedBox(height: 5,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.delivery_dining, size: 30, color: Color.fromRGBO(242, 169, 34, 1)),
                SizedBox(width: 10,),
                Text(
                  'Tipo: entrega',
                )
              ],
            ),

            const SizedBox(height: 5,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.attach_money, size: 30, color: Color.fromRGBO(242, 169, 34, 1)),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
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

            const SizedBox(height: 10,),

            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
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
      bottomNavigationBar: const Bottom(),
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
        color: const Color.fromRGBO(50, 62, 64, 1),
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
          leading: const Icon(Icons.local_pizza, size: 40, color: Colors.white),

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