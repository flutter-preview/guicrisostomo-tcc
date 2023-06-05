import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcc/model/Address.dart';
import 'package:tcc/model/Sales.dart';
import 'package:tcc/view/widget/addressExistent.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/customer/partFinalizeOrder.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/snackBars.dart';

class ScreenFOGetAddress extends StatefulWidget {
  final String typeSale;

  const ScreenFOGetAddress({
    super.key,
    required this.typeSale
  });

  @override
  State<ScreenFOGetAddress> createState() => _ScreenFOGetAddressState();
}

class _ScreenFOGetAddressState extends State<ScreenFOGetAddress> {
  var txtStreetAddress = TextEditingController();
  var txtNumberHome = TextEditingController();
  var txtNeighborhood = TextEditingController();
  var txtComplement = TextEditingController();
  var txtNickName = TextEditingController();
  Address? addressSelected;

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

            child: const Padding(
              padding: EdgeInsets.fromLTRB(20, 100, 20, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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

      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            PartFinalizeOrder(partUser: 2),

            SizedBox(height: 20),

            AddressExistent(
            ),
            
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            button(
              'Voltar',
              180,
              50,
              Icons.arrow_back,
              () => {
                GoRouter.of(context).pop()
                // Navigator.pop(context)
              }
            ),
      
            button(
              'Avançar',
              180,
              50,
              Icons.arrow_forward,
              () {
                if (globals.idAddressSelected == null) {
                  return error(context, 'Selecione um endereço para entrega.');
                } else {
                  GoRouter.of(context).push('/finalize_order_customer/payment', extra: Sales(
                    id: 0, 
                    uid: FirebaseAuth.instance.currentUser!.uid, 
                    cnpj: globals.businessId, 
                    status: 'Andamento', 
                    date: DateTime.now(), 
                    type: widget.typeSale, 
                    total: globals.totalSale, 
                    table: globals.numberTable,
                    addressId: globals.idAddressSelected,
                  ));
                }
              },
              false
            ),
          ],
        ),
      ),
    );
  }
}