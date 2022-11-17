// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tcc/widget/floatingButton.dart';

import '../widget/bottonNavigationCustomer.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  SvgPicture.asset(
                    'lib/images/imgProfile.svg',
                    width: 100,
                  ),

                  Text(
                    'Rodrigo',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  Text(
                    '(16) 99999-9999',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10,),

            Column(
              children: [
                Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Text('Editar dados'),

                    trailing: Icon(Icons.arrow_right, size: 20),

                    onTap: () => {
                      Navigator.pushNamed(
                        context,
                        'profile/edit_datas',
                      )
                    },
                  ),
                ),

                SizedBox(height: 10,),

                Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Text('Sobre'),

                    trailing: Icon(Icons.arrow_right, size: 20),

                    onTap: () => {
                      Navigator.pushNamed(
                        context,
                        'profile/about',
                      )
                    },
                  ),
                )
              ]
            )
          ]
        )
      ),

      bottomNavigationBar: Bottom(),
      floatingActionButton: floatingButton(context),
    );
  }
}