import 'package:flutter/material.dart';
import 'package:tcc/model/methodsPayment.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/customer/partFinalizeOrder.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenFOPayment extends StatefulWidget {
  const ScreenFOPayment({super.key});

  @override
  State<ScreenFOPayment> createState() => _ScreenFOPaymentState();
}

class _ScreenFOPaymentState extends State<ScreenFOPayment> {
  List<MethodsPayment> paymentMethods = [
    MethodsPayment(name: 'Dinheiro', icon: Icons.money_sharp),
    MethodsPayment(name: 'Cartão de crédito', icon: Icons.credit_card),
    MethodsPayment(name: 'Cartão de débito', icon: Icons.credit_card),
    MethodsPayment(name: 'Pix', icon: Icons.pix_sharp),
  ];

  String methodSelected = 'Dinheiro';

  bool isSelectedMethod = false;

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
                    'Pagamento - Etapa 3/3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                    
                  SizedBox(height: 5),
                      
                  Text(
                    'Escolha a forma de pagamento.',
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
            const PartFinalizeOrder(partUser: 3),

            const SizedBox(height: 20),

            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: DropdownButtonFormField(
                  isExpanded: true,
                  isDense: true,
                  iconEnabledColor: globals.primaryBlack,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      paymentMethods.singleWhere((element) => element.name == methodSelected).icon,
                      color: globals.primaryBlack,
                    ),
                    label: const Text(
                      'Método de pagamento',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                
                    hintText: 'Selecione o método de pagamento',
                    filled: true,
                    fillColor: Colors.transparent,
                    errorStyle: TextStyle(color: globals.primaryBlack),
                  ),
                
                  items: paymentMethods.map((map) {
                    return DropdownMenuItem(
                      value: map.name,
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonHideUnderline(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                map.name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
              
                              if (isSelectedMethod)
                                Icon(
                                  map.icon,
                                  color: globals.primaryBlack,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                
                  onChanged: (value) {
                    setState(() {
                      methodSelected = value.toString();
                    });
                  },
              
                  onTap: () => {
                    setState(() {
                      isSelectedMethod = true;
                    }),
                  },
              
                  onSaved: (newValue) => {
                    setState(() {
                      isSelectedMethod = false;
                    }),
                  },
              
                  value: methodSelected,
                ),
              ),
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
                  'Finalizar',
                  180,
                  50,
                  Icons.check,
                  () => {
                    Navigator.pushNamed(context, 'finalize_order_customer/payment'),
                  },
                ),
              ],
            ),
            
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}