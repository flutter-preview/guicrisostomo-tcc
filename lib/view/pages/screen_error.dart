import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:tcc/controller/auth/auth.dart';
import 'package:tcc/view/widget/button.dart';

class ScreenError extends StatelessWidget {
  const ScreenError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Erro'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
                size: 100,
                color: Colors.red,
              ),
              const Text(
                'Estamos com problemas para conectar ao servidor :(',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const SizedBox(width: 20),
              button('Tentar novamente', 0, 0, Icons.refresh, () async {
                GoRouter.of(context).go('/loading');

                await LoginController().getTypeUser().then((value) {
                  if (value == 'Cliente') {
                    
                    GoRouter.of(context).go('/home');
                  } else if (value == 'Gerente') {
                    
                    GoRouter.of(context).go('/home_manager');
                  } else {
                    
                    GoRouter.of(context).go('/home_employee');
                  }
                }).catchError((onError) {
                  
                });
              })
            ],
          ),
        ),
      ),

      bottomNavigationBar: button('Sair', MediaQuery.of(context).size.width * 0.5 - 30, 0, Icons.exit_to_app, () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      })
    );
  }
}