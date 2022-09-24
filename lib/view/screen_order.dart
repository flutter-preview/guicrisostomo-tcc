import 'package:flutter/material.dart';

import '../modal/bottonNavigation.dart';

class ScreenOrder extends StatefulWidget {
  const ScreenOrder({super.key});

  @override
  State<ScreenOrder> createState() => _ScreenOrderState();
}

class _ScreenOrderState extends State<ScreenOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      bottomNavigationBar: Bottom(),
    );
  }
}