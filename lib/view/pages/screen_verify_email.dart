import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcc/controller/auth/auth.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/snackBars.dart';

class ScreenVerifyEmail extends StatefulWidget {
  const ScreenVerifyEmail({super.key});

  @override
  State<ScreenVerifyEmail> createState() => _ScreenVerifyEmailState();
}

class _ScreenVerifyEmailState extends State<ScreenVerifyEmail> {
  
  bool isEmailVerified() {
    FirebaseAuth.instance.currentUser!.reload();

    if (FirebaseAuth.instance.currentUser?.emailVerified == true) {
      LoginController.instance.redirectUser(context);
      return true;
    }

    if (FirebaseAuth.instance.currentUser?.emailVerified == null) {
      return false;
    } else {
      return FirebaseAuth.instance.currentUser!.emailVerified;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          context: context,
          pageName: 'Verificar e-mail',
          icon: Icons.email_outlined,
        ),
      ),

      body: StreamBuilder<bool>(
        stream: Stream.periodic(
          const Duration(seconds: 1)
        ).asyncMap((event) => isEmailVerified()),
        builder: (context, snapshot) {
          return (snapshot.hasData) ? (snapshot.data == false) ? Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20,),
      
                const Text(
                  'Verifique seu e-mail',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
      
                const SizedBox(height: 20,),
      
                const Text(
                  'Enviamos um e-mail para você, verifique sua caixa de entrada e clique no link para confirmar seu e-mail.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
      
                const SizedBox(height: 20,),
      
                const Text(
                  'Não recebeu o e-mail?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
      
                const SizedBox(height: 20,),
      
                button('Reenviar e-mail', 0, 0, Icons.email, () {
                  FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
                    success(context, 'E-mail enviado com sucesso!');
                  });
                })
              ],
            ),
          ) : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'E-mail verificado com sucesso!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
      
                const SizedBox(height: 20,),
      
                button('Continuar', 0, 0, Icons.arrow_forward_ios, () {
                  LoginController.instance.redirectUser(context);
                })
              ],
            ),
          ) : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
      
                SizedBox(height: 20,),
      
                Text(
                  'Verificando e-mail...',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}