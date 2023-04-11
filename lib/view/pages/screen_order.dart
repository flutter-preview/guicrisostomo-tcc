import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc/controller/mysql/Lists/sales.dart';
import 'package:tcc/main.dart';
import 'package:tcc/model/standardListDropDown.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/dropDownButton.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenOrder extends StatefulWidget {
  const ScreenOrder({super.key});

  @override
  State<ScreenOrder> createState() => _ScreenOrderState();
}

class _ScreenOrderState extends State<ScreenOrder> {
  String txtDropDown = 'Hoje';
  String buttonStatusSelected = 'Todos';
  List<DropDownList> listDropDown = [
    DropDownList(
      name: 'Hoje',
      icon: Icons.calendar_month,
    ),

    DropDownList(
      name: 'Ontem',
      icon: Icons.calendar_today,
    ),

    DropDownList(
      name: 'Últimos 7 dias',
      icon: Icons.calendar_today,
    ),

    DropDownList(
      name: 'Últimos 30 dias',
      icon: Icons.calendar_today,
    ),

    DropDownList(
      name: 'Últimos 90 dias',
      icon: Icons.calendar_today,
    ),

    DropDownList(
      name: 'Últimos 180 dias',
      icon: Icons.calendar_today,
    ),

    DropDownList(
      name: 'Últimos 365 dias',
      icon: Icons.calendar_today,
    ),

    DropDownList(
      name: 'Personalizado',
      icon: Icons.calendar_today,
    ),
    
  ];
  var txtDateFilter = TextEditingController();
  var txtCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        pageName: 'Pedidos',
        context: context,
        svg: 'lib/images/iconOrder.svg',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            SectionVisible(
              nameSection: 'Pedidos',
              isShowPart: true,
              child: Column(
                children: [

                  SectionVisible(
                    nameSection: 'Filtrar', 
                    child: Column(
                      children: [
                        Column(
                          children: [
                            StatefulBuilder(
                              builder: (context, setState) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    button('Todos', 0, 0, null, () => {
                                      setState(() {
                                        buttonStatusSelected = 'Todos';
                                      })
                                    }, true, 16, buttonStatusSelected == 'Todos' ? globals.primaryBlack : globals.primary.withOpacity(0.8)),
                                    button('Em andamento', 0, 0, null, () => {
                                      setState(() {
                                        buttonStatusSelected = 'Em andamento';
                                      })
                                    }, true, 16, buttonStatusSelected == 'Em andamento' ? globals.primaryBlack : globals.primary.withOpacity(0.8)),
                                    button('Finalizados', 0, 0, null, () => {
                                      setState(() {
                                        buttonStatusSelected = 'Finalizados';
                                      })
                                    }, true, 16, buttonStatusSelected == 'Finalizados' ? globals.primaryBlack : globals.primary.withOpacity(0.8)),
                              
                                  ],
                                );
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        if (globals.userType != 'customer')
                          Column(
                            children: [
                              TextFieldGeneral(
                                label: 'Código do pedido',
                                variavel: txtCode,
                                context: context,
                                keyboardType: TextInputType.number,
                                ico: Icons.numbers,
                              ),

                              const SizedBox(height: 20),
                            ],
                          ),

                        if (globals.userType != 'employee')
                          StatefulBuilder(
                            builder: (context, setState) {
                              return Column(
                                children: [
                                  DropDown(
                                    text: 'Data',
                                    variavel: txtDropDown,
                                    itemsDropDownButton: listDropDown,
                                    callback: (value) {
                                      setState(() {
                                        txtDropDown = value;
                                      });
                                    },
                                  ),

                                  const SizedBox(height: 20),

                                  if (txtDropDown == 'Personalizado')
                                    Column(
                                      children: [
                                        TextFieldGeneral(
                                          label: 'Data',
                                          variavel: txtDateFilter,
                                          context: context,
                                          keyboardType: TextInputType.datetime,
                                          ico: Icons.date_range,
                                        ),

                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                ],
                              );
                            },
                          ),
                      ],
                    ),
                  ),

                  listViewOrder(),
                ],
              )
            )
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
      
    );
  }
}

listViewOrder() {

  return Container(
    child: (
      StreamBuilder<QuerySnapshot>(
        stream: SalesController().listSalesFinalize(),
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
                    Map<String, dynamic> map = item!;
                    DateTime date = (map['date'] as Timestamp).toDate();
                    String dateText = DateFormat("d 'de' MMMM 'de' y 'às' HH':'mm':'ss", "pt_BR").format(date);
                    num total = item['total'];
  
                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        
                        title: Text(
                          'Data: $dateText',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),

                            Text(
                              'Total: R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),

                            /*Text(
                              'Tipo: entrega',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),*/
                          ]
                        ),

                        //EVENTO DE CLIQUE
                        onTap: ()  {
                          // print('Clicou no item ${dados.docs[index]}');
                          Navigator.push(
                            context,
                            // 'order/info',
                            navigator('order/info', dados.docs[index])

                          //   //Passagem de parâmetro
                            // arguments: dados.docs[index],

                          );
                        },
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