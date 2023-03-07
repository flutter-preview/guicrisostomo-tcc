import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/productsCart.dart';
import 'package:tcc/controller/firebase/sales.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/snackBars.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenAddItem extends StatefulWidget {
  const ScreenAddItem({super.key});

  @override
  State<ScreenAddItem> createState() => _ScreenAddItemState();
}

class _ScreenAddItemState extends State<ScreenAddItem> {
  var formKey = GlobalKey<FormState>();
  bool autoValidation = false;

  num subTotal = 0;
  var txtQtd = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    autoValidation = false;
    txtQtd.text = "1";
  }

  @override
  Widget build(BuildContext context) {
    dynamic productSelect = ModalRoute.of(context)!.settings.arguments as QueryDocumentSnapshot;

    String idProduct = productSelect.id;
    String nameProduct = productSelect['name'];
    num priceProduct = productSelect['price'];
    String descriptionProduct = productSelect['description'];
    String urlImageProduct = productSelect['urlImage'];
    String categoryProduct = productSelect['category'];
    String sizeProduct = productSelect['size'];

    if (txtQtd.text == '1' || txtQtd.text == '') {
      setState(() {
        subTotal = priceProduct * 1;
      });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        
        child: AppBar(
          titleSpacing: 0,
          title: const Flexible(
            child: Text(
              'Adicionar ao carrinho',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),

          flexibleSpace: Container(
            alignment: Alignment.centerLeft,
            height: 180,
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
                image: NetworkImage(
                  urlImageProduct,
                ),
                fit: BoxFit.cover,
              ),
            ),
          
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        nameProduct,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                
                      Text(
                        'R\$ ${priceProduct.toStringAsFixed(2).replaceFirst('.', ',')}',
                        style: const TextStyle(
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            autovalidateMode: autoValidation ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.description,
                      color: globals.primary,
                      size: 30,
                    ),

                    const SizedBox(width: 10),

                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Descição: $descriptionProduct',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
            
                /*Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: textFieldNumberGeneral('Quantidade', txtQtd, context),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: button('Salvar', context, 'home'),
                      ),
                    ]
                  ),
                )*/

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: globals.primary, spreadRadius: 1),
                    ],
                  ),

                  height: 85,
                  width: MediaQuery.of(context).size.width - 20,
                  child: Padding(
                    padding: const EdgeInsets.all(10),

                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: globals.primary,
                          size: 30,
                        ),
                  
                        const SizedBox(width: 10),
                  
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),

                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                'Agregar outro item ao produto',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ),

                const SizedBox(height: 20),
          
                Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        child: TextFieldGeneral(
                          label: 'Quantidade', 
                          variavel: txtQtd,
                          context: context, 
                          keyboardType: TextInputType.number,
                          ico: Icons.shopping_cart_outlined,
                          validator: (value) {
                            validatorNumber(value!);
                          },
                        ),
                      ),
      
                      Container(
                        alignment: Alignment.bottomRight,
                        height: 60,
                        child: button('Adicionar R\$ ${subTotal.toStringAsFixed(2).replaceFirst('.', ',')}', 100, 50, Icons.add_shopping_cart, () async {
                          if (formKey.currentState!.validate()) {
                            String idSale;
                            await SalesController().idSale().then((res) async {
                              idSale = res;
                              ProductsCartController().add(idSale, idProduct, nameProduct, priceProduct, int.parse(txtQtd.text), subTotal, categoryProduct, sizeProduct);
      
                              await SalesController().getTotal().then((res){
                                SalesController().updateTotal(idSale, res + subTotal);
                                Navigator.pop(context);
                                success(context, 'Produto adicionado com sucesso');
                              }).catchError((e){
                                error(context, 'Ocorreu um erro ao adicionar o produto: ${e.code.toString()}');
                              });
      
                            }).catchError((e){
                              error(context, 'Ocorreu um erro ao adicionar o produto: ${e.code.toString()}');
                            });
      
                          } else {
                            setState(() {
                              autoValidation = true;
                            });
                          }
                        }),
                      ),
                    ]
                  ),
                )
              ]
            ),
          ),
        ),
      ),
      
      bottomNavigationBar: const Bottom(),
    );
  }
}