import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/model/standardListDropDown.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/customer/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/dropDownButton.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/view/widget/switchListTile.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenHomeManager extends StatefulWidget {
  const ScreenHomeManager({super.key});

  @override
  State<ScreenHomeManager> createState() => _ScreenHomeManagerState();
}

class _ScreenHomeManagerState extends State<ScreenHomeManager> {
  String lucro = '0,00';
  bool valueShowMoney = false;
  bool valueOpen = false;
  String selectedData = 'Hoje';
  TextEditingController txtDateFilter = TextEditingController();

  List<DropDownList> listData = [
    DropDownList(name: 'Hoje', icon: Icons.today),
    DropDownList(name: 'Esta semana', icon: Icons.calendar_today),
    DropDownList(name: 'Este mês', icon: Icons.calendar_today),
    DropDownList(name: 'Este ano', icon: Icons.calendar_today),
    DropDownList(name: 'Personalizado', icon: Icons.calendar_today_rounded)
  ];

  @override
  Widget build(BuildContext context) {
    setState(() {
      globals.userType = 'admin';
    });

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(250),

        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            appBarWidget(
              pageName: 'Home',
              context: context,
              icon: Icons.home,
            ),

            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    globals.primaryBlack,
                    globals.primary.withOpacity(0.9),
                  ]
                ),
              ),
              child: Column(
                children: [
                  Text(
                    (valueShowMoney == true) ?
                      'R\$ $lucro' : 'R\$ *,**',

                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  SwitchListTileWidget(
                    title: const Text(
                      'Visualizar lucro do dia ?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    value: valueShowMoney,
                    onChanged: (value) {
                      setState(() {
                        valueShowMoney = !valueShowMoney;
                        value = valueShowMoney;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  SwitchListTileWidget(
                    title: Text(
                      'Aberto ?',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    value: valueOpen,
                    onChanged: (value) {
                      setState(() {
                        valueOpen = !valueOpen;
                        value = valueOpen;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SectionVisible(
                nameSection: 'Funcionários ativos',
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.person, color: globals.primary, size: 30,),
                        title: const Text('Nome do funcionário'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Cargo'),
                            const Text('Pedidos hoje: 0'),
                            const Text('Avaliação: 0'),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.person, color: globals.primary, size: 30,),
                        title: const Text('Nome do funcionário'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Cargo'),
                            const Text('Pedidos hoje: 0'),
                            const Text('Avaliação: 0'),
                          ],
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, color: globals.primary),
                      ),
                    ),
                  ],
                )
              ),

              const SizedBox(height: 20),

              SectionVisible(
                nameSection: 'Informações de lucro',
                isShowPart: true,
                child: Column(
                  children: [
                    
                    DropDown(
                      text: 'Clique aqui para selecionar um período',
                      itemsDropDownButton: listData,
                      variavel: selectedData,
                      callback: (value) {
                        setState(() {
                          selectedData = value;
                        });
                      },
                    ),

                    (selectedData == 'Personalizado') ?
                      Column(
                        children: [
                          const SizedBox(height: 10),

                          TextFieldGeneral(
                            label: 'Data',
                            variavel: txtDateFilter,
                            context: context,
                            keyboardType: TextInputType.datetime,
                            ico: Icons.date_range,
                          ),

                        ],
                      ) : const SizedBox(height: 0),

                    const SizedBox(height: 20),

                    Card(
                      child: ListTile(
                        leading: Icon(Icons.attach_money, color: globals.primary, size: 30,),
                        title: Text('Lucro total do(e) ${selectedData.toLowerCase()}'),
                        subtitle: const Text('R\$ 0,00'),
                        trailing: Icon(Icons.arrow_forward_ios, color: globals.primary),
                      ),
                    ),
                    
                    SectionVisible(
                      nameSection: 'Tipos de venda',
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                              leading: Icon(Icons.delivery_dining_outlined, color: globals.primary, size: 30,),
                              title: const Text('Lucro entrega'),
                              subtitle: const Text('R\$ 0,00'),
                              trailing: Icon(Icons.arrow_forward_ios, color: globals.primary),
                            ),
                          ),

                          Card(
                            child: ListTile(
                              leading: Icon(Icons.local_dining, color: globals.primary, size: 30,),
                              title: const Text('Lucro retirada'),
                              subtitle: const Text('R\$ 0,00'),
                              trailing: Icon(Icons.arrow_forward_ios, color: globals.primary),
                            ),
                          ),

                          Card(
                            child: ListTile(
                              leading: Icon(Icons.table_restaurant, color: globals.primary, size: 30,),
                              title: const Text('Lucro mesa'),
                              subtitle: const Text('R\$ 0,00'),
                              trailing: Icon(Icons.arrow_forward_ios, color: globals.primary),
                            ),
                          ),
                        ],
                      )
                    ),

                    const SizedBox(height: 20),

                    SectionVisible(
                      nameSection: 'Formas de pagamento',
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                              leading: Icon(Icons.credit_card, color: globals.primary, size: 30,),
                              title: const Text('Lucro cartão'),
                              subtitle: const Text('R\$ 0,00'),
                              trailing: Icon(Icons.arrow_forward_ios, color: globals.primary),
                            ),
                          ),

                          Card(
                            child: ListTile(
                              leading: Icon(Icons.money, color: globals.primary, size: 30,),
                              title: const Text('Lucro dinheiro'),
                              subtitle: const Text('R\$ 0,00'),
                              trailing: Icon(Icons.arrow_forward_ios, color: globals.primary),
                            ),
                          ),

                          Card(
                            child: ListTile(
                              leading: Icon(Icons.pix_outlined, color: globals.primary, size: 30,),
                              title: const Text('Lucro pix'),
                              subtitle: const Text('R\$ 0,00'),
                              trailing: Icon(Icons.arrow_forward_ios, color: globals.primary),
                            ),
                          ),
                        ]
                      )
                    ),
                    
                  ],
                )
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const BottomCustomer(),
    );
  }
}