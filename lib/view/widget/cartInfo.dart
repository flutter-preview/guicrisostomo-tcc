// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcc/controller/postgres/Lists/sales.dart';
import 'package:tcc/globals.dart' as globals;

class CartInfo extends StatefulWidget {
  const CartInfo({super.key});

  @override
  State<CartInfo> createState() => _CartInfoState();
}

class _CartInfoState extends State<CartInfo> {
  num total = 0;
  num items = 0;

  Future<num> getInfo() async {
    if (globals.idSaleSelected != null && globals.idSaleSelected != 0) {
      return await SalesController.instance.getTotal().then((value) {
        items = value[1];
        total = value[0];
        return value[0];
      });
    } else {
      return 0;
    }
  }

  Widget cartInfo(context) {
    return globals.userType != 'manager' && total != 0 ? Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).push('/cart');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.all(0),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    globals.primaryBlack,
                    globals.primary.withOpacity(0.9),
                  ]
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 20,
                      ),
          
                      const SizedBox(width: 5),
          
                      Text(
                        items.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
      
                  const SizedBox(width: 5),
          
                  const Text(
                    'Item(s)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
      
                  const SizedBox(width: 5),
          
                  Row(
                    children: [
                      Text(
                        'R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
          
                      const SizedBox(width: 5),
          
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).push('/finalize_order_customer');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.all(0),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    globals.primaryBlack,
                    globals.primary.withOpacity(0.9),
                  ]
                ),
              ),
          
              child: const Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 20
                  ),
      
                  SizedBox(width: 5),
            
                  Text(
                    'Finalizar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
      
                  SizedBox(width: 5),
            
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 15
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ) : const SizedBox();
  }

  @override
  void initState() {
    super.initState();
    getInfo().then((value) {
      if (mounted) {
        setState(() {
          total = value;
          globals.totalSale = value;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      initialData: globals.totalSale,
      future: getInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done || snapshot.data != 0) {
          return cartInfo(context);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: globals.primary,
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}