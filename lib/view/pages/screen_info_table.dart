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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: 'Informações da mesa ${widget.arguments}',
          context: context,
          withoutIcons: true,
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Informações importantes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Icon(Icons.room_service, color: globals.primary),
                        const SizedBox(width: 10),
                        const Text(
                          'Garçom: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Icon(Icons.people, color: globals.primary),
                        const SizedBox(width: 10),
                        const Text(
                          'Clientes: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Icon(Icons.timer, color: globals.primary),
                        const SizedBox(width: 10),
                        const Text(
                          'Tempo de espera do pedido atual: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Icon(Icons.timer, color: globals.primary),
                        const SizedBox(width: 10),
                        const Text(
                          'Chegada: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 20),

                    (globals.userType == 'manager')
                        ? Row(
                            children: [
                              Icon(Icons.attach_money_outlined, color: globals.primary),
                              const SizedBox(width: 10),
                              const Text(
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
                      child: const Text('Itens pedidos'),
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