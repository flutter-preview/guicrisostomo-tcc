// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tcc/controller/firebase/auth.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/floatingButton.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  late QueryDocumentSnapshot user;
  var nameUser = "Nome";
  var phoneUser = "(99) 99999-9999";

  void getUser() async {
    await LoginController().userLogin().then((dynamic value){
      setState(() {
        user = value;
        nameUser = value.data()['name'];
        phoneUser = value.data()['phone'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (nameUser == "Nome") {
      getUser();
    }

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
                    nameUser,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  Text(
                    phoneUser,
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

                    onTap: () async => {
                      Navigator.pushNamed(
                        context,
                        'profile/edit_datas',

                        arguments: user
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
                ),

                Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Text('Sair'),

                    trailing: Icon(Icons.arrow_right, size: 20),

                    onTap: () => {
                      LoginController().logout(context)
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