import 'package:flutter/material.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/sectionVisible.dart';

class ScreenInfoTable extends StatefulWidget {
  final Object? arguments;
  const ScreenInfoTable({
    super.key,
    this.arguments,
  });

  @override
  State<ScreenInfoTable> createState() => _ScreenInfoTableState();
}

class _ScreenInfoTableState extends State<ScreenInfoTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        pageName: 'Informações da mesa ${widget.arguments}',
        context: context,
        withoutIcons: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Informações importantes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 20),

                    Row(
                      children: [
                        Icon(Icons.room_service, color: globals.primary),
                        SizedBox(width: 10),
                        Text(
                          'Garçom: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 20),

                    Row(
                      children: [
                        Icon(Icons.people, color: globals.primary),
                        SizedBox(width: 10),
                        Text(
                          'Clientes: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 20),

                    Row(
                      children: [
                        Icon(Icons.timer, color: globals.primary),
                        SizedBox(width: 10),
                        Text(
                          'Tempo de espera do pedido atual: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 20),

                    Row(
                      children: [
                        Icon(Icons.timer, color: globals.primary),
                        SizedBox(width: 10),
                        Text(
                          'Chegada: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 20),

                    (globals.userType == 'manager')
                        ? Row(
                            children: [
                              Icon(Icons.attach_money_outlined, color: globals.primary),
                              SizedBox(width: 10),
                              Text(
                                'Valor: ',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              )
                            ],
                          )
                        : Container(),

                    SectionVisible(
                      nameSection: 'Itens pedidos',
                      isShowPart: true,
                      child: Text('Itens pedidos'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}