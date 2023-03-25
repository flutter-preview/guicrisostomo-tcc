import 'package:flutter/material.dart';
import 'package:tcc/main.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/addressExistent.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/customer/partFinalizeOrder.dart';
import 'package:tcc/view/widget/cartInfo.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenFOGetAddress extends StatefulWidget {
  const ScreenFOGetAddress({super.key});

  @override
  State<ScreenFOGetAddress> createState() => _ScreenFOGetAddressState();
}

class _ScreenFOGetAddressState extends State<ScreenFOGetAddress> {
  var txtStreetAddress = TextEditingController();
  var txtNumberHome = TextEditingController();
  var txtNeighborhood = TextEditingController();
  var txtComplement = TextEditingController();

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
                    'Endereço - Etapa 2/3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                    
                  SizedBox(height: 5),
                      
                  Text(
                    'Informe seu endereço para entrega. Você pode escolher um endereço já cadastrado ou informar um novo endereço.',
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
            const PartFinalizeOrder(partUser: 2),

            const SizedBox(height: 20),

            AddressExistent(
              txtAddress: txtStreetAddress,
              txtNumberHome: txtNumberHome,
              txtNeighborhood: txtNeighborhood,
              txtComplement: txtComplement
            ),

            const SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                button(
                  'Voltar',
                  180,
                  50,
                  Icons.arrow_back,
                  () => Navigator.pop(context)
                ),

                button(
                  'Avançar',
                  180,
                  50,
                  Icons.arrow_forward,
                  () => {
                    Navigator.push(context, navigator('finalize_order_customer/payment')),
                  },
                  false
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}