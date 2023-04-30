import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:tcc/controller/postgres/Lists/productsCart.dart';
import 'package:tcc/main.dart';
import 'package:tcc/model/ProductsCart.dart';
import 'package:tcc/model/Variation.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/sectionVisible.dart';

class ScreenInfoItem extends StatefulWidget {
  final Object? arguments;
  const ScreenInfoItem({
    super.key,
    required this.arguments,
  });

  @override
  State<ScreenInfoItem> createState() => _ScreenInfoItemState();
}

class _ScreenInfoItemState extends State<ScreenInfoItem> {

  @override
  Widget build(BuildContext context) {
    ProductsCartList productsCartList = widget.arguments as ProductsCartList;
    int idRelative = productsCartList.idRelative!;

    Future<Widget> getItems(Variation variation) async {
      int idVariation = variation.id!;
      List<Widget> list = [];
      String textPizzas = '';

      await ProductsCartController().getProductsIdRelation(idRelative, idVariation).then((value) {
        if (variation.category == 'Pizzas') {
          value.forEach((element) {
            textPizzas += '${element.name!.toLowerCase()} meia ';
          });
        }

        if (textPizzas != '') {
          textPizzas = textPizzas.substring(0, textPizzas.length - 5);
          textPizzas = textPizzas.trim();
          
          textPizzas = '${productsCartList.qtd} Pizza${productsCartList.qtd! > 1 ? 's' : ''}: $textPizzas';
          list.add(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                textPizzas,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red
                ),
              ),
            )
          );
        }
        
        for (var item in value) {
            
          list.add(
            ListTile(
              leading: IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    // ProductsCartController().deleteProduct(item.id!);
                  });
                },
              ),

              title: Text(
                item.name!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: item.textVariation != null ? Text(
                item.textVariation!,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ) : null,

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'R\$ ${item.price!.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        // ProductsCartController().deleteProduct(item.id!);
                      });
                    },
                  )
                ],
              ),

              onTap: () {
                Navigator.push(context, navigator(
                  'products/info_product',
                  item.idProduct
                ));
              },
            )
          );
        }
      });

      return Column(
        children: list,
      );
    }

    Future<Widget> getItemsIdRelation() async {
      List<Widget> list = [];
      await ProductsCartController().getVariationItemRelation(idRelative).then((value) {
        for (var item in value) {
          list.add(
            item.idSubVariation == 0 ?
              SectionVisible(
                nameSection: '${item.category.capitalize()} - ${item.size}',
                isShowPart: true,
                child: FutureBuilder(
                  future: getItems(item),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return snapshot.data as Widget;
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            :
              SectionVisible(
                nameSection: item.category,
                isShowPart: true,
                child: FutureBuilder(
                  future: getItems(item),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return snapshot.data as Widget;
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
          );
        }
      });

      return Column(
        children: list,
      );
    }

    return Scaffold(
      appBar: appBarWidget(
        pageName: 'Informações do item', 
        context: context,
        withoutIcons: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            FutureBuilder(
              future: getItemsIdRelation(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return snapshot.data as Widget;
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      )
    );
  }
}