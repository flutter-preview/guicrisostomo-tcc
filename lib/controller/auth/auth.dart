import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tcc/controller/postgres/utils.dart';
import 'package:tcc/model/Address.dart';
import 'package:tcc/model/User.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/snackBars.dart';
      
class LoginController {
  static LoginController? _instance;
  static LoginController get instance => _instance ?? LoginController();

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
    GoRouter.of(context).push('/loading');
    
    (FirebaseAuth.instance.currentUser?.uid != null) ? {
      success(context, 'Usuário autenticado com sucesso.'),
    } : {
      await FirebaseAuth.instance.signInAnonymously().then((value) async {
        await saveDatasUser(value.user?.uid, 'Visitante', 'visitante@hungry.com', null, 1, context);
      }).catchError((e) {
        error(context, 'Ocorreu um erro ao fazer login: ${e.code.toString()}');
      })
    };
  }

  Future<int?> getPhoneNumberUser() async {
    return await connectSupadatabase().then((conn) async {
      return await conn.query('select phone from tb_user where uid = @id', substitutionValues: {
        'id': FirebaseAuth.instance.currentUser?.uid,
      }).then((List value) {
        conn.close();
        return value[0][0];
      });
    });
  }

  Future<UserList> userLogin() async {
    return await connectSupadatabase().then((conn) async {
      return await conn.query('''
        select uid, name, email, phone, type, image from tb_user where uid = @uid
      ''', substitutionValues: {
        'uid': FirebaseAuth.instance.currentUser?.uid,
      }).then((List value) {
        conn.close();

        // NumberFormat phoneFormat = NumberFormat("'\('00'\)'00000,0000");
        
        String phoneNumber = value[0][3].toString().replaceAllMapped(RegExp(r'(\d{2})(\d{4})(\d+)'), (Match m) => "(${m[1]}) ${m[2]}-${m[3]}");

        return UserList(
          uid: value[0][0],
          name: value[0][1],
          email: value[0][2],
          phone: phoneNumber,
          type: value[0][4],
          image: value[0][5],
        );
      });
    });
  }

  Future<void> syncPhoneNumberFirebase(int phoneNumber, context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+55 $phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          error(context, 'O número de telefone fornecido é inválido.');
        } else if (e.code == 'too-many-requests') {
          error(context, 'O número de solicitações excedeu o limite. Tente novamente mais tarde.');
        } else if (e.code == 'session-expired') {
          error(context, 'A sessão expirou. Tente novamente mais tarde.');
        } else if (e.code == 'invalid-verification-code') {
          error(context, 'O código de verificação é inválido.');
        } else {
          error(context, 'Ocorreu um erro ao verificar o número de telefone: ${e.code.toString()}');
        }

      },
      codeSent: (String verificationId, int? resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        String smsCode = '';

        await showDialog(
          context: context, 
          builder: (context) => AlertDialog(
            title: const Text('Digite o código de verificação'),
            content: TextField(
              onChanged: (value) {
                smsCode = value;
              },
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // ;
                  // Create a PhoneAuthCredential with the code
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

                  // Sign the user in (or link) with the credential
                  
                  FirebaseAuth.instance.currentUser?.linkWithCredential(credential).then((value) async {
                    
                    success(context, 'Número de telefone verificado com sucesso.');
                    
                    await savePhoneDataBase(phoneNumber, context);
                  }).onError((e, stackTrace) {
                    error(context, 'Ocorreu um erro ao verificar o número de telefone: ${e.toString()}');
                  });
                },
                child: const Text('Confirmar'),
              ),
            ],
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> savePhoneNumber(int phoneNumber, context) async {
    GoRouter.of(context).push('/loading');
    await syncPhoneNumberFirebase(phoneNumber, context);
    
  }

  Future<void> savePhoneDataBase(int phoneNumber, BuildContext context) async {
    await connectSupadatabase().then((conn) async {
      await conn.query('update tb_user set phone=@phone where uid=@uid', substitutionValues: {
        'phone': phoneNumber,
        'uid': FirebaseAuth.instance.currentUser?.uid,
      });
      conn.close();
    });

    GoRouter.of(context).pop();
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
    GoRouter.of(context).push('/loading');

    (FirebaseAuth.instance.currentUser == null) ?
      await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((res) async {
          
          saveDatasUser(res.user?.uid, name, email, phone.replaceAll(RegExp(r'[-() ]'), ''), 1, context);
          res.user?.updateDisplayName(name);
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
      })
    :
      await FirebaseAuth.instance.currentUser?.linkWithCredential(EmailAuthProvider.credential(email: email, password: password)).then((value) async {
        await updateUser(value.user?.uid, name, email, phone.replaceAll(RegExp(r'[-() ]'), ''), context);
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

  }

  Future<void> login(context, String email, String senha) async {
    GoRouter.of(context).push('/loading');

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((res) async {
      success(context, 'Usuário autenticado com sucesso.');
      // ;
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

  }

  Future<void> forgetPassword(String email, context) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      success(context, 'E-mail de recuperação de senha enviado com sucesso');
    }).catchError((e) {
      error(context, 'Ocorreu um erro ao enviar seu e-mail de recuperação de senha: ${e.code.toString()}');
    });

    GoRouter.of(context).go('/');
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
    GoRouter.of(context).go('/loading');

    final GoogleSignIn googleSignIn = GoogleSignIn();

    if (await googleSignIn.isSignedIn() == true) {
      await googleSignIn.signOut();
    }

    if (FirebaseAuth.instance.currentUser?.isAnonymous == true) {
      await deleteUser(FirebaseAuth.instance.currentUser?.uid ?? '');
      await FirebaseAuth.instance.currentUser?.delete();
    }
    
    await FirebaseAuth.instance.signOut();

    clearGlobalVariables();
    
    GoRouter.of(context).go('/');
  }

  Future<void> updateUser(id, name, email, phone, context, [bool hasRedirect = true]) async {
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

        if (hasRedirect) {
          redirectUser(context);
        }

        FirebaseAuth.instance.currentUser?.updateDisplayName(name);
        FirebaseAuth.instance.currentUser?.updateEmail(email);
        FirebaseAuth.instance.currentUser?.updatePhoneNumber(phone.replaceAll(RegExp(r'[-() ]'), ''));
        FirebaseAuth.instance.currentUser?.reload();
        
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
    return (FirebaseAuth.instance.currentUser == null) ? await FirebaseAuth.instance.signInWithCredential(credential) : await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
  }

  Future<void> signIn(context) async {
    GoRouter.of(context).push('/loading');

    bool isUserAlreajyExist = FirebaseAuth.instance.currentUser != null;
    await signInGoogle(context).then((value) async {
      success(context, 'Usuário autenticado com sucesso');

      redirectUser(context, value, isUserAlreajyExist);
    }).catchError((onError) {
      // error(context, "Ocorreu um erro ao entrar: $onError");
      print(onError);
    });

    
  }

  Future<void> redirectUser(context, [value, bool isUserAlreajyExist = false]) async {
    // ;
      // var t = await getTypeUser() ?? 'Cliente';
      // success(context, t);
      // return;

    if (FirebaseAuth.instance.currentUser?.emailVerified == false && FirebaseAuth.instance.currentUser?.isAnonymous == false) {
      return await FirebaseAuth.instance.currentUser?.sendEmailVerification().then((value) {
        GoRouter.of(context).go('/verify_email');
        success(context, 'E-mail de verificação enviado com sucesso.');
      }).catchError((e) {
        error(context, 'Ocorreu um erro ao enviar o e-mail de verificação: ${e.code.toString()}');
      });
    }
      
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
      
        GoRouter.of(context).pop();
        GoRouter.of(context).go('/home');

        return;
      } else {
        if (isUserAlreajyExist == true) {
          await LoginController.instance.updateUser(FirebaseAuth.instance.currentUser?.uid, value.user?.displayName, value.user?.email, FirebaseAuth.instance.currentUser?.phoneNumber?.replaceAll('+55', ''), context);
        }

        switch (typeUser) {
          case 'Cliente':
            GoRouter.of(context).pop();
            GoRouter.of(context).go('/home');
            break;
          case 'Gerente':
            GoRouter.of(context).pop();
            GoRouter.of(context).go('/home_manager');
            break;
          default:
            GoRouter.of(context).pop();
            GoRouter.of(context).go('/home_employee');
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

  Future<Address> getAddressId(int idAddress) async {
    return await connectSupadatabase().then((conn) {
      return conn.query('''
        select id, street, district, number, city, state, zip, complement, reference, nickname
          from address 
          where id = @id and uid = @uid
          order by id desc
      ''', substitutionValues: {
        'id': idAddress,
        'uid': FirebaseAuth.instance.currentUser?.uid,
      }).then((List value) {
        conn.close();
        
        return Address(
          id: value[0][0],
          street: value[0][1],
          district: value[0][2],
          number: value[0][3],
          city: value[0][4],
          state: value[0][5],
          zip: value[0][6],
          complement: value[0][7],
          reference: value[0][8],
          nickname: value[0][9],
        );
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
      });
      conn.close();
    });
  }

  Future<void> deleteAddress(int id) async {
    await connectSupadatabase().then((conn) async {
      await conn.query('update address set fg_active = false where id = @id', substitutionValues: {
        'id': id,
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

  Future<int> getTypeUserText(String typeUser) async {
    return await connectSupadatabase().then((conn) async {
      return await conn.query('select id from type_user where name = @name', substitutionValues: {
        'name': typeUser,
      }).then((List value) {
        conn.close();
        return value[0][0];
      });
    });
  }

  Future<void> updateTypeUser(String typeUser) async {
    int type = await getTypeUserText(typeUser);

    await connectSupadatabase().then((conn) async {
      await conn.query('update tb_user set type = @type where uid=@uid', substitutionValues: {
        'type': type,
        'uid': FirebaseAuth.instance.currentUser?.uid,
      });
      conn.close();
    });
  }
}