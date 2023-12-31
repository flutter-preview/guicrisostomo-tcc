import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tcc/controller/auth/auth.dart';
import 'package:tcc/controller/postgres/Lists/productsCart.dart';
import 'package:tcc/controller/postgres/Lists/sales.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/model/Sales.dart';
import 'package:tcc/model/standardRadioButton.dart';
import 'package:tcc/validators.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/customer/partFinalizeOrder.dart';
import 'package:tcc/view/widget/radioButton.dart';
import 'package:tcc/view/widget/snackBars.dart';
import 'package:tcc/view/widget/switchListTile.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenFOMain extends StatefulWidget {
  final Object? arguments;

  const ScreenFOMain({
    super.key,
    this.arguments,
  });

  @override
  State<ScreenFOMain> createState() => _ScreenFOMainState();
}

class _ScreenFOMainState extends State<ScreenFOMain> {
  var txtPhone = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.eager,
  );

  Future<String?> getTypeSale() async {
    return await SalesController.instance.listSalesOnDemand().then((value) {
      return value!.type;
    });
  }

  String? type = '';
  int? idOrder;
  int? numberTable;

  bool hasCloseTable = false;
  bool isUserAnonymous = false;
  bool hasPhoneNumber = false;

  List<RadioButtonList> listRadioButton = [
    RadioButtonList(
      name: 'Entrega',
      icon: Icons.local_shipping,
    ),

    RadioButtonList(
      name: 'Retirada',
      icon: Icons.person,
    ),
  ];

  @override
  void initState() {
    super.initState();
    RadioButtonList.setGroup('Entrega');

    if (widget.arguments != null) {
      Map<String, dynamic> arguments = widget.arguments! as Map<String, dynamic>;
      setState(() {
        type = arguments['type'] as String?;
        idOrder = arguments['idOrder'] as int?;
        numberTable = arguments['numberTable'] as int?;
      });

      print('idOrder: $idOrder');
    } else {
      getTypeSale().then((value) {
        if (value == 'Mesa') {
          setState(() {
            type = 'Mesa';
          });
        } else {
          setState(() {
            type = RadioButtonList.getGroup();
          });
        }
      });
    }
    
    setState(() {
      FirebaseAuth.instance.currentUser!.isAnonymous ? isUserAnonymous = true : isUserAnonymous = false;
    });

    if (globals.userType == 'customer') {

      LoginController.instance.getPhoneNumberUser().then((value) {
        if (value != null) {
          setState(() {
            hasPhoneNumber = true;
          });
        }
      });

      LoginController.instance.getPhoneNumberUser().then((value) {
        if (value != null) {
          setState(() {
            hasPhoneNumber = true;
          });
        }
      });

    } else {
      setState(() {
        hasPhoneNumber = true;
      });
    }

    print('type: $type');
  }

  @override
  Widget build(BuildContext context) {

    hasPhoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber != null || FirebaseAuth.instance.currentUser?.phoneNumber == '' ? true : false;

    return type != '' ? Scaffold(
      appBar: PreferredSize(
        preferredSize: type != 'Mesa' ? const Size.fromHeight(220) : const Size.fromHeight(250),
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
                children: [
                  (type != 'Mesa') ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type == 'Entrega' ? 'Dados pessoais - Etapa 1/3' : 'Dados pessoais - Etapa 1/2',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                          
                        const SizedBox(height: 5),
                            
                        const Text(
                          'Informe seus dados pessoais para finalizar o pedido. Esses dados serão usados para identificar seu pedido e para que você possa acompanhar o status do mesmo.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  :
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Finalizar pedido - Etapa 1/1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                          
                        SizedBox(height: 5),
                            
                        Text(
                          'Quando um pedido é finalizado via mesa ainda será possível efetuar novos pedidos (ele apenas será impresso para nossos atendentes). Para fechar a conta, clique no botão "Fechar mesa" logo abaixo e, em seguida, clique no botão "Finalizar".',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                ],
              ),
            )
          ),
        ),
      ),

      body: !globals.isSelectNewItem ? SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            type != 'Mesa' ?
              Column(
                children: [
                  const PartFinalizeOrder(partUser: 1),

                  (isUserAnonymous) ?
                    Column(
                      children: [
                        const SizedBox(height: 20,),
                        const Text(
                          'Para finalizar o pedido é necessário estar logado. Caso não tenha uma conta, clique no botão abaixo para criar uma.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 20,),

                        button(
                          'Registrar', 
                          0, 
                          0, 
                          Icons.person_add, 
                          () => {
                            GoRouter.of(context).push('/register'),
                            // Navigator.pushNamed(context, 'register')
                          }
                        ),
                      ],
                    ) : (hasPhoneNumber) ?
                  Column(
                    children: [
                      const SizedBox(height: 20,),

                      RadioButon(
                        list: listRadioButton,
                        callback: (value) {
                          setState(() {
                            type = value;
                          });
                        },
                      ),
                    ],
                  ) : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          'Para finalizar o pedido é necessário informar um número de telefone.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 20,),
                        
                        TextFieldGeneral(
                          label: 'Telefone', 
                          variavel: txtPhone, 
                          keyboardType: TextInputType.phone,
                          inputFormatter: [maskFormatter],
                          validator: (value) {
                            return validatorPhone(value!);
                          },
                          ico: Icons.phone,
                        ),

                        const SizedBox(height: 20,),
                  
                        button('Salvar', 170, 50, Icons.save, () {
                          if (txtPhone.text.isNotEmpty) {
                            int phone = int.parse(txtPhone.text.replaceAll('(', '').replaceAll(')', '').replaceAll('-', '').replaceAll(' ', ''));
                            LoginController.instance.savePhoneNumber(phone, context);
                          } else {
                            error(context, 'Informe um número de telefone válido.');
                          }
                        })
                      ],
                    ),
                  )
                ],
              ) : 
              Column(
                children: [
                  SwitchListTileWidget(
                    title: const Text(
                      'Fechar mesa',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: 'Ao fechar a mesa, não será possível adicionar novos pedidos.',
                    value: hasCloseTable,
                    onChanged: (value) {
                      setState(() {
                        hasCloseTable = value;
                      });
                    },
                  )
                ],
              ),
            
          ],
        ),
      ) : 
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Você possui itens ainda não adicionados no carrinho de compras. Deseja descartar esses itens?',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    
                  },
                  child: const Text(
                    'Não',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () async {
                    setState(() {
                      globals.isSelectNewItem = false;
                    });
                    await ProductsCartController.instance.clearItemsOnDemand();
                  },
                  child: const Text(
                    'Sim',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
        
            
          ],
        ),
      ),

      bottomNavigationBar: (!isUserAnonymous) ? Padding(
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
                GoRouter.of(context).pop(),
                // Navigator.pop(context)
              }
            ),
      
            button(
              type != 'Mesa' ? 'Próximo' : 'Finalizar',
              180,
              50,
              type != 'Mesa' ? Icons.arrow_forward : Icons.check,
              () {
                if (type == 'Mesa') {
                  SalesController.instance.finalizeSale(
                    hasFinishSale: hasCloseTable,
                    idOrder: idOrder,
                    numberTable: numberTable,
                  ).whenComplete(() {

                    LoginController.instance.getTypeUser().then((typeUser) {
                      if (hasCloseTable) {
                        setState(() {
                          globals.numberTable = null;
                          globals.totalSale = 0;
                          globals.isSelectNewItem = false;
                        });
                      }

                      

                      switch (typeUser) {
                        case 'Cliente':
                          // GoRouter.of(context).pop();
                          GoRouter.of(context).go('/home');
                          break;
                        case 'Gerente':
                          // GoRouter.of(context).pop();
                          GoRouter.of(context).go('/home_manager');
                          break;
                        default:
                          // GoRouter.of(context).pop();
                          GoRouter.of(context).go('/home_employee');
                          break;
                      }
                    });

                  });
                } else if (type == 'Entrega') {
                  GoRouter.of(context).push('/finalize_order_customer/address', extra: type);
                } else {
                  GoRouter.of(context).push('/finalize_order_customer/payment', extra: Sales(id: 0, uid: FirebaseAuth.instance.currentUser!.uid, cnpj: globals.businessId, status: 'Andamento', date: DateTime.now(), type: type, total: globals.totalSale, table: globals.numberTable));
                }
              },
              false
            ),
          ],
        ),
      ) : null,
    ) : Container(
      color: Colors.white,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      ),
    );
  }
}