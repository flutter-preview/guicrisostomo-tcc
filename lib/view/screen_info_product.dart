import 'package:flutter/material.dart';

import '../modal/bottonNavigationCustomer.dart';
import '../modal/listSizeAvailable.dart';

class ScreenInfoProduct extends StatelessWidget {

  final String imgPizza = 'lib/images/imgPizza.png';

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
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back, color: Colors.white),
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
            
            listSize('PEQUENA (4 fatias)'),
            listSize('GRANDE (8 fatias)'),
            listSize('GIGANTE (12 fatias)'),
          ]
        )
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}