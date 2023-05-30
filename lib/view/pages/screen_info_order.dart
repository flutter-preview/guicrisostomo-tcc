import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc/controller/auth/auth.dart';
import 'package:tcc/controller/postgres/Lists/productsCart.dart';
import 'package:tcc/model/Address.dart';
import 'package:tcc/model/ProductsCart.dart';
import 'package:tcc/model/Sales.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/listCart.dart';
import 'package:tcc/view/widget/sectionVisible.dart';

class ScreenInfoOrder extends StatefulWidget {
  final Object? arguments;

  const ScreenInfoOrder({
    super.key,
    this.arguments,
  });

  @override
  State<ScreenInfoOrder> createState() => _ScreenInfoOrderState();
}

class _ScreenInfoOrderState extends State<ScreenInfoOrder> {
  List<ProductsCartList> list = [];

  Sales orderSelect = Sales(id: 0, uid: '0', cnpj: '0', status: '', date: DateTime.now());

  num total = 0;
  int id = 0;
  DateTime date = DateTime.now();
  String textDate = '';
  
  @override
  void initState() {
    super.initState();

    setState(() {
      orderSelect = widget.arguments as Sales;

      date = orderSelect.date;
      total = orderSelect.total;
      id = orderSelect.id;
      textDate = DateFormat("d 'de' MMMM 'de' y 'às' HH':'mm':'ss", "pt_BR").format(date);
    });
    
    
    getList().then((value) {
      setState(() {
        list = value;
      });
    });
  }
  
  Future<List<ProductsCartList>> getList() async {
    return await ProductsCartController.instance.list(orderSelect.id).then((value) {
      return value;
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<Address> getAddress() async {
    return await LoginController.instance.getAddressId(orderSelect.addressId!).then((value) {
      return value;
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          context: context,
          pageName: 'Pedido $id',
          withoutIcons: true,
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle_outline, size: 30, color: globals.primary),
                  const SizedBox(width: 10,),
                  Text(
                    'Status: ${orderSelect.status}',
                  )
                ],
              ),

              const SizedBox(height: 10,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.delivery_dining, size: 30, color: globals.primary),
                  const SizedBox(width: 10,),
                  Text(
                    'Tipo da venda: ${orderSelect.type}',
                  )
                ],
              ),

              const SizedBox(height: 10,),

              Row(
                children: [
                  Icon(Icons.credit_card_sharp, size: 30, color: globals.primary),
                  const SizedBox(width: 10,),
                  Text(
                    'Forma de pagamento: ${orderSelect.payment}',
                  )
                ],
              ),

              if (orderSelect.type == 'Mesa')
                Column(
                  children: [
                    const SizedBox(height: 10,),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.people_rounded, size: 30, color: globals.primary),
                        const SizedBox(width: 10,),
                        Text(
                          'Mesa: ${orderSelect.table}',
                        )
                      ],
                    ),
                  ],
                ),

              const SizedBox(height: 10,),

              if (orderSelect.type == 'Entrega')
                Column(
                  children: [
                    const SizedBox(height: 10,),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, size: 30, color: globals.primary),
                        const SizedBox(width: 10,),
                        FutureBuilder(
                          future: getAddress(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                              return Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Endereço: ${snapshot.data!.street}, ${snapshot.data!.number} - ${snapshot.data!.district}, ${snapshot.data!.city ?? 'cidade não informada'} - ${snapshot.data!.state ?? 'estado não informado'}',
                                    ),
                              
                                    const SizedBox(height: 10,),
                              
                                    Text(
                                      'Referência: ${snapshot.data!.reference ?? 'vazio'}',
                                      style: const TextStyle(
                                        color: Colors.black54
                                      )
                                    ),
                              
                                    const SizedBox(height: 10,),
                              
                                    Text(
                                      'Complemento: ${snapshot.data!.complement ?? 'vazio'}',
                                      style: const TextStyle(
                                        color: Colors.black54
                                      )
                                    ),
                              
                                  ],
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }
                        )
                      ],
                    ),
                  ],
                ),

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
      
              const SizedBox(height: 10,),*/
              const SizedBox(height: 10,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.timer_outlined, size: 30, color: globals.primary),
                  const SizedBox(width: 10,),
                  Text(
                    'Data: $textDate',
                  )
                ],
              ),
      
              const SizedBox(height: 10,),
      
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
      
              const SizedBox(height: 10,),*/
      
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.attach_money, size: 30, color: globals.primary),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total: R\$ ${total.toStringAsFixed(2).replaceFirst('.', ',')}',
                      ),

                      const SizedBox(height: 5,),

                      if (orderSelect.payment != null)
                        Text(
                          'Pago em ${orderSelect.payment}',
                        )
                    ]
                  )
                ],
              ),
      
              const SizedBox(height: 20,),
      
              SectionVisible(
                nameSection: 'Itens do pedido',
                isShowPart: true,
                child: FutureBuilder(
                  future: getList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ProductsCart(
                        product: list,
                        isShowButtonDelete: false,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                ),
              )
      
              // productItem(),
            ]
          )
          
        ),
      ),
      bottomNavigationBar: const Bottom(),
    );
  }
}