import 'package:tcc/model/Address.dart';

class UserList{
  String uid;
  String name;
  String email;
  String phone;
  String? image;
  int type;
  List<Address>? address;

  UserList({
    required this.uid, 
    required this.name, 
    required this.email, 
    required this.phone, 
    required this.type,
    this.address,
    this.image,
  });
}