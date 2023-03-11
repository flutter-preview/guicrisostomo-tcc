// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/auth.dart';
import 'package:tcc/main.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  QueryDocumentSnapshot? user;
  String nameUser = "Nome";
  String? phoneUser = "(99) 99999-9999";
  String photoUser = "https://i.pinimg.com/originals/0c/3b/3a/0c3b3adb1a7530892e55ef36d3be6cb8.png";

  void getUser() async {
    await LoginController().userLogin().then((value){
      setState(() {
        user = value;
        nameUser = value.data()['name'];
        phoneUser = value.data()['phone'];
        photoUser = value.data()['photo'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (nameUser == "Nome") {
      getUser();
    }

    Widget returnPhotoUser() {
      if (phoneUser != null) {
        return Text(
          phoneUser!,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
          ),
        );
      } else {
        return SizedBox(height: 5,);
      }
    }

    return Scaffold(
      appBar: appBarWidget(
        pageName: 'Perfil',
        context: context,
        icon: Icons.person,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                  
                      child: CachedNetworkImage(
                        imageUrl: photoUser,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),

                  Text(
                    nameUser,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  returnPhotoUser(),
                ],
              ),
            ),

            SizedBox(height: 10,),

            Column(
              children: [
                Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    title: Text('Editar dados'),

                    trailing: Icon(Icons.arrow_right, size: 20),

                    onTap: () async => {
                      Navigator.push(
                        context,
                        navigator('profile/edit_datas', user),
                      )
                    },
                  ),
                ),

                SizedBox(height: 5,),

                Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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

                SizedBox(height: 5,),

                Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
      
    );
  }
}