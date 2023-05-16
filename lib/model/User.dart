import 'package:tcc/model/Address.dart';

class UserList{
  String uid;
  String name;
  String email;
  String phone;
  String image;
  int type;
  List<Address>? address;

  UserList({
    required this.uid, 
    required this.name, 
    required this.email, 
    required this.phone, 
    required this.type,
    this.address,
    this.image = 'https://firebasestorage.googleapis.com/v0/b/tcc-2021-1.appspot.com/o/user%2Fuser.png?alt=media&token=8b3b7b1e-7b7e-4b0a-8b0a-4b0b0b0b0b0b'
  });
}