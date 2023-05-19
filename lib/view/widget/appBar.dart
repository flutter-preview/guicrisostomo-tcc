import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tcc/controller/firebase/auth.dart';
import 'package:tcc/globals.dart' as globals;

class AppBarWidget extends StatefulWidget {
  final String pageName;
  final BuildContext context;
  final IconData? icon;
  String svg = '';
  bool withoutIcons = false;

  AppBarWidget({
    super.key,
    required this.pageName,
    required this.context,
    this.icon,
    this.svg = '',
    this.withoutIcons = false,
  });

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  
  @override
  AppBar build(BuildContext context) {
    return AppBar(
      leading: widget.icon == null ? widget.withoutIcons == false ? SvgPicture.asset(
        widget.svg,
        fit: BoxFit.scaleDown,
      ) : null
        : Icon(widget.icon, color: Colors.white, size: 30),
        
      actions: [
        if (FirebaseAuth.instance.currentUser != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: const CircleBorder(),
                shadowColor: Colors.transparent,
              ),
              
              child: const Icon(
                  Icons.logout,
                  size: 30,
                ),
              onPressed: () {
                LoginController().logout(context);
              },
            ),
          ),
      ],
      title: Text(widget.pageName),
      
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              globals.primaryBlack,
              globals.primary.withRed(100),
            ]
          )
        ),
      ),
      backgroundColor: globals.primary,
    );
  }
}