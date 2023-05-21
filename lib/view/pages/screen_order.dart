import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc/controller/postgres/Lists/sales.dart';
import 'package:tcc/main.dart';
import 'package:tcc/model/Sales.dart';
import 'package:tcc/model/standardListDropDown.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/dropDownButton.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/listViewOrder.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenOrder extends StatefulWidget {
  const ScreenOrder({super.key});

  @override
  State<ScreenOrder> createState() => _ScreenOrderState();
}

class _ScreenOrderState extends State<ScreenOrder> {
  String txtDropDown = 'Hoje';
  String buttonStatusSelected = '';

  var formKeyDate = GlobalKey<FormState>();

  List<DropDownList> listDropDown = [
    DropDownList(
      name: 'Todos',
      icon: Icons.calendar_today,
    ),
    
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
  var txtCode = TextEditingController(
    text: globals.businessId
  );

  List<Sales> listSales = [];

  Future<List<Sales>> getSales(String cnpj, String dateStart, String dateEnd, String buttonStatusSelected) async {

    if (formKeyDate.currentState != null) {
      if (!formKeyDate.currentState!.validate()) {
        return [];
      }
      
    } else {
      return [];
    }
    
    return await SalesController().getSales(cnpj, dateStart, dateEnd, buttonStatusSelected).then((value) {
      listSales = value;
      return value;
    });
  }

  @override
  void initState() {
    super.initState();
    getSales(txtCode.text, txtDropDown, txtDateFilter.text, buttonStatusSelected).then((value) {
      setState(() {
        listSales = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: 'Pedidos',
          context: context,
          svg: 'lib/images/iconOrder.svg',
        ),
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
        
            Form(
              key: formKeyDate,
              child: SectionVisible(
                nameSection: 'Filtrar',
                isShowPart: true,
                child: Column(
                  children: [
                    Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Wrap(
                            spacing: 10,
                    
                            children: [
                              button('Todos', 0, 0, null, () => {
                                setState(() {
                                  buttonStatusSelected = '';
                                  getSales(txtCode.text, txtDropDown, txtDateFilter.text, buttonStatusSelected).then((value) {
                                    setState(() {
                                      listSales = value;
                                    });
                                  });
                                })
                              }, true, 16, buttonStatusSelected == '' ? globals.primaryBlack : globals.primary.withOpacity(0.8)),
                              button('Em andamento', 0, 0, null, () => {
                                setState(() {
                                  buttonStatusSelected = 'ANDAMENTO';
                                  getSales(txtCode.text, txtDropDown, txtDateFilter.text, buttonStatusSelected).then((value) {
                                    setState(() {
                                      listSales = value;
                                    });
                                  });
                                })
                              }, true, 16, buttonStatusSelected == 'ANDAMENTO' ? globals.primaryBlack : globals.primary.withOpacity(0.8)),
                              button('Finalizados', 0, 0, null, () => {
                                setState(() {
                                  buttonStatusSelected = 'FINALIZADO';
                                  getSales(txtCode.text, txtDropDown, txtDateFilter.text, buttonStatusSelected).then((value) {
                                    setState(() {
                                      listSales = value;
                                    });
                                  });
                                })
                              }, true, 16, buttonStatusSelected == 'FINALIZADO' ? globals.primaryBlack : globals.primary.withOpacity(0.8)),
                              button('Cancelados', 0, 0, null, () => {
                                setState(() {
                                  buttonStatusSelected = 'CANCELADO';
                                  getSales(txtCode.text, txtDropDown, txtDateFilter.text, buttonStatusSelected).then((value) {
                                    setState(() {
                                      listSales = value;
                                    });
                                  });
                                })
                              }, true, 16, buttonStatusSelected == 'CANCELADO' ? globals.primaryBlack : globals.primary.withOpacity(0.8)
                              ),
                            ],
                          ),
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
                            onChanged: (p0) {
                              getSales(txtCode.text, txtDropDown, txtDateFilter.text, buttonStatusSelected);
                            },
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
                                    txtDropDown = value!;
            
                                    if (txtDropDown != 'Personalizado') {
                                      getSales(txtCode.text, txtDropDown, txtDateFilter.text, buttonStatusSelected).then((value) {
                                        setState(() {
                                          listSales = value;
                                        });
                                      });
                                    }
            
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
                                      keyboardType: TextInputType.datetime,
                                      ico: Icons.date_range,
                                      onChanged: (value) {
                                        setState(() {
                                          getSales(txtCode.text, txtDropDown, value, buttonStatusSelected).then((value) {
                                            setState(() {
                                              listSales = value;
                                            });
                                          });
                                        });
                                      },
                                      validator: (value) {
                                        return validatorString(value);
                                      },
                                    ),
                                
                                    const SizedBox(height: 20),
                                  ],
                                ),
                            ],
                          );
                        }
                      ),
                  ],
                ),
              ),
            ),
        
            FutureBuilder(
              initialData: listSales,
              future: getSales(txtCode.text, txtDropDown, txtDateFilter.text, buttonStatusSelected),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return listViewOrder(listSales);
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro ao carregar os dados: ${snapshot.error}'),
                  );
                } else {
                  return const Center(
                    child: Text('Nenhum pedido encontrado'),
                  );
                }
              },
            )
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
      
    );
  }
}