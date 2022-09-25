import 'package:flutter/material.dart';

import '../modal/bottonNavigationCustomer.dart';

class ScreenProducts extends StatefulWidget {
  const ScreenProducts({super.key});

  @override
  State<ScreenProducts> createState() => _ScreenProductsState();
}

class _ScreenProductsState extends State<ScreenProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      bottomNavigationBar: Bottom(),
    );
  }
}