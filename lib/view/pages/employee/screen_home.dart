// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tcc/controller/auth/auth.dart';
import 'package:tcc/controller/others/notification.dart';
import 'package:tcc/controller/postgres/Lists/sales.dart';
import 'package:tcc/controller/postgres/Lists/table.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/sectionVisible.dart';
class ScreenHomeEmployee extends StatefulWidget {
  const ScreenHomeEmployee({super.key});

  @override
  State<ScreenHomeEmployee> createState() => _ScreenHomeEmployeeState();
}

class _ScreenHomeEmployeeState extends State<ScreenHomeEmployee> {
  List<int> tablesCall = [];

  void getTablesCall() {
    TablesController.instance.getAllTablesCallWaiter().onData((data) {
      
      for (var element in data.docChanges) {
        if (element.type == DocumentChangeType.added) {
          tablesCall.add(element.doc.data()!['table']);
        } else if (element.type == DocumentChangeType.removed) {
          tablesCall.remove(element.doc.data()!['table']);
        } else if (element.type == DocumentChangeType.modified) {
          tablesCall.remove(element.doc.data()!['table']);
          tablesCall.add(element.doc.data()!['table']);
        }

        NotificationController.instance.showNotification(
          'Mesa ${tablesCall[0]} chamando',
          'Clique para atender',
          [
            'Atender',
          ],
        );
      }

      setState(() {
        tablesCall = tablesCall;
      });
    });
  }

  num mediaStar = 3.50;

  @override
  void initState() {
    
    setState(() {
      globals.userType = 'employee';
      globals.businessId = '1';
      globals.numberTable = null;
      globals.totalSale = 0;
    });

    getTablesCall();

    if (globals.numberTable == null && globals.uidCustomerSelected == null) {
      NotificationController.instance.stream.listen((event) {
        if (event[1] != null) {
          setState(() async {
            await TablesController.instance.cancelCallWaiter(context, tablesCall[0]);
            globals.numberTable = tablesCall[0];

            tablesCall.remove(tablesCall[0]);

            GoRouter.of(context).go('/table/info');
            globals.idSaleSelected = null;
          });
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Mesa ${tablesCall[0]} chamando'),
              content: const Text('Deseja atender a mesa?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.pushNamed(context, 'home_employee');
                  },
                  child: const Text('Não'),
                ),
                TextButton(
                  onPressed: () async {
                    showAboutDialog(context: context, applicationName: 'teste');
                  },
                  child: const Text('Sim'),
                ),
              ],
            ),
          );
        }
      });
    }

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // notifyCallTable();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(270),
        child: Container(
          width: double.infinity,
          color: globals.primaryBlack,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBar(
                title: const Text('Home'),
                leading: const Icon(Icons.home),
                backgroundColor: globals.primary,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () async => {
                      await LoginController.instance.logout(context),
                    },
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Center(
                      child: Text(
                        'Olá, ${FirebaseAuth.instance.currentUser!.displayName}!',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 30,
                          color: Colors.white,
                        ),

                        const SizedBox(width: 10),

                        const Text(
                          'Seu desempenho: ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(width: 10),

                        Column(
                          children: [
                            Text(
                              mediaStar.toStringAsFixed(2).replaceAll('.00', ''),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),

                            Row(
                              children: [
                                const SizedBox(width: 10),

                                for (num i = 1; i <= 5; i++)
                                  (i < mediaStar) ? const Icon(
                                    Icons.star,
                                    size: 20,
                                    color: Colors.white,
                                  ) : ((mediaStar - (i - 1) < 1) && (mediaStar - (i - 1) > 0)) ?
                                    const Icon(
                                      Icons.star_half,
                                      size: 20,
                                      color: Colors.white,
                                    ) : const Icon(
                                      Icons.star_border,
                                      size: 20,
                                      color: Colors.white,
                                    )
                              ],
                            )
                          ],
                        )
                      ],
                    ),

                    const SizedBox(height: 20),
                    
                    const Text(
                      'Pedidos efetuados: 10',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(width: 10),

                    const Text(
                      'Avaliação média: 4.5',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),


                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            (tablesCall.isNotEmpty) ? Column(
              mainAxisSize: MainAxisSize.max,
              children: [
            
                Text(
                  'Última atualização: ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}'
                ),
                
                ListView.builder(
                  itemCount: tablesCall.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    int numberTable = tablesCall[index];
                    
                    return Card(
                      color: globals.primaryBlack,
                        
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        
                        title: Text(
                          'Mesa $numberTable chamando',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        trailing: SizedBox(
                          height: 50,
                          width: 100,
                          child: Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.all(10),
                              ),
                              onPressed: () {
                                
                              },
                              
                              child: const Row(
                                children: [
                                  Icon(Icons.check, size: 20, color: Colors.white,),
                                  SizedBox(width: 5),
                                  Text(
                                    'Atender',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        leading: const Icon(Icons.table_bar, size: 40, color: Colors.white,),
                        
                        onTap: () => {
                          GoRouter.of(context).push('/manager/products')
                        },
                      ),
                    );
                  }
                ),
              ]) : const Center(
                child: CircularProgressIndicator(),
              ),
            
            Card(
              color: globals.primaryBlack,
    
              child: const ListTile(
                contentPadding: EdgeInsets.all(10),
    
                leading: Icon(Icons.add, size: 40, color: Colors.white,),
    
                title: Text(
                  'Fazer novo pedido',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
    
                trailing: Icon(Icons.arrow_right, size: 30, color: Colors.white,),
              ),
            ),
    
            const SizedBox(height: 20),
    
            SectionVisible(
              nameSection: 'Acesso rápido',
              child: Column(
                children: [
                  Card(
                    color: globals.primaryBlack,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      title: const Text(
                        'Acessar pedidos',
                        style: TextStyle(color: Colors.white),
                      ),
    
                      trailing: const Icon(Icons.arrow_right, size: 20, color: Colors.white,),
                      leading: const Icon(Icons.shopping_cart, size: 20, color: Colors.white,),
                      
                      onTap: () => {
                        GoRouter.of(context).push('/manager/products')
                      },
                    ),
                  ),
                  
                  Card(
                    color: globals.primaryBlack,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      title: const Text(
                        'Fazer novo pedido',
                        style: TextStyle(color: Colors.white),
                      ),
    
                      trailing: const Icon(Icons.arrow_right, size: 20, color: Colors.white,),
                      leading: const Icon(Icons.shopping_cart, size: 20, color: Colors.white,),
                      
                      onTap: () => {
                        GoRouter.of(context).push('/manager/products')
                      },
                    ),
                  ),
    
                  Card(
                    color: globals.primaryBlack,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      title: const Text(
                        'Acessar cardápio',
                        style: TextStyle(color: Colors.white),
                      ),
    
                      trailing: const Icon(Icons.arrow_right, size: 20, color: Colors.white,),
                      leading: SvgPicture.asset('lib/images/iconMenu.svg', height: 25, fit: BoxFit.fill,),
                      
                      onTap: () => {
                        GoRouter.of(context).push('/manager/products')
                      },
                    ),
                  ),
    
                  Card(
                    color: globals.primaryBlack,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      title: const Text(
                        'Cadastrar novo produto',
                        style: TextStyle(color: Colors.white),
                      ),
    
                      trailing: const Icon(Icons.arrow_right, size: 20, color: Colors.white,),
                      leading: const Icon(Icons.add, size: 20, color: Colors.white,),
    
                      onTap: () => {
                        GoRouter.of(context).push('/manager/products')
                      },
                    ),
                  ),
    
                  Card(
                    color: globals.primaryBlack,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      title: const Text(
                        'Acessar avaliações',
                        style: TextStyle(color: Colors.white),
                      ),
    
                      trailing: const Icon(Icons.arrow_right, size: 20, color: Colors.white,),
                      leading: const Icon(Icons.star, size: 20, color: Colors.white,),
                      
                      onTap: () => {
                        GoRouter.of(context).push('/employee/evaluation', extra: '1')
                      },
                    ),
                  ),
    
                  Card(
                    color: globals.primaryBlack,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      title: const Text(
                        'Rotas de entrega',
                        style: TextStyle(color: Colors.white),
                      ),
    
                      trailing: const Icon(Icons.arrow_right, size: 20, color: Colors.white,),
                      leading: const Icon(Icons.delivery_dining, size: 20, color: Colors.white,),
                      
                      onTap: () => {
                        GoRouter.of(context).push('/manager/products')
                      },
                    ),
                  ),
    
                  Card(
                    color: globals.primaryBlack,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      title: const Text(
                        'Acessar dados da empresa',
                        style: TextStyle(color: Colors.white),
                      ),
    
                      trailing: const Icon(Icons.arrow_right, size: 20, color: Colors.white,),
                      leading: const Icon(Icons.business, size: 20, color: Colors.white,),
                      
                      onTap: () => {
                        GoRouter.of(context).push('/manager/products')
                      },
                    ),
                  ),
    
                  Card(
                    color: globals.primaryBlack,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      title: const Text(
                        'Acessar dados do usuário',
                        style: TextStyle(color: Colors.white),
                      ),
    
                      trailing: const Icon(Icons.arrow_right, size: 20, color: Colors.white,),
                      leading: const Icon(Icons.person, size: 20, color: Colors.white,),
                      
                      onTap: () => {
                        GoRouter.of(context).push('/manager/products')
                      },
                    ),
                  ),
                ],
              )
            ),
    
            const SizedBox(height: 20),
    
            SectionVisible(
              nameSection: 'Mesas ativas',
              isShowPart: true,
              child: SizedBox(
                height: 50,
                width: double.infinity,
                
                child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: ElevatedButton(
                        
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(globals.primaryBlack),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(5)),
                        ),
                        onPressed: () => {
                          GoRouter.of(context).push('/table/info')
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.table_bar, size: 20, color: Colors.white,),
                            const SizedBox(width: 5),
                            Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                )
              )
            ),
            
          ]
        )
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}