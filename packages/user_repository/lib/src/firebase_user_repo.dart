import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_repository/src/entities/entities.dart';
import 'package:user_repository/src/models/user.dart';
import 'package:user_repository/src/user_repo.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  //construct firebaseuth
  FirebaseUserRepo({
    //take parameter of firebaseauth
    FirebaseAuth? firebaseAuth,
    // : (if) ?? (if nothing provided)
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<MyUser?> get user {
    return _firebaseAuth.authStateChanges().flatMap((firebaseUser) async* {
      if (firebaseUser == null) {
        yield MyUser.empty;
      } else {
        yield await usersCollection.doc(firebaseUser.uid).get().then((value) =>
            MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!)));
      }
    });
  }
//it's ging to change everytime the app detect new user being connected
//stream itu jalan terus, beda sama future. Jadi kalo kita buka app, stream-nya itu jalan terus ngecekin user either sign in/sign out. Kalo future cuma sekali check
//* di async itu buat yield, kalo async itu buat future
//user collection dari line 12 itu
//abis itu diakses pake .doc, abis itu didapetin pake .get, terus

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  //jadi wrap method di try and cacth
  //pake rethrow biar buang eror, block will cacth the eror and send failure stage to app

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email, password: password);

      myUser.userId = user.user!.uid;
      return myUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

//so when the user click sign up, it gonna comes to line 54. then firebaseauth gonna create user email and pasword
//line 57: then it gonna let the user set userId to the one that was provided by firebaseauth
//return myUser becs myUser changed within the method bcs the id now is the one that firebaseauth gave
  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try {
      await usersCollection
          .doc(myUser.userId)
          .set(myUser.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
//eror karena kita harus import packagesnya dulu
//jadi ke yaml file dan pake firebase_auth sama cloud_firestore
//terus import FirebaseAuth sama FirebaseFirestore, shortcut: ctrl+.

//FirebaseUserrepo eror karena implements UserRepository class yg ada di user_repo.dart, dan 
// di user_repo.dart ga ada kelasnya. Jadi create override ajaa
// implenet method nanti, urusin MyUser class dulu di user_repo
//--------------------------
//user repo kelar, entity kelar, ini masih eror
//hapus aja dari bawah sampai override dan bikin lagi (FirebaseUserRepo)
//--------------------------
//kalo dah kelar lanjur user_repo.dart dan export semua (entities, models, user_repo, firebaseuserrepo)



//-----------------------------------------------------//--------------------------------
// lanjut set-set gatau ngapain
//urutin dari stream, Sign In, Sign Up, Log Out, setUserData