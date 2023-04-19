import 'package:flutter/material.dart';
import 'package:tcc/main.dart';
import 'package:tcc/model/standardListDropDown.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/dropDownButton.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenInfoEmployee extends StatefulWidget {
  final String? id;
  const ScreenInfoEmployee({
    super.key,
    required this.id,
  });

  @override
  State<ScreenInfoEmployee> createState() => _ScreenInfoEmployeeState();
}

class _ScreenInfoEmployeeState extends State<ScreenInfoEmployee> {

  List<DropDownList> listData = [
    DropDownList(
      name: 'Hoje',
      icon: Icons.calendar_today
    ),

    DropDownList(
      name: 'Últimos 7 dias',
      icon: Icons.calendar_today
    ),

    DropDownList(
      name: 'Últimos 30 dias',
      icon: Icons.calendar_today
    ),

    DropDownList(
      name: 'Últimos 180 dias',
      icon: Icons.calendar_today
    ),

    DropDownList(
      name: 'Últimos 365 dias',
      icon: Icons.calendar_today
    ),

    DropDownList(
      name: 'Personalizado',
      icon: Icons.calendar_today
    ),
  ];

  String dataSelected = 'Hoje';
  TextEditingController txtData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        pageName: 'Informações do funcionário',
        context: context,
        withoutIcons: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Row(
              children: [
                Icon(Icons.person, color: globals.primary, size: 50,),
                const SizedBox(width: 10),
                const Text(
                  'Nome: ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),

            const SizedBox(height: 10),

            button('Excluir funcionário', MediaQuery.of(context).size.width * 0.8, 70, Icons.delete, () => null),
            
            const SizedBox(height: 10),

            SectionVisible(
              nameSection: 'Mais configurações do funcionário', 
              child: Column(
                children: [
                  button('Editar permissões', MediaQuery.of(context).size.width * 0.8, 70, Icons.local_police, () => Navigator.push(context, navigator('permissions', widget.id))),

                  const SizedBox(height: 10),

                  button('Editar smartphones autorizados', MediaQuery.of(context).size.width * 0.8, 70, Icons.smartphone, () => Navigator.push(context, navigator('employee/smartphone', widget.id))),
                  
                  const SizedBox(height: 10),
                  
                  button('Editar horário de trabalho', MediaQuery.of(context).size.width * 0.8, 70, Icons.work, () => Navigator.push(context, navigator('employee/work_time', widget.id))),
                ],
              )
            ),

            const SizedBox(height: 30),

            SectionVisible(
              nameSection: 'Informações importantes',
              child: Column(
                children: [

                  button('Editar informações', MediaQuery.of(context).size.width * 0.8, 70, Icons.edit, () => null),

                  Row(
                    children: [
                      Icon(Icons.email, color: globals.primary, size: 30,),
                      const SizedBox(width: 10),
                      const Text(
                        'Email: ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Icon(Icons.phone, color: globals.primary, size: 30,),
                      const SizedBox(width: 10),
                      const Text(
                        'Telefone: ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Icon(Icons.money, color: globals.primary, size: 30,),
                      const SizedBox(width: 10),
                      const Text(
                        'Salário: ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: globals.primary, size: 30,),
                      const SizedBox(width: 10),
                      const Text(
                        'Data de admissão: ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ],
              )
            ),

            const SizedBox(height: 20),

            SectionVisible(
              nameSection: 'Desempenho',
              child: Column(
                children: [
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        children: [
                          DropDown(
                            text: 'Selecione um período',
                            itemsDropDownButton: listData,
                            variavel: dataSelected,
                            callback: (value) {
                              setState(() {
                                dataSelected = value!;
                              });
                            },
                          ),

                          const SizedBox(height: 20),

                          (dataSelected == 'Personalizado') ? TextFieldGeneral(
                            label: 'Data',
                            variavel: txtData,
                            context: context,
                            keyboardType: TextInputType.datetime,
                            ico: Icons.date_range,
                          ) : const SizedBox(),
                        ],
                      );
                    }
                  ),

                  Row(
                    children: [
                      Icon(Icons.star, color: globals.primary, size: 30,),
                      const SizedBox(width: 10),
                      const Text(
                        'Avaliação: ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Icon(Icons.shopping_cart, color: globals.primary, size: 30,),
                      const SizedBox(width: 10),
                      const Text(
                        'Pedidos efetuados: ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Icon(Icons.attach_money, color: globals.primary, size: 30,),
                      const SizedBox(width: 10),
                      const Text(
                        'Valor total dos pedidos: ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ],
              )
            ),
            
            const SizedBox(height: 20),

            SectionVisible(
              nameSection: 'Avaliações',
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Avaliação 1'),
                    subtitle: const Text('Avaliação feita em 01/01/2021'),
                    trailing: Icon(Icons.star, color: globals.primary,),
                  ),
                ],
              )
            ),

            const SizedBox(height: 20),

            SectionVisible(
              nameSection: 'Smartphones cadastrados',
              child: Column(
                children: [

                  button('Cadastrar novo smartphone', MediaQuery.of(context).size.width - 100, 50, Icons.add, () {
                    Navigator.push(
                      context,
                      navigator('/employee/phone', context)
                    );
                  }),

                  const SizedBox(height: 20),

                  ListTile(
                    title: const Text('Smartphone 1'),
                    subtitle: const Text('Smartphone cadastrado em 01/01/2021'),
                    trailing: Icon(Icons.phone_android, color: globals.primary,),
                  ),
                ],
              )
            ),
          ]
        )
      ),
      
      bottomNavigationBar: const Bottom(),
    );
  }
}