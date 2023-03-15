import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tcc/main.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/customer/bottonNavigationCustomer.dart';
import 'package:tcc/globals.dart' as globals
;
class ScreenHomeEmployee extends StatefulWidget {
  const ScreenHomeEmployee({super.key});

  @override
  State<ScreenHomeEmployee> createState() => _ScreenHomeEmployeeState();
}

class _ScreenHomeEmployeeState extends State<ScreenHomeEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(250),
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
                    onPressed: () => {
                      Navigator.pushReplacement(
                        context,
                        navigator('login'),
                      )
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

                    const Center(
                      child: Text(
                        'Olá, João',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: const [
                        Icon(
                          Icons.star,
                          size: 30,
                          color: Colors.white,
                        ),

                        SizedBox(width: 10),

                        Text(
                          'Seu desempenho:',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            
            Card(
              color: globals.primaryBlack,

              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                
                title: const Text(
                  'MESA 30 CHAMANDO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                trailing: SizedBox(
                  height: 50,
                  width: 100,
                  child: Center(
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.all(10),
                          ),
                          onPressed: () {
                            
                          },
                                  
                          child: Row(
                            children: const [
                              Icon(Icons.check, size: 20, color: Colors.white,),
                              SizedBox(width: 10),
                              Text(
                                'Atender',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ]
                    ),
                  ),
                ),
                leading: const Icon(Icons.table_bar, size: 40, color: Colors.white,),
                
                onTap: () => {
                  Navigator.push(
                    context,
                    navigator('manager/products'),
                  )
                },
              ),
            ),

            const SizedBox(height: 20),

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
                  Navigator.push(
                    context,
                    navigator('manager/products'),
                  )
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
                  Navigator.push(
                    context,
                    navigator('manager/products'),
                  )
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
                  Navigator.push(
                    context,
                    navigator('manager/products'),
                  )
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
                  Navigator.push(
                    context,
                    navigator('manager/products'),
                  )
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
                  Navigator.push(
                    context,
                    navigator('manager/products'),
                  )
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
                  Navigator.push(
                    context,
                    navigator('manager/products'),
                  )
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
                  Navigator.push(
                    context,
                    navigator('manager/products'),
                  )
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
                  Navigator.push(
                    context,
                    navigator('manager/products'),
                  )
                },
              ),
            ),
          ]
        )
      ),

      bottomNavigationBar: const BottomCustomer(),
    );
  }
}