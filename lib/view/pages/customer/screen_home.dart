// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc/controller/postgres/Lists/products.dart';
import 'package:tcc/controller/postgres/Lists/sales.dart';
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/model/ProductsCart.dart';
import 'package:tcc/model/Sales.dart';
import 'package:tcc/model/standardSlideShow.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/productItem.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/slideShow.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {

  final String iconOrder = 'lib/images/iconOrder.svg';
  final String iconMenu = 'lib/images/iconMenu.svg';
  
  List<SlideShow> listSlideShow = [];
  int idSale = 0;

  Future<List<ProductItemList>> getBestSellers() async {
    return await ProductsController().productsBestSellesUser().then((value){
      return value;
    });
  }

  Future<Sales?> getSaleOnDemand() async {
    return await SalesController().listSalesOnDemand().then((value){
      
      if (value != null) {
        idSale = value.id;
      } else {
        idSale = 0;
      }
      
      return value;
    });
  }

  Future<void> getSlideShow() async {
    await SlideShow.list(globals.businessId, context).then((List<SlideShow> value){
      // print(value);
      listSlideShow = value;
    });
  }

  @override
  void initState() {
    super.initState();
    globals.userType = 'customer';
    globals.businessId = '1';
    getSaleOnDemand();
  }

  Widget dataSales() {
    return FutureBuilder(
      future: getSaleOnDemand(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasData) {

            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Nenhuma venda em andamento',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54
                  ),
                ),
              ),
            );
          }

          if (!mounted) {
            setState(() {
            
            });
          }

          DateTime date = snapshot.data!.date;
          String dateText = DateFormat("d 'de' MMMM 'de' y 'às' HH':'mm':'ss", "pt_BR").format(date);
          num total = snapshot.data!.getTotal();

          return Column(
            children: [
              const SizedBox(height: 10,),

              Row(
                children: [
                  Icon(Icons.timer_outlined, size: 20, color: globals.primary),

                  const SizedBox(width: 5,),

                  Text(
                    'Criado às $dateText',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54
                    ),
                  )
                ],
              ),

              if (snapshot.data!.table != null)
                Column(
                  children: [
                    const SizedBox(height: 10,),

                    Row(
                      children: [
                        Icon(Icons.room_service_outlined, size: 20, color: globals.primary),

                        const SizedBox(width: 5,),

                        // ignore: prefer_const_constructors
                        Text(
                          'Mesa criada pelo garçom José',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54
                          ),
                        )
                      ],
                    ),
                  ],
                ),

              const SizedBox(height: 10,),

              Row(
                children: [
                  Icon(Icons.attach_money, size: 20, color: globals.primary),

                  const SizedBox(width: 5,),

                  Text(
                    'TOTAL: R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20,),

              Center(
                child: button(
                  'Ver carrinho',
                  MediaQuery.of(context).size.width - 80,
                  0,
                  Icons.shopping_cart_outlined,
                  () {
                    Navigator.pushNamed(context, 'cart');
                  },
                  true,
                  18
                ),
              )
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

  }

  Future<List<ProductItemList>> getFavorities() async {
    return await ProductsController().getProductsFavorites().then((value){
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        pageName: 'Inicio',
        context: context,
        icon: Icons.home
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // imgCenter(imgHome),
            FutureBuilder(
              future: getSlideShow(),
              builder: (context, builder) {
                return SlideShowWidget(listSlideShow: listSlideShow,);
              }
            ),
            
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SectionVisible(
                    nameSection: 'Informações do seu pedido atual',
                    isShowPart: true,
                    child: dataSales(),
                  ),
                  
                  
                  FutureBuilder(
                    future: getFavorities(),
                    builder: (context, builder) {
                      if (builder.connectionState == ConnectionState.done) {
                        return SectionVisible(
                          nameSection: 'Favoritos',
                          isShowPart: true,
                          child: ProductItem(product: builder.data as List<ProductItemList>),
                        );
                      } else if (builder.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const Center(
                          child: Text('Erro ao carregar os produtos'),
                        );
                      }
                    }
                  ),

                  FutureBuilder(
                    future: getBestSellers(),
                    builder: (context, builder) {
                      if (builder.connectionState == ConnectionState.done) {
                        return SectionVisible(
                          nameSection: 'Mais pedidos',
                          isShowPart: true,
                          child: ProductItem(product: builder.data as List<ProductItemList>),
                        );
                      } else if (builder.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const Center(
                          child: Text('Erro ao carregar os produtos'),
                        );
                      }
                    }
                  )

                ],
              ),
            ),
          ]
        )
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}

