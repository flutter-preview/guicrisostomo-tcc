// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_typing_uninitialized_variables, file_names

import 'package:flutter/material.dart';
import 'package:tcc/controller/postgres/Lists/productsCart.dart';
import 'package:tcc/main.dart';
import 'package:tcc/model/ProductsCart.dart';
import 'package:tcc/view/widget/snackBars.dart';
import 'package:tcc/globals.dart' as globals;

class ProductsCart extends StatefulWidget {
  final List<ProductsCartList> product;

  const ProductsCart({
    super.key, 
    required this.product
  });

  @override
  State<ProductsCart> createState() => _ProductsCartState();
}

class _ProductsCartState extends State<ProductsCart> {
  
  var txtQtd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: (widget.product.isNotEmpty) ?
        ListView.builder(
          itemCount: widget.product.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            ProductsCartList dados = widget.product[index];
            int? idItem = dados.id;
            String? name = dados.name;
            num? price = dados.price;
            int? qtd = dados.qtd;
            num? subTotal = price! * qtd!;
        
            return Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    name!,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
        
                      const SizedBox(
                        height: 3,
                      ),
                      
                      Text(
                        'Preço: R\$ ${price.toStringAsFixed(2).replaceFirst('.', ',')}',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
              
                      Text(
                        "Quantidade: $qtd",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
              
                      (dados.agregateItems > 0) ?
                        Text(
                          "Itens agregados: +${dados.agregateItems}",
                          style: TextStyle(
                            color: globals.primary,
                          ),
                        )
                      : Container(),
                    ]
                  ),
              
                  trailing: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: ElevatedButton(
                              
                            onPressed: () {
                            //   txtQtd.text = item['qtd'].toString();
                            //   showDialog(
                            //     context: context,
                            //     builder: (context) => AlertDialog(
                            //       title: Text(
                            //         'Informe a quantidade',
                            //         style: GoogleFonts.roboto(
                            //           fontSize: 36,
                            //           color: Colors.blueGrey.shade700,
                            //         ),
                            //       ),
                            //       titlePadding: EdgeInsets.all(20),
                            //       content: SizedBox(
                            //         width: 350,
                            //         height: 90,
                            //         child: Column(
                            //           children: [
                            //             TextFieldGeneral(
                            //               label: 'Quantidade', 
                            //               variavel: txtQtd,
                            //               context: context, 
                            //               keyboardType: TextInputType.number,
                            //               ico: Icons.shopping_cart,
                            //               validator: (value) {
                            //                 validatorNumber(value!);
                            //               },
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //       backgroundColor: Colors.blueGrey.shade50,
                            //       actionsPadding: EdgeInsets.fromLTRB(0, 0, 20, 20),
                            //       actions: [
                            //         TextButton(
                            //           style: TextButton.styleFrom(
                            //             minimumSize: Size(120, 50),
                            //           ),
                            //           onPressed: () {
                            //             Navigator.pop(context);
                            //           },
                            //           child: Text(
                            //             'Cancelar',
                            //             style: GoogleFonts.roboto(
                            //               fontSize: 20,
                            //               color: Colors.blueAccent.shade700,
                            //             ),
                            //           ),
                            //         ),
                            //         TextButton(
                            //           style: TextButton.styleFrom(
                            //             backgroundColor: Colors.blueAccent.shade700,
                            //             minimumSize: Size(120, 50),
                            //           ),
                            //           onPressed: () async {
                            //             if (txtQtd.text.isNotEmpty) {
                            //               int idSale = 0;
        
                            //               await SalesController().idSale().then((res) async {
                            //                 idSale = res;
        
                            //                 await SalesController().getTotal().then((res){
                            //                   // SalesController().updateTotal(idSale, (res - subTotal) + (num.parse(price.toString()) * int.parse(txtQtd.text)));
                            //                   ProductsCartController().update(idItem!, int.parse(txtQtd.text),);
        
                            //                   Navigator.pop(context);
                                              
                            //                   success(context, 'Quantidade atualizada com sucesso.');
                            //                 }).catchError((e){
                            //                   error(context, 'Ocorreu um erro ao atualizar a quantidade: ${e.code.toString()}');
                            //                 });
                                            
                            //               }).catchError((e){
                            //                 error(context, 'Ocorreu um erro ao atualizar a quantidade: ${e.code.toString()}');
                            //               });
                                          
                            //             } else {
                            //               error(context, 'Informe a quantidade.');
                            //             }
                            //           },
                            //           child: Text(
                            //             'Atualizar',
                            //             style: GoogleFonts.roboto(
                            //               fontSize: 20,
                            //               color: Colors.white,
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   );
                            },
                            
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(2),
                              backgroundColor: globals.primary,
                              shape: const CircleBorder(),
                            ),
                  
                            child: Icon(
                              Icons.edit, size: 15,
                              color: Colors.white,
                            ),
                            
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 10,),
                      
                      
                      Expanded(
                        child: SizedBox(
                          width: 35,
                          height: 35,
                          
                          child: ElevatedButton(
                            
                            
                            onPressed: () {
                              ProductsCartController().deleteItem(
                                // dados.docs[index].id,
                                idItem!, context, true
                              );

                              setState(() {
                                widget.product.removeAt(index);
                              });
                            },
                        
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(2),
                              backgroundColor: globals.primary,
                              shape: const CircleBorder(),
                            ),
                            child: Icon(Icons.delete, size: 15, color: Colors.white,),
              
                          ),
                        )
                      )
                    ]
                  ),
                
                  onTap: () {
                    Navigator.push(
                      context,
                      navigator(
                        'cart/info_item',
                        dados,
                      )
                    );
                  },
                ),
              )
            );
          },
        )
      : Padding(
        padding: EdgeInsets.all(20),
        child: Text('Nenhum item encontrado!')
      ),
    );
  }
}