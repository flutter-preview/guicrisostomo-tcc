// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc/controller/mysql/Lists/sales.dart';
import 'package:tcc/model/ProductsCart.dart';
import 'package:tcc/model/standardSlideShow.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/listCart.dart';
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

  late List<ProductsCartList> list = [];
  List<SlideShow> listSlideShow = [];
  ProductsCartList? listSale;
  String? idSale;

  // void getIdSale() async {
  //   await SalesController().idSale().then((value){
  //     setState(() {
  //       idSale = value;
  //       list = ProductsCartController().list(idSale);
  //     });
  //   });
  // }

  // Future<void> getSaleOnDemand() async {
  //   await SalesController().listSalesOnDemand().then((value){
  //     setState(() {
  //       listSale = value;
  //     });
  //   });
  // }

  Future<void> getSlideShow() async {
    await SlideShow.list(globals.businessId, context).then((List<SlideShow> value){
      // print(value);
      setState(() {
        listSlideShow = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // getIdSale();
    globals.userType = 'customer';
    globals.businessId = '1';
    // getSaleOnDemand();
  }

  @override
  Widget build(BuildContext context) {

    Widget dataSales() {

      if (listSale == null) {

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

      DateTime date = listSale!.date!;
      String dateText = DateFormat("d 'de' MMMM 'de' y 'às' HH':'mm':'ss", "pt_BR").format(date);
      num total = listSale!.getTotal();

      return Column(
        children: [
          Row(
            children: [
              Icon(Icons.timer_outlined, size: 20, color: globals.primary),

              const SizedBox(width: 5,),

              Text(
                // ignore: unnecessary_string_escapes
                'Criado \às $dateText'
              )
            ],
          ),
          
          const SizedBox(height: 10,),

          Row(
            children: [
              Icon(Icons.room_service_outlined, size: 20, color: globals.primary),

              const SizedBox(width: 5,),

              const Text(
                'Mesa criada pelo garçom José'
              )
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
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              )
            ],
          ),

          const SizedBox(height: 10,),

          Row(
            children: [
              Icon(Icons.payment_outlined, size: 20, color: globals.primary),

              const SizedBox(width: 5,),

              const Text(
                'Pagamento: Cartão de crédito'
              )
            ],
          ),

          const SizedBox(height: 10,),

          Row(
            children: [
              Icon(Icons.star_border_outlined, size: 20, color: globals.primary),

              const SizedBox(width: 5,),

              const Text(
                'Avaliação: 5 estrelas'
              )
            ],
          ),

          const SizedBox(height: 10,),

          Row(
            children: [
              Icon(Icons.comment_outlined, size: 20, color: globals.primary),

              const SizedBox(width: 5,),

              const Text(
                'Comentário: Ótimo atendimento'
              )
            ],
          ),

          const SizedBox(height: 10,),

          Row(
            children: [
              Icon(Icons.check_circle_outline, size: 20, color: globals.primary),

              const SizedBox(width: 5,),

              const Text(
                'Status: Finalizado'
              )
            ],
          ),
        ],
      );

    }

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
                  
                  
                  SectionVisible(
                    nameSection: 'Favoritos',
                    isShowPart: false,
                    child: ProductsCart(product: list),
                  ),

                  SectionVisible(
                    nameSection: 'Mais pedidos',
                    isShowPart: false,
                    child: ProductsCart(product: list),
                  ),

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

