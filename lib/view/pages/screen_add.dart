import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/productsCart.dart';
import 'package:tcc/controller/firebase/sales.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/floatingButton.dart';
import 'package:tcc/view/widget/snackBars.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/textFieldNumberGeneral.dart';

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

    Widget textField() {
      return Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        
        constraints: const BoxConstraints( 
          minWidth: 70,
        ),

        child: Center(
          child: TextFormField(
            controller: txtQtd,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),

            decoration: InputDecoration(
              labelText: 'Quantidade',
              labelStyle: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),

              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide:  const BorderSide(color: Colors.transparent ),
              ),
            ),

            validator: (value) {
              value = value!.replaceFirst(',', '.');
              if (int.tryParse(value) == null) {
                return 'Entre com um valor numérico';
              } else {
                if (value.isEmpty) {
                  return 'Preencha o campo com as informações necessárias';
                }
                return null;
              }
            },

            onChanged: (value) {
              if (value != "") {
                setState(() {
                  subTotal = int.parse(value) * priceProduct;
                });
              } else {
                setState(() {
                  subTotal = 1 * priceProduct;
                });
              }
            },
          )
        )
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(145),
        child: AppBar(
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
                image: NetworkImage(
                  urlImageProduct,
                ),
                fit: BoxFit.fill,
              ),
            ),
          
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                  child: Row(
                    children: [

                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                
                      const Text(
                        'Adicionar ao carrinho',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
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
                        'R\$ ${priceProduct.toStringAsFixed(2).replaceFirst('.', '.')}',
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

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          autovalidateMode: autoValidation ? AutovalidateMode.always : AutovalidateMode.disabled,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Descição: $descriptionProduct',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
          
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
        
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: textFieldNumberGeneral('Quantidade', txtQtd, context),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          height: 60,
                          child: Text(
                            'R\$ ${subTotal.toStringAsFixed(2).replaceFirst('.', ',')}',
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        
                        Container(
                          alignment: Alignment.bottomRight,
                          height: 60,
                          child: button('Adicionar', 100, 50, () async {
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
                      ],
                    ),
                  ]
                ),
              )
            ]
          ),
        ),
      ),
      
      bottomNavigationBar: const Bottom(),
      floatingActionButton: floatingButton(context),
    );
  }
}