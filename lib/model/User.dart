class UserList{
  String uid;
  String name;
  String email;
  String phone;
  int type;

  UserList({required this.uid, required this.name, required this.email, required this.phone, required this.type});

  factory UserList.fromJson(Map<String, dynamic> json) {
    return UserList(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'email': email,
    'phone': phone,
    'type': type,
  };
}