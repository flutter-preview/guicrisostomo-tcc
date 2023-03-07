import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc/controller/firebase/productsCart.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenInfoOrder extends StatefulWidget {
  const ScreenInfoOrder({super.key});

  @override
  State<ScreenInfoOrder> createState() => _ScreenInfoOrderState();
}

class _ScreenInfoOrderState extends State<ScreenInfoOrder> {
  @override
  Widget build(BuildContext context) {
    var orderSelect = ModalRoute.of(context)!.settings.arguments as QueryDocumentSnapshot;

    dynamic item = orderSelect.data();
    Map<String, dynamic> map = item!;
    DateTime date = (map['date'] as Timestamp).toDate();
    num total = orderSelect['total'];
    String? id = orderSelect.id.toString();
    String textDate = DateFormat("d 'de' MMMM 'de' y 'às' HH':'mm':'ss", "pt_BR").format(date);
    
    Widget productItem() {
      return Container(
        child: (
          StreamBuilder<QuerySnapshot>(
            stream: ProductsCartController().list(id).snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Center(
                    child: Text('Não foi possível conectar.'),
                  );
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  final dados = snapshot.requireData;
                  if (dados.size > 0) {
                    return ListView.builder(
                      itemCount: dados.size,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        dynamic item = dados.docs[index].data();
                        String name = item['name'];
                        num price = item['price'];
                        String category = item['category'];
                        String size = item['size'];

                        return Card(
                          color: globals.primary,
                          child: ListTile(
                            contentPadding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                            leading: const Icon(Icons.local_pizza, size: 50, color: Colors.white),
                            
                            title: Text(
                              name,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
      
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$category - $size',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                
                                Text(
                                  'R\$ ${price.toStringAsFixed(2).replaceFirst('.', ',')}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ]
                            ),
      
                            /*trailing: Column(
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
                                        arguments: dados.docs[index],
                                      );
                                    },
                                    
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(2),
                                      backgroundColor: secundary,
                                      shape: const CircleBorder(),
                                      foregroundColor: Colors.white,
                                    ),
      
                                    child: const Icon(
                                      Icons.add, size: 15,
                                      color: Colors.white,
                                    ),
                                    
                                  ),
                                ),
                              ),
                              
                              const SizedBox(height: 10,),
                              
                              
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
                                      backgroundColor: secundary,
                                      shape: const CircleBorder(),
                                      foregroundColor: Colors.white,
                                    ),
                                    
                                    child: const Icon(Icons.question_mark, size: 15, color: Colors.white,),
                                  
                                    ),
                                  )
                                )
                              ]
                            ),
                            
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                'products/info_product',
                              );
                            },*/
                          )
                        );
                      },
                    );
                  } else {
                    return const Text('Nenhum item foi encontrado');
                  }
              }
            },
          )
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações'),
        centerTitle: true,
        backgroundColor: globals.primary,
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          
          child: Column(
            children: [
              /*Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.people_rounded, size: 30, color: Color.fromRGBO(242, 169, 34, 1)),
                  SizedBox(width: 10,),
                  Text(
                    'Atendente: José',
                  )
                ],
              ),
      
              const SizedBox(height: 5,),*/
      
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.timer_outlined, size: 30, color: Color.fromRGBO(242, 169, 34, 1)),
                  const SizedBox(width: 10,),
                  Text(
                    'Data: $textDate',
                  )
                ],
              ),
      
              const SizedBox(height: 5,),
      
              /*Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.delivery_dining, size: 30, color: Color.fromRGBO(242, 169, 34, 1)),
                  SizedBox(width: 10,),
                  Text(
                    'Tipo: entrega',
                  )
                ],
              ),
      
              const SizedBox(height: 5,),*/
      
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.attach_money, size: 30, color: Color.fromRGBO(242, 169, 34, 1)),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total: R\$ ${total.toStringAsFixed(2).replaceFirst('.', ',')}',
                      ),
      
                      /*Text(
                        'Pago em dinheiro',
                      )*/
                    ]
                  )
                ],
              ),
      
              const SizedBox(height: 10,),
      
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Itens pedidos',
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
      ),
      bottomNavigationBar: const Bottom(),
    );
  }
}