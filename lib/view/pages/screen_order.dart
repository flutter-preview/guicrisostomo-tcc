import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc/controller/firebase/sales.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/dropDownButton.dart';
import 'package:tcc/view/widget/floatingButton.dart';
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
  var txtDateInitial = TextEditingController();
  var txtDateFinal = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(globals.primary),
                                  ),
                                  child: const Text('Todos'),
                                ),

                                ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(globals.primary),
                                  ),
                                  child: const Text('Em andamento'),
                                ),

                                ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(globals.primary),
                                  ),
                                  child: const Text('Finalizados'),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        DropDown(
                          text: 'Data',
                          itemSelecionado: txtDropDown,
                          itemsDropDownButton: const [
                            'Hoje',
                            'Ontem',
                            'Últimos 7 dias',
                            'Últimos 30 dias',
                            'Últimos 90 dias',
                            'Últimos 180 dias',
                            'Últimos 365 dias',
                            'Personalizado',
                          ],
                          callback: (value) {
                            setState(() {
                              txtDropDown = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  if (txtDropDown == 'Personalizado')
                    Column(
                      children: [
                        TextFieldGeneral(
                          label: 'Data inicial',
                          variavel: txtDateInitial,
                          context: context,
                          keyboardType: TextInputType.datetime,
                          ico: Icons.date_range,
                          validator: (value) {
                            validatorString(value!);
                          },
                        ),

                        const SizedBox(height: 20),

                        TextFieldGeneral(
                          label: 'Data final',
                          variavel: txtDateFinal,
                          context: context,
                          keyboardType: TextInputType.datetime,
                          ico: Icons.date_range,
                          validator: (value) {
                            validatorString(value!);
                          },
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),

                  listViewOrder(),
                ],
              )
            )
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
      floatingActionButton: floatingButton(context),
    );
  }
}

listViewOrder() {

  return Container(
    child: (
      StreamBuilder<QuerySnapshot>(
        stream: SalesController().listSalesFinalize().snapshots(),
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
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            'order/info',

                            //Passagem de parâmetro
                            arguments: dados.docs[index],

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