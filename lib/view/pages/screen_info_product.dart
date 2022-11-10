import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/listSizeAvailable.dart';

class ScreenInfoProduct extends StatelessWidget {

  final String imgPizza = 'lib/images/imgPizza.png';
  final String iconOrder = 'lib/images/iconOrder.svg';

  const ScreenInfoProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  imgPizza,
                ),
                fit: BoxFit.cover,
              ),
            ),
          
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                
                      const Text(
                        'Informações',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              
                
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      Text(
                        'TENTAÇÃO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                
                      Text(
                        'Chocolate preto, chocolate branco e creme de morango',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ]
                  ),
                ),
              ]
            )
          ),
        ),
      ),
    
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),

            const Center(
              child: Text(
                'Tamanhos disponíveis',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(height: 10,),

            listSize('PEQUENA (4 fatias)', 'R\$ 20,00'),
            listSize('GRANDE (8 fatias)', 'R\$ 30,00'),
            listSize('GIGANTE (12 fatias)', 'R\$ 40,00'),

            const SizedBox(height: 10,),

            const Center(
              child: Text(
                'Informações adicionais',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  SvgPicture.asset(
                    iconOrder,
                    fit: BoxFit.scaleDown,
                    height: 20,
                  ),
            
                  const Text(
                    'Último pedido: 19:52 do dia 27/05/2022'
                  )
                ],
              ),
            ),

            const SizedBox(height: 10,),
          ]
        )
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}