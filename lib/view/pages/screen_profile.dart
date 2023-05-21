// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/auth.dart';
import 'package:tcc/main.dart';
import 'package:tcc/model/User.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  UserList? user;
  String nameUser = "Nome";
  String? phoneUser = "(99) 99999-9999";
  String? photoUser;

  void getUser() async {
    await LoginController().userLogin().then((value){
      setState(() {
        user = value;
        nameUser = value.name;
        phoneUser = value.phone;
        photoUser = value.image;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: 'Perfil',
          context: context,
          icon: Icons.person,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            (nameUser != "Nome") ?
              Center(
                child: Column(
                  children: [
                    
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                    
                        child: CachedNetworkImage(
                          imageUrl: photoUser??"https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png",
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
              )
            : 
              Center(
                child: CircularProgressIndicator(),
              ),

            SizedBox(height: 10,),

            Column(
              children: [
                Card(
                  child: ListTile(
                    
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),

                    title: Text('Editar dados'),
                    leading: Icon(Icons.person, size: 30, color: Colors.red,),
                    trailing: Icon(Icons.arrow_right, size: 20, color: globals.primary,),

                    onTap: () async => {
                      Navigator.push(
                        context,
                        navigator('profile/edit_datas', user),
                      ).then((value) {
                        getUser();
                      })
                    },
                  ),
                ),

                SizedBox(height: 5,),

                Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    leading: Icon(Icons.manage_accounts, size: 30, color: Colors.red,),
                    title: Text('Sou um gerente'),

                    trailing: Icon(Icons.arrow_right, size: 20, color: globals.primary,),

                    onTap: () {
                      Navigator.pushNamed(context, 'transition_manager_user');
                    },
                  ),
                ),

                SizedBox(height: 5,),

                Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    title: Text('Sair'),
                    leading: Icon(Icons.logout, size: 30, color: Colors.red,),
                    trailing: Icon(Icons.arrow_right, size: 20, color: Colors.red,),

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