import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tcc/controller/auth/auth.dart';
import 'package:tcc/controller/postgres/Lists/sales.dart';
import 'package:tcc/model/Sales.dart';
import 'package:tcc/model/standardListDropDown.dart';
import 'package:tcc/validators.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/customer/partFinalizeOrder.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/snackBars.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenFOPayment extends StatefulWidget {
  final Sales sale;
  const ScreenFOPayment({
    super.key,
    required this.sale
  });

  @override
  State<ScreenFOPayment> createState() => _ScreenFOPaymentState();
}

class _ScreenFOPaymentState extends State<ScreenFOPayment> {
  var txtMoney = TextEditingController();
  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: 'R\$ #,##0.00',
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy,
  );

  List<DropDownList> paymentMethods = [
    DropDownList(name: 'Dinheiro', icon: Icons.attach_money_outlined),
    DropDownList(name: 'Cartão de crédito', icon: Icons.credit_card),
    DropDownList(name: 'Cartão de débito', icon: Icons.credit_card),
    DropDownList(name: 'Pix', icon: Icons.pix_sharp),
  ];

  String methodSelected = 'Dinheiro';

  bool hasMoney = false;

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

            Text(
              'Total: R\$ ${globals.totalSale.toStringAsFixed(2).replaceAll('.', ',')}',
              style: TextStyle(
                color: globals.primaryBlack,
                fontSize: 16,
                fontWeight: FontWeight.w600
              ),
            ),

            const SizedBox(height: 10),

            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: DropdownButtonFormField(
                  isExpanded: true,
                  iconEnabledColor: globals.primaryBlack,
                  decoration: InputDecoration(
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
              
                  value: methodSelected,
                ),
              ),
            ),

            const SizedBox(height: 10),

            if(methodSelected == 'Dinheiro')
              Column(
                children: [
                  SwitchListTile(
                    title: const Text(
                      'Precisa de troco ?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),

                    value: hasMoney,
                    onChanged: (value) {
                      setState(() {
                        hasMoney = value;
                      });
                    },
                  ),

                  if(hasMoney)
                    TextFieldGeneral(
                      label: 'Troco para quanto?', 
                      variavel: txtMoney,
                      context: context, 
                      keyboardType: const TextInputType.numberWithOptions(),
                      ico: Icons.attach_money,
                      validator: (value) {
                        return validatorString(value!);
                      },
                      inputFormatter: [maskFormatter],

                      onChanged: (value) {
                        if (maskFormatter.getUnmaskedText().length == 3) {
                          txtMoney.value = maskFormatter.updateMask(mask: "R\$ ##,##");
                        } else if (maskFormatter.getUnmaskedText().length == 4) {
                          txtMoney.value = maskFormatter.updateMask(mask: "R\$ ###,##");
                        } else if (maskFormatter.getUnmaskedText().length == 5) {
                          txtMoney.value = maskFormatter.updateMask(mask: "R\$ #.###,##");
                        } else if (maskFormatter.getUnmaskedText().length < 3) {
                          txtMoney.value = maskFormatter.updateMask(mask: "R\$ #,##");
                        }
                      },
                    ),

                  
                ],
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
              }
            ),
      
            button(
              'Finalizar',
              180,
              50,
              Icons.check,
              () async {
                GoRouter.of(context).push('/loading');

                if (methodSelected == 'Dinheiro') {
                  if (!hasMoney) {
                    txtMoney.text = globals.totalSale.toStringAsFixed(2);
                  }

                  if (txtMoney.text.isEmpty) {
                    error(context, 'Informe o valor do troco');
                    GoRouter.of(context).pop();
                    return;
                  }

                  if (double.parse(txtMoney.text) < globals.totalSale) {
                    error(context, 'O valor do troco não pode ser menor que o valor total da compra');
                    GoRouter.of(context).pop();
                    return;
                  }

                  txtMoney.text = txtMoney.text.replaceAll('R\$ ', '');
                  txtMoney.text = txtMoney.text.replaceAll('.', '');
                  txtMoney.text = txtMoney.text.replaceAll(',', '.');

                  txtMoney.text = hasMoney ? txtMoney.text : '0';
                } else {
                  txtMoney.text = '0';
                }

                await SalesController.instance.finalizeSale(
                  type: widget.sale.type!, 
                  idAddressSelected: widget.sale.addressId, 
                  typePayment: methodSelected, 
                  change: num.parse(txtMoney.text)
                );
                LoginController.instance.getTypeUser().then((typeUser) {
                  setState(() {
                    globals.numberTable = null;
                    globals.totalSale = 0;
                    globals.isSelectNewItem = false;
                  });

                  
                  
                  

                  switch (typeUser) {
                    case 'Cliente':
                      GoRouter.of(context).pop();

                      if (widget.sale.type == 'Entrega') {
                        GoRouter.of(context).pop();
                        GoRouter.of(context).pop();
                      } else {
                        GoRouter.of(context).pop();
                      }

                      GoRouter.of(context).go('/home');

                      
                      break;
                    case 'Gerente':
                      GoRouter.of(context).pop();

                      if (widget.sale.type == 'Entrega') {
                        GoRouter.of(context).pop();
                        GoRouter.of(context).pop();
                      } else {
                        GoRouter.of(context).pop();
                      }

                      GoRouter.of(context).go('/home_manager');

                      break;
                    default:
                      GoRouter.of(context).pop();

                      if (widget.sale.type == 'Entrega') {
                        GoRouter.of(context).pop();
                        GoRouter.of(context).pop();
                      } else {
                        GoRouter.of(context).pop();
                      }

                      GoRouter.of(context).go('/home_employee');
                      break;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}