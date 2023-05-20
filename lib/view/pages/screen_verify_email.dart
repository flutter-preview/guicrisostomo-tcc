import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/auth.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/snackBars.dart';

class ScreenVerifyEmail extends StatefulWidget {
  const ScreenVerifyEmail({super.key});

  @override
  State<ScreenVerifyEmail> createState() => _ScreenVerifyEmailState();
}

class _ScreenVerifyEmailState extends State<ScreenVerifyEmail> {
  
  @override
  Widget build(BuildContext context) {
    Future<bool> isEmailVerified() async {
      User? user = FirebaseAuth.instance.currentUser;
      return user!.emailVerified;
    }

    isEmailVerified().then((value) async {
      if (value) {
        await LoginController().redirectUser(context);
        success(context, 'E-mail verificado com sucesso!');
      }
    });

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          context: context,
          pageName: 'Verificar e-mail',
          icon: Icons.email_outlined,
        ),
      ),

      body: Padding(
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
      ),
    );
  }
}