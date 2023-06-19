import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc/controller/postgres/Lists/productsCart.dart';
import 'package:tcc/controller/postgres/Lists/sales.dart';
import 'package:tcc/model/ProductsCart.dart';
import 'package:tcc/model/Sales.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/listCart.dart';
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

  Future<List<Sales>> getInfoTable() async {
    return SalesController.instance.getInfoTable(widget.arguments as int).then((value) {
      return value;
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<List<ProductsCartList>> getItemsProduct() async {
    return await ProductsCartController.instance.listTable(widget.arguments as int).catchError((onError) {
      print(onError);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    print(widget.arguments as int);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: 'Informações da mesa ${widget.arguments as int}',
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
                    SectionVisible(
                      nameSection: 'Informações',
                      isShowPart: true,
                      child: Column(
                        children: [
                          FutureBuilder(
                            future: getInfoTable(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.room_service, color: globals.primary),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          child: Text(
                                            'Garçom(s): ${snapshot.data!.toList().map((e) {
                                              if (e.isEmployee) {
                                                return e.nameUserCreatedSale;
                                              }
                                            }).join(', ').replaceAll(', null', '').replaceAll('null, ', '')}',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),

                                            overflow: TextOverflow.fade,
                                          ),
                                        )
                                      ],
                                    ),

                                    const SizedBox(height: 20),

                                    Row(
                                      children: [
                                        Icon(Icons.people, color: globals.primary),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          child: Text(
                                            'Clientes: ${snapshot.data!.toList().map((e) {
                                              if (!e.isEmployee) {
                                                return e.nameUserCreatedSale;
                                              }
                                            }).join(', ').replaceAll(', null', '').replaceAll('null, ', '')}',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                            overflow: TextOverflow.fade,
                                          ),
                                        )
                                      ],
                                    ),

                                    const SizedBox(height: 20),

                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(Icons.timer, color: globals.primary),
                                        const SizedBox(width: 10),
                                        StreamBuilder(
                                          stream: Stream.periodic(const Duration(seconds: 1)),
                                          builder: (context, now) {
                                            int indexLastSaleActive = snapshot.data!.toList().lastIndexWhere((element) {
                                              if (element.status == 'Ativo' || element.status == 'Para impressão') {
                                                return true;
                                              } else {
                                                return false;
                                              }
                                            });

                                            if (indexLastSaleActive == -1) {
                                              return const Flexible(
                                                child: Text(
                                                  'Tempo de espera do pedido atual: 0 minutos',
                                                  overflow: TextOverflow.fade,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              );
                                            }

                                            return Flexible(
                                              child: Text(
                                                'Tempo de espera do pedido atual: ${DateTime.now().difference(snapshot.data![indexLastSaleActive].date).inMinutes} minutos',
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            );
                                          }
                                        )
                                      ],
                                    ),

                                    const SizedBox(height: 20),

                                    Builder(
                                      builder: (context) {
                                        DateFormat formatter = DateFormat("dd/MM/yyyy 'às' HH:mm");
                                        DateTime date = snapshot.data![0].date;

                                        return Row(
                                          children: [
                                            Icon(Icons.timer, color: globals.primary),
                                            const SizedBox(width: 10),
                                            Text(
                                              'Chegada: ${formatter.format(date)}',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        );
                                      }
                                    ),

                                    const SizedBox(height: 20),

                                    Row(
                                      children: [
                                        Icon(Icons.attach_money_outlined, color: globals.primary),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Valor: R\$ ${snapshot.data![0].total.toStringAsFixed(2).replaceAll('.', ',')}',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                );
                              } else if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return const Center(
                                  child: Text('Erro ao carregar as informações'),
                                );
                              }
                            }
                          ),
                        ],
                      ),
                    ),

                    SectionVisible(
                      nameSection: 'Itens pedidos',
                      isShowPart: true,
                      child: FutureBuilder<List<ProductsCartList>>(
                        future: getItemsProduct(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                            return ProductsCart(
                              product: snapshot.data!,
                              isShowButtonDelete: false,
                              numberTable: widget.arguments as int,
                            );
                          } else if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return const Center(
                              child: Text('Erro ao carregar os itens'),
                            );
                          }
                        },
                      ),
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