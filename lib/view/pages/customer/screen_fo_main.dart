import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/customer/partFinalizeOrder.dart';
import 'package:tcc/view/widget/floatingButton.dart';

class ScreenFOMain extends StatefulWidget {
  const ScreenFOMain({super.key});

  @override
  State<ScreenFOMain> createState() => _ScreenFOMainState();
}

class _ScreenFOMainState extends State<ScreenFOMain> {
  bool isShowPart = false;
  Icon iconPart = const Icon(Icons.arrow_right_rounded);

  bool isShowDescriptionPart1 = false;
  Icon iconDescriptionPart1 = const Icon(Icons.arrow_right_rounded);

  bool isShowDescriptionPart2 = false;
  Icon iconDescriptionPart2 = const Icon(Icons.arrow_right_rounded);

  bool isShowDescriptionPart3 = false;
  Icon iconDescriptionPart3 = const Icon(Icons.arrow_right_rounded);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(220),
        child: AppBar(
          title: const Text(
            'Finalizar pedido',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),

          centerTitle: true,
          backgroundColor: Colors.white,

          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: globals.primary,
              image: DecorationImage(
                image: const AssetImage('lib/images/imgPizza.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(globals.primary.withOpacity(0.8), BlendMode.dstATop),
              ),
            ),

            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Text(
                    'Dados pessoais - Etapa 1/3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                    
                  SizedBox(height: 5),
                      
                  Text(
                    'Informe seus dados pessoais para finalizar o pedido. Esses dados serão usados para identificar seu pedido e para que você possa acompanhar o status do mesmo.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const PartFinalizeOrder(partUser: 1),

            const SizedBox(height: 20),

            button('Voltar', 300, 50, Icons.arrow_back, () => null),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
      floatingActionButton: floatingButton(context),
    );
  }
}