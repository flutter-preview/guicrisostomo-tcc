import 'package:flutter/material.dart';

import '../modal/bottonNavigation.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      bottomNavigationBar: Bottom(),
    );
  }
}