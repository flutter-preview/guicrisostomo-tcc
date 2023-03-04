// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/authGoogle.dart';
import 'package:tcc/globals.dart' as globals;

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return _isSigningIn
      ? CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(globals.primary),
        )
      : OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(globals.primary),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            maximumSize: MaterialStateProperty.all(
              Size(400, 70),
            ),
          ),
          onPressed: () async {
            
            setState(() {
              _isSigningIn = true;
            });
    
            signIn(context);
    
            setState(() {
              _isSigningIn = false;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 20,

              children: const [
                Image(
                  image: AssetImage("lib/images/google_logo.png"),
                  height: 35.0,
                ),

                Text(
                  'Entrar com Google',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        );
  }
}