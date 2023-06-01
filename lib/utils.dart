import 'package:flutter/material.dart';

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