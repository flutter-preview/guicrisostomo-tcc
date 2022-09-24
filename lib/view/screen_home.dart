import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tcc/modal/bottonNavigation.dart';
import 'package:tcc/modal/imageMainScreens.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {

  final String iconOrder = 'lib/images/iconOrder.svg';
  final String iconMenu = 'lib/images/iconMenu.svg';

  final String imgHome = 'lib/images/imgHomeCustomer.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16.0),
          
          child: Column(
            children: [
              imgCenter(imgHome)
            ],
          )
        ),

        
      ),

      bottomNavigationBar: Bottom(),
    );
  }
}
