import 'package:flutter/material.dart';
import 'package:tcc/controller/postgres/Lists/sales.dart';
import 'package:tcc/model/Sales.dart';
import 'package:tcc/model/standardListDropDown.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
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
    
    if (dateStart == 'Personalizado') {
      dateStart = dateEnd = DateTime.now().toString();
    }
    
    return await SalesController.instance.getSales(cnpj, dateStart, dateEnd, buttonStatusSelected).then((value) {
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
        
            SectionVisible(
              nameSection: 'Filtrar',
              isShowPart: true,
              child: Column(
                children: [
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            buttonStatusSelected = '';
                            getSales(txtCode.text, txtDropDown, txtDateFilter.text, buttonStatusSelected).then((value) {
                              setState(() {
                                listSales = value;
                              });
                            });
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: buttonStatusSelected == '' ? globals.primary : Colors.white,
                            border: Border.all(
                              color: globals.primary.withOpacity(0.8),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.select_all, color: buttonStatusSelected == '' ? Colors.white : globals.primary.withOpacity(0.8), size: 20),
                                                
                              const SizedBox(width: 10),
                                                
                              Text('Tudo', style: TextStyle(color: buttonStatusSelected == '' ? Colors.white : globals.primary.withOpacity(0.8), fontSize: 16)),
                            ],
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            buttonStatusSelected = 'Andamento';
                            getSales(txtCode.text, txtDropDown, txtDateFilter.text, buttonStatusSelected).then((value) {
                              setState(() {
                                listSales = value;
                              });
                            });
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: buttonStatusSelected == 'Andamento' ? globals.primary : Colors.white,
                            border: Border.all(
                              color: globals.primary.withOpacity(0.8),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.timer_sharp, color: buttonStatusSelected == 'Andamento' ? Colors.white : globals.primary.withOpacity(0.8), size: 20),
                                                
                              const SizedBox(width: 10),
                                                
                              Text('Em andamento', style: TextStyle(color: buttonStatusSelected == 'Andamento' ? Colors.white : globals.primary.withOpacity(0.8), fontSize: 16)),
                            ],
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            buttonStatusSelected = 'Ativo';
                            getSales(txtCode.text, txtDropDown, txtDateFilter.text, buttonStatusSelected).then((value) {
                              setState(() {
                                listSales = value;
                              });
                            });
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: buttonStatusSelected == 'Ativo' ? globals.primary : Colors.white,
                            border: Border.all(
                              color: globals.primary.withOpacity(0.8),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle_outline, color: buttonStatusSelected == 'Ativo' ? Colors.white : globals.primary.withOpacity(0.8), size: 20),
                                                
                              const SizedBox(width: 10),
                                                
                              Text('Ativos', style: TextStyle(color: buttonStatusSelected == 'Ativo' ? Colors.white : globals.primary.withOpacity(0.8), fontSize: 16)),
                            ],
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            buttonStatusSelected = 'Finalizado';
                            getSales(txtCode.text, txtDropDown, txtDateFilter.text, buttonStatusSelected).then((value) {
                              setState(() {
                                listSales = value;
                              });
                            });
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: buttonStatusSelected == 'Finalizado' ? globals.primary : Colors.white,
                            border: Border.all(
                              color: globals.primary.withOpacity(0.8),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle, color: buttonStatusSelected == 'Finalizado' ? Colors.white : globals.primary.withOpacity(0.8), size: 20),
                                                
                              const SizedBox(width: 10),
                                                
                              Text('Finalizados', style: TextStyle(color: buttonStatusSelected == 'Finalizado' ? Colors.white : globals.primary.withOpacity(0.8), fontSize: 16)),
                            ],
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            buttonStatusSelected = 'Cancelado';
                            getSales(txtCode.text, txtDropDown, txtDateFilter.text, buttonStatusSelected).then((value) {
                              setState(() {
                                listSales = value;
                              });
                            });
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: buttonStatusSelected == 'Cancelado' ? globals.primary : Colors.white,
                            border: Border.all(
                              color: globals.primary.withOpacity(0.8),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cancel, color: buttonStatusSelected == 'Cancelado' ? Colors.white : globals.primary.withOpacity(0.8), size: 20),
                                                
                              const SizedBox(width: 10),
                                                
                              Text('Cancelados', style: TextStyle(color: buttonStatusSelected == 'Cancelado' ? Colors.white : globals.primary.withOpacity(0.8), fontSize: 16)),
                            ],
                          ),
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
                            getSales(txtCode.text, txtDropDown, txtDateFilter.text, buttonStatusSelected).then((value) {
                              setState(() {
                                listSales = value;
                              });
                            });
                          },
                        ),
                  
                        const SizedBox(height: 20),
                      ],
                    ),
                  
                  if (globals.userType != 'employee')
                    Column(
                      children: [
                        DropDown(
                          text: 'Data',
                          variavel: txtDropDown,
                          itemsDropDownButton: listDropDown,
                          callback: (value) {
                            setState(() {
                              txtDropDown = value!;
                            });

                            if (txtDropDown != 'Personalizado') {
                              getSales(txtCode.text, txtDropDown, txtDateFilter.text, buttonStatusSelected).then((value) {
                                setState(() {
                                  listSales = value;
                                });
                              });
                            }
                            
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
                                  getSales(txtCode.text, txtDropDown, value, buttonStatusSelected).then((value) {
                                    setState(() {
                                      listSales = value;
                                    });
                                  });
                                },
                              ),
                          
                              const SizedBox(height: 20),
                            ],
                          ),
                      ],
                    ),
                ],
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