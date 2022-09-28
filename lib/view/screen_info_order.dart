import 'package:flutter/material.dart';

class ScreenInfoOrder extends StatefulWidget {
  const ScreenInfoOrder({super.key});

  @override
  State<ScreenInfoOrder> createState() => _ScreenInfoOrderState();
}

class _ScreenInfoOrderState extends State<ScreenInfoOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações'),
        centerTitle: true,
      ),

    );
  }
}