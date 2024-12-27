//copy 2 method pertama dari user.dart dan class-nya tambahin entity
class MyUserEntity {
  String userId;
  String email;
  String name;
  bool hasActiveCart;

  MyUserEntity(
      {required this.userId,
      required this.email,
      required this.name,
      required this.hasActiveCart});
//[2]
//create toDocuement sama fromDocument method
  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'hasActiveCart': hasActiveCart,
    };
  }

//why we do that?
//we cannot send object like: 'MyUSer' object to the firebase, we need a formulaize type of data
//it turned object to json file which database will understand
//database understand map, string, number but not object
//it break your object of your custom class down into this sort of thing in order to put it somewhere
//it's all whats going on
//[3]
  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      userId: doc['userId'],
      email: doc['email'],
      name: doc['name'],
      hasActiveCart: doc['hasActiveCart'],
    );
  }
  //acces the parameter within the map (doc), tambahi doc ['name']
  // jadi di sini yang ketiga recieve map sama seperti di Map<Sring sialan itu dari database yg disebut doc
  // kita ngakses userId[3] within Map[2]
}

//lanjut import entities.dart ke user.dart
//abis tu import models di userrepo