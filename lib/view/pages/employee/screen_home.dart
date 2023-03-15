import 'package:flutter/material.dart';
import 'package:tcc/view/widget/appBar.dart';

class ScreenHomeEmployee extends StatefulWidget {
  const ScreenHomeEmployee({super.key});

  @override
  State<ScreenHomeEmployee> createState() => _ScreenHomeEmployeeState();
}

class _ScreenHomeEmployeeState extends State<ScreenHomeEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        pageName: 'Home',
        context: context,
        icon: Icons.home,
      ),

      body: Center(
        child: Text('Home'),
      ),
    );
  }
}