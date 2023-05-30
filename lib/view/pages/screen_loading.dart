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
        
              const Text(
                'Carregando...',
                style: TextStyle(
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