import 'dart:async';

import 'package:flutter/material.dart';

class ScreenLoading extends StatefulWidget {
  const ScreenLoading({super.key});

  @override
  State<ScreenLoading> createState() => _ScreenLoadingState();
}

class _ScreenLoadingState extends State<ScreenLoading> {
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  String loadingPath = 'lib/images/loading.gif';

  String textLoading = 'Carregando...';

  Timer? timer;

  String getTextLoading() {
    switch (textLoading) {
      case 'Carregando...':
        return 'Carregando';
      case 'Carregando':
        return 'Carregando.';
      case 'Carregando.':
        return 'Carregando..';
      case 'Carregando..':
        return 'Carregando...';
      default:
        return 'Carregando...';
    }
  }

  @override
  void initState() {

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        textLoading = getTextLoading();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
              Image.asset(
                loadingPath,
                fit: BoxFit.cover,
              ),
        
              const SizedBox(height: 20,),
        
              Text(
                textLoading,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}