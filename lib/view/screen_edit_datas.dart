import 'package:flutter/material.dart';

class ScreenEditDatas extends StatefulWidget {
  const ScreenEditDatas({super.key});

  @override
  State<ScreenEditDatas> createState() => _ScreenEditDatasState();
}

class _ScreenEditDatasState extends State<ScreenEditDatas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar dados'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(50, 62, 64, 1),
      ),

      body: Container(

      )
    );
  }
}