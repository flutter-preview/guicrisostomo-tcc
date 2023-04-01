import 'package:flutter/material.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/view/widget/switchListTile.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenCreateEditPromotion extends StatefulWidget {
  final String? id;
  const ScreenCreateEditPromotion({
    super.key,
    this.id,
  });

  @override
  State<ScreenCreateEditPromotion> createState() => _ScreenCreateEditPromotionState();
}

class _ScreenCreateEditPromotionState extends State<ScreenCreateEditPromotion> {
  final txtNamePromotion = TextEditingController();
  final txtDescriptionPromotion = TextEditingController();
  final txtDateStartPromotion = TextEditingController();
  final txtDateEndPromotion = TextEditingController();
  final txtDiscountValuePromotion = TextEditingController();
  final txtDiscountPercentagePromotion = TextEditingController();
  final txtMinimumValuePromotion = TextEditingController();
  final txtMaximumDiscountValuePromotion = TextEditingController();
  final txtMaximumDiscountQuantityPromotion = TextEditingController();
  final txtMaximumDiscountQuantityPerClientPromotion = TextEditingController();
  final txtProdFilter = TextEditingController();

  bool isPromotionActive = true;
  bool isDescountByValue = false;
  bool isAllProducts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        pageName: widget.id == null ? 'Criar Promoção' : 'Editar Promoção', 
        context: context,
        withoutIcons: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
              
            SectionVisible(
              nameSection: 'Informações da Promoção', 
              child: Column(
                children: [
                  TextFieldGeneral(
                    label: 'Nome', 
                    variavel: txtNamePromotion, 
                    context: context, 
                    keyboardType: TextInputType.text,
                  ),

                  const SizedBox(height: 10),

                  TextFieldGeneral(
                    label: 'Descrição', 
                    variavel: txtDescriptionPromotion, 
                    context: context, 
                    keyboardType: TextInputType.text,
                  ),

                  const SizedBox(height: 10),

                  StatefulBuilder(
                    builder: (context, setState) {
                      return SwitchListTileWidget(
                        title: const Text(
                          'Promoção Ativa ?',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ), 
                        onChanged: (value) {
                          setState(() {
                            isPromotionActive = value;
                          });
                        }, 
                        value: isPromotionActive,
                      );
                    },
                  ),

                  const SizedBox(height: 10),

                  TextFieldGeneral(
                    label: 'Data de Início', 
                    variavel: txtDateStartPromotion, 
                    context: context, 
                    keyboardType: TextInputType.datetime,
                  ),

                  const SizedBox(height: 10),

                  TextFieldGeneral(
                    label: 'Data de Término', 
                    variavel: txtDateEndPromotion, 
                    context: context, 
                    keyboardType: TextInputType.datetime,
                  ),

                  const SizedBox(height: 10),

                  StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        children: [
                          SwitchListTileWidget(
                            title: const Text(
                              'Desconto por Valor ?',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ), 
                            onChanged: (value) {
                              setState(() {
                                isDescountByValue = value;
                              });
                            }, 
                            value: isDescountByValue,
                          ),

                          const SizedBox(height: 10),

                          isDescountByValue ? TextFieldGeneral(
                            label: 'Valor de Desconto', 
                            variavel: txtDiscountValuePromotion, 
                            context: context, 
                            keyboardType: TextInputType.number,
                          ) : TextFieldGeneral(
                            label: 'Porcentagem de Desconto', 
                            variavel: txtDiscountPercentagePromotion, 
                            context: context, 
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      );
                    }
                  ),

                  const SizedBox(height: 10),

                  TextFieldGeneral(
                    label: 'Valor Mínimo de Compra', 
                    variavel: txtMinimumValuePromotion, 
                    context: context, 
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 10),

                  TextFieldGeneral(
                    label: 'Valor Máximo de Desconto', 
                    variavel: txtMaximumDiscountValuePromotion, 
                    context: context, 
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 10),

                  TextFieldGeneral(
                    label: 'Quantidade Máxima de Desconto', 
                    variavel: txtMaximumDiscountQuantityPromotion, 
                    context: context, 
                    keyboardType: TextInputType.number,
                  ),
                ]
              )
            ),

            const SizedBox(height: 20),

            SectionVisible(
              nameSection: 'Produtos da Promoção', 
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    children: [

                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                          shadowColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ), 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            const Text(
                              'Selecionar tudo',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.select_all, color: globals.primary),
                              onPressed: () {
                                setState(() {
                                  isAllProducts = !isAllProducts;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextFieldGeneral(
                        label: 'Procurar item',
                        variavel: txtProdFilter,
                        context: context,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          setState(() {
                            
                          });
                        },

                        icoSuffix: Icons.search,
                        angleSufixIcon: 90 * 3.14 / 180,
                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text('Produto $index'),
                              leading: Icon(Icons.fastfood, color: globals.primary),
                              subtitle: Text('Descrição do produto $index'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon((!isAllProducts) ? Icons.circle_outlined : Icons.check_circle, color: globals.primary),
                                  Icon(Icons.arrow_forward_ios, color: globals.primary),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
              )
            ),

            const SizedBox(height: 20),

            button('Salvar', 150, 70, Icons.save, () {
              Navigator.pop(context);
            },),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}