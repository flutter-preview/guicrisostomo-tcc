import 'package:flutter/material.dart';
import 'package:tcc/controller/mysql/Lists/businessInfo.dart';
import 'package:tcc/controller/mysql/Lists/productsCart.dart';
import 'package:tcc/controller/mysql/Lists/sales.dart';
import 'package:tcc/main.dart';
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/model/ProductsCart.dart';
import 'package:tcc/model/Variation.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/snackBars.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenAddItem extends StatefulWidget {
  Object? arguments;

  ScreenAddItem({
    super.key,
    this.arguments,
  });

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
    ProductItemList productSelect = widget.arguments as ProductItemList;

    int idProduct = productSelect.id;
    String nameProduct = productSelect.name;
    num priceProduct = productSelect.price;
    String descriptionProduct = productSelect.description;
    String? urlImageProduct = productSelect.link_image;
    Variation variation = productSelect.variation!;
    int idVariation = variation.id ?? 0;
    int idCurrentItem = 0;

    Future<num> calcSubtotal() async {
      return await BusinessInformationController().getInfoCalcValue().then((isHighValue) async {
        return await SalesController().idSale().then((idOrder) async {
          return await ProductsCartController().listItemCurrent(idOrder, idProduct == 0 ? await ProductsCartController().getVariationItem(idOrder) : idVariation).then((List<ProductsCartList> res) {
            print ('res: ${res.length}');
            print('result: $isHighValue');
            print('idVariation: $idVariation');
            if (res.isEmpty) {
              subTotal = priceProduct;
            } else {
              bool value = isHighValue ?? false;

              for (final item in res) {
                num price = item.price!;
                if (isHighValue ?? true) {
                  if (subTotal < price) {
                    subTotal = price;
                  }
                } else {
                  subTotal += price;
                }
              }

              if (!value) {
                subTotal /= res.length;
              }
            }

            // setState(() {});
            return subTotal;
          });
        });
      });
    }

    // print('object: $productSelect');

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
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                image: NetworkImage(urlImageProduct ?? 'https://lh5.googleusercontent.com/p/AF1QipOBoD7baOHV4zR4Do0NrU7Vsi75ZTRM4eq9UgmL=s443-k-no'),
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
                        idProduct == 0 ? 'Adicionar items ao carrinho' : nameProduct,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      
                      idProduct == 0 ? 
                        Container() :
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
                idProduct != 0 ?
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
                  ) : Container(),

                const SizedBox(height: 20),

                idProduct != 0 ?
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

                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          Navigator.push(context, navigator('products'));
                          
                          setState(() {
                            globals.isSelectNewItem = true;
                          });

                          await SalesController().idSale().then((res) async {
                            await ProductsCartController().add(res, idProduct, nameProduct, int.parse(txtQtd.text), idVariation);
                          });
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),

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
                      ),
                    )
                  ) : Container(),

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
                          onChanged: (value) {
                            calcSubtotal();
                            subTotal *= int.parse(value);
                          },
                        ),
                      ),

                      FutureBuilder(
                        future: calcSubtotal(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return Container(
                              alignment: Alignment.bottomRight,
                              height: 60,
                              child: button('Adicionar R\$ ${subTotal.toStringAsFixed(2).replaceFirst('.', ',')}', 100, 50, Icons.add_shopping_cart, () async {
                                if (formKey.currentState!.validate()) {
                                  int idSale;
                                  await SalesController().idSale().then((res) async {
                                    idSale = res;
                                    await ProductsCartController().add(idSale, idProduct, nameProduct, int.parse(txtQtd.text), idVariation, false);
            
                                    await SalesController().getTotal().then((res){
                                      // SalesController().updateTotal(idSale, res + subTotal);
                                      Navigator.pop(context);
                                      success(context, 'Produto adicionado com sucesso');
                                    }).catchError((e){
                                      error(context, 'Ocorreu um erro ao adicionar o produto: $e');
                                      
                                    });
            
                                  }).catchError((e){
                                    error(context, 'Ocorreu um erro ao adicionar o produto: $e');
                                    print(e);
                                  });
            
                                } else {
                                  setState(() {
                                    autoValidation = true;
                                  });
                                }
                              }),
                            );
                          } else if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return const Center(
                              child: Text('Ocorreu um erro ao carregar os dados'),
                            );
                          }
                        },
                      )
      
                      
                    ]
                  ),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}