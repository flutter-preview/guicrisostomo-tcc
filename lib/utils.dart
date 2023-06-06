import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;

IconData? getIconCategory(String category) {
  
  switch (category.toUpperCase()) {
    case 'PIZZA': case 'PIZZAS':
      return Icons.local_pizza;
    case 'SALGADO': case 'SALGADOS':
      return Icons.fastfood;
    case 'SUCO': case 'SUCOS':
      return Icons.local_bar_rounded;
    case 'REFRIGERANTE': case 'REFRIGERANTES': case 'BEBIDA': case 'BEBIDAS':
      return Icons.local_bar_rounded;
    case 'SANDUÍCHE': case 'SANDUÍCHES':
      return Icons.fastfood;
    case 'HAMBÚRGUER': case 'HAMBÚRGUERES': case 'CACHORRO-QUENTE': case 'CACHORROS-QUENTES':
      return Icons.lunch_dining_rounded;
    case 'SOBREMESA': case 'SOBREMESAS':
      return Icons.icecream;
    case 'LANCHE': case 'LANCHES':
      return Icons.lunch_dining_rounded;
    case 'COMIDA': case 'COMIDAS':
      return Icons.dinner_dining_rounded;
    default:
      return Icons.fastfood;
  }
}

Future<bool> checkConnectionToInternet() async {
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();
    // Platform messages may fail, so we use a try/catch PlatformException.
  await connectivity.checkConnectivity().then((value) {
    connectionStatus = value;
  }).catchError((onError) {
    connectionStatus = ConnectivityResult.none;
    print(onError);
  });
  
  return connectionStatus != ConnectivityResult.none;
}

clearGlobalVariables() {
  globals.numberTable = null;
  globals.isSelectNewItem = false;
  globals.userType = '';
  globals.businessId = '0';
  globals.totalSale = 0;
  globals.categoriesBusiness = [];
  globals.sizesCategoryBusiness = [];
  globals.categorySelected = '';
  globals.idAddressSelected = null;
  globals.idSaleSelected = null;
  globals.uidCustomerSelected = null;
}