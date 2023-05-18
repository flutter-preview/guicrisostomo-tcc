import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tcc/controller/postgres/utils.dart';
import 'package:tcc/main.dart';
import 'package:tcc/model/Address.dart';
import 'package:tcc/model/User.dart';
import 'package:tcc/view/widget/snackBars.dart';
      
class LoginController {
  Future<String?> getTypeUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    
    return await connectSupadatabase().then((conn) async {
      
      
      
      return await conn.query('select tu.name from tb_user u INNER JOIN type_user tu ON u.type = tu.id where uid = @uid', substitutionValues: {
        'uid': user!.uid
      }).then((List value) {
        conn.close();
        return value[0][0];
      });
      // value1.from(
      //   'type_user'
      // ).select(
      //   'name, tb_user!inner(type, uid)'
      // ).eq(
      //   'tb_user.uid', user?.uid
      // ).single().limit(1, foreignTable: 'tb_user').then((value) {
      //   TypeUser typeUser = TypeUser.fromJson(value);
      //   return typeUser.name;
      // });

      // final results = await conn.query('select tu.name from user u INNER JOIN type_user tu ON u.type = tu.id where uid = ?', [user?.uid]);
      // conn.close();
    });

    
    // final results = await conn.query('select tu.name from user u INNER JOIN type_user tu ON u.type = tu.id where uid = ?', [user?.uid]);
    // conn.close();
  }

  Future<void> signInAnonymously(context) async {
    
    Navigator.push(context, navigator('loading'));
    
    (FirebaseAuth.instance.currentUser?.uid != null) ? {
      Navigator.pop(context),
      await userLogin(),
      success(context, 'Usuário autenticado com sucesso.'),
    } : {
      await FirebaseAuth.instance.signInAnonymously().then((value) async {
        await saveDatasUser(value.user?.uid, 'Visitante', 'visitante@hungry.com', null, 1, context);
        Navigator.pop(context);
        await userLogin();
      }).catchError((e) {
        error(context, 'Ocorreu um erro ao fazer login: ${e.code.toString()}');
      })
    };
  }

  Future<void> saveDatasUser(String? uid, String name, String email, String? phone, int type, BuildContext context) async {
    await connectSupadatabase().then((conn) async {
          
      await conn.query('insert into tb_user (uid, name, email, phone, type) values (@uid, @name, @email, @phone, @type)', substitutionValues: {
        'uid': uid,
        'name': name,
        'email': email,
        'phone': phone,
        'type': type,
      });
      conn.close();
      // await conn.from('tb_user').insert({
      //   'uid': res.user?.uid,
      //   'name': name,
      //   'email': email,
      //   'phone': phone.replaceAll(RegExp(r'[-() ]'), ''),
      //   'type': 1,
      // });

      success(context, 'Usuário criado com sucesso.');
      await redirectUser(context);
    });
  }

  Future<void> createAccount(context, String name, String email, String phone, String password) async {
    Navigator.push(context, navigator('loading'));
    
    await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((res) async {
        
        saveDatasUser(res.user?.uid, name, email, phone.replaceAll(RegExp(r'[-() ]'), ''), 1, context);
        // final MySqlConnection conn = await connectMySQL();
        // await conn.query('insert into user (uid, name, email, phone, type) values (?, ?, ?, ?, ?)',
        // [res.user?.uid, name, email, phone.replaceAll(RegExp(r'[-() ]'), ''), 1]);

        // conn.close();

        
    }).catchError((e) {
      switch (e.code) {
        case 'email-already-in-use':
          error(context, 'O email já foi cadastrado.');
          break;
        case 'invalid-email':
          error(context, 'O email é inválido.');
          break;
        default:
          error(context, e.code.toString());
      }
    });

    Navigator.pop(context);
  }

  Future<void> login(context, String email, String senha) async {
    Navigator.push(context, navigator('loading'));

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((res) async {
      success(context, 'Usuário autenticado com sucesso.');
      // Navigator.pop(context);
      redirectUser(context);

    }).catchError((e) {
      switch (e.code) {
        case 'invalid-email':
          error(context, 'O formato do email é inválido.');
          break;
        case 'user-not-found':
          error(context, 'Usuário não encontrado.');
          break;
        case 'wrong-password':
          error(context, 'Senha incorreta.');
          break;
        default:
          error(context, e.code.toString());
      }
    });

    Navigator.pop(context);
  }

  Future<void> forgetPassword(String email, context) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      success(context, 'E-mail de recuperação de senha enviado com sucesso');
    }).catchError((e) {
      error(context, 'Ocorreu um erro ao enviar seu e-mail de recuperação de senha: ${e.code.toString()}');
    });

    Navigator.pop(context);
    Navigator.pushNamed(
      context,
      'presentation',
    );
  }

  Future<void> deleteUser(String uid) async {
    await connectSupadatabase().then((conn) async {
      await conn.query('delete from tb_user where uid = @uid', substitutionValues: {
        'uid': uid,
      });
      conn.close();
    });
  }

  Future<void> logout(context) async {
    Navigator.push(context, navigator('loading'));

    final GoogleSignIn googleSignIn = GoogleSignIn();

    if (googleSignIn.clientId != null) {
      await googleSignIn.signOut();
    }

    if (FirebaseAuth.instance.currentUser?.isAnonymous == true) {
      await deleteUser(FirebaseAuth.instance.currentUser?.uid ?? '');
      await FirebaseAuth.instance.currentUser?.delete();
    }
    
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushNamed(
      context,
      'presentation',
    );
  }

  Future<dynamic> userLogin() async {

    var uid = FirebaseAuth.instance.currentUser?.uid;

    return connectSupadatabase().then((conn) async {
      
      // return await conn.from('tb_user').select(
      //   '*'
      // ).eq(
      //   'uid', uid
      // ).single().then((value) {
      //   return value;
      // }).then((value) {
      //   UserList user = UserList.fromJson(value);
      //   return user;
      // });
      return conn.query('select * from tb_user where uid = @uid', substitutionValues: {
        'uid': uid,
      }).then((List value) {
        conn.close();
        return value;
      });
      // Results results = await conn.query('select * from user where uid = ?', [uid]);
      // conn.close();
    });
  }

  Future<void> updateUser(id, name, email, phone, context) async {
    await connectSupadatabase().then((conn) async {
      
      // await conn.from('tb_user').update({
      //   'name': name,
      //   'email': email,
      //   'phone': phone.replaceAll(RegExp(r'[-() ]'), ''),
      // }).eq(
      //   'uid', id
      // ).then((value) {
      //   redirectUser(context);
      //   success(context, 'Usuário atualizado com sucesso.');
      // });
      await conn.query('update tb_user set name=@name, email=@email, phone=@phone where uid=@uid', substitutionValues: {
        'name': name,
        'email': email,
        'phone': phone.replaceAll(RegExp(r'[-() ]'), ''),
        'uid': id,
      }).then((List value) {
        conn.close();
        redirectUser(context);
        success(context, 'Usuário atualizado com sucesso.');
      });
    });
    // await conn.query('update user set name=?, email=?, phone=? where uid=?',
    // [name, email, phone, id]);

    // conn.close();

    // redirectUser(context);

    // success(context, 'Usuário atualizado com sucesso.');

  }

  // Sign in with Google

  Future<dynamic> signInGoogle(context) async {
    Navigator.push(context, navigator('loading'));
    // Trigger the authentication flow
    // await connectSupadatabase().then((value) async {
    //   await value.auth.signInWithOAuth(Provider.google);
    // });

    // redirectUser(context);
    
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signIn(context) async {
    await signInGoogle(context).then((value) async {
      success(context, 'Usuário autenticado com sucesso');

      redirectUser(context, value);
    }).catchError((onError) {
      error(context, "Ocorreu um erro ao entrar: $onError");
    });

    Navigator.pop(context);
  }

  Future<void> redirectUser(context, [value]) async {
    // Navigator.pop(context);
      // var t = await getTypeUser() ?? 'Cliente';
      // success(context, t);
      // return;
      
    await getTypeUser().then((String? typeUser) async {
      
      if (typeUser == null) {
        await connectSupadatabase().then((insert) {
          insert.open();
          insert.query('insert into tb_user (uid, name, email, phone, type, image) values (@uid, @name, @email, @phone, @type, @image)', substitutionValues: {
            'uid': value.user?.uid,
            'name': value.user?.displayName,
            'email': value.user?.email,
            'phone': null,
            'type': 1,
            'image': value.user?.photoURL,
          });
          insert.close();
          // insert.from('tb_user').insert({
          //   'uid': value.user?.uid,
          //   'name': value.user?.displayName,
          //   'email': value.user?.email,
          //   'phone': null,
          //   'type': 1,
          //   'image': value.user?.photoURL,
          // });
          // insert.query('insert into user (uid, name, email, phone, type, image) values (?, ?, ?, ?, ?, ?)',
          //   [value.user?.uid, value.user?.displayName, value.user?.email, null, 1, value.user?.photoURL]);
        },);

        Navigator.pop(context);
        Navigator.push(
          context,
          navigator('home'),
        );

        return;
      } else {
        switch (typeUser) {
          case 'Cliente':
            Navigator.pop(context);
            Navigator.push(
              context,
              navigator('home'),
            );
            break;
          case 'Gerente':
            Navigator.pop(context);
            Navigator.push(
              context,
              navigator('home_manager'),
            );
            break;
          default:
            Navigator.pop(context);
            Navigator.push(
              context,
              navigator('home_employee'),
            );
            break;
        }
      }
    });
  }

  Future<void> updatePassword(context, String password) async {
    await FirebaseAuth.instance.currentUser?.updatePassword(password).then((value) {
      success(context, 'Senha atualizada com sucesso.');
    }).catchError((e) {
      error(context, 'Ocorreu um erro ao atualizar sua senha: ${e.code.toString()}');
    });
  }

  Future<List<Address>> getAddress() async {
    return await connectSupadatabase().then((conn) {
      return conn.query('''
        select id, street, district, number, city, state, zip, complement, reference, nickname
          from address 
          where uid = @uid and fg_active = true
          order by id desc
      ''', substitutionValues: {
        'uid': FirebaseAuth.instance.currentUser?.uid,
      }).then((List value) {
        conn.close();
        
        return value.map((e) => Address(
          id: e[0],
          street: e[1],
          district: e[2],
          number: e[3],
          city: e[4],
          state: e[5],
          zip: e[6],
          complement: e[7],
          reference: e[8],
          nickname: e[9],
        )).toList();
      });
    });
  }

  Future<void> updateAddress(context, Address address, String street, String district, int number, String nickname, [String? city, String? state, String? zip, String? complement, String? reference]) async {
    await connectSupadatabase().then((conn) async {
      await conn.query('update address set street=@street, district=@district, number=@number, city=@city, state=@state, zip=@zip, complement=@complement, reference=@reference, nickname=@nickname where id=@id', substitutionValues: {
        'street': street,
        'district': district,
        'number': number,
        'city': city,
        'state': state,
        'zip': zip,
        'complement': complement,
        'reference': reference,
        'nickname': nickname,
        'id': address.id,
      }).then((value) {
        success(context, 'Endereço atualizado com sucesso');
      }).catchError((onError) {
        error(context, 'Ocorreu um erro ao atualizar o endereço: $onError');
      });
      conn.close();
    });
  }

  Future<void> insertAddress(context, String street, String district, int number, String nickname, [String? city, String? state, String? zip, String? complement, String? reference]) async {
    await connectSupadatabase().then((conn) async {
      await conn.query('insert into address (street, district, number, city, state, zip, complement, reference, nickname, uid) values (@street, @district, @number, @city, @state, @zip, @complement, @reference, @nickname, @uid)', substitutionValues: {
        'street': street,
        'district': district,
        'number': number,
        'city': city,
        'state': state,
        'zip': zip,
        'complement': complement,
        'reference': reference,
        'nickname': nickname,
        'uid': FirebaseAuth.instance.currentUser?.uid,
      }).then((value) {
        success(context, 'Endereço cadastrado com sucesso.');
      });
      conn.close();
    });
  }

  Future<bool> isNickNameAddressExist(String nickname) async {
    return await connectSupadatabase().then((conn) async {
      return await conn.query('select nickname from address where nickname = @nickname and uid = @uid', substitutionValues: {
        'nickname': nickname,
        'uid': FirebaseAuth.instance.currentUser?.uid,
      }).then((List value) {
        conn.close();
        return value.isNotEmpty;
      });
    });
  }

  Future<void> updateImage(context, String image) async {
    await connectSupadatabase().then((conn) async {
      await conn.query('update tb_user set image=@image where uid=@uid', substitutionValues: {
        'image': image,
        'uid': FirebaseAuth.instance.currentUser?.uid,
      });
      conn.close();
    });
  }
}