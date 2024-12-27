import 'models/models.dart';

abstract class UserRepository {
  Stream<MyUser?> get user;
//checking autenthication
  Future<MyUser> signUp(MyUser myUser, String password);
//sign up metho
  Future<void> setUserData(MyUser user);

  Future<void> signIn(String email, String password);

  Future<void> logOut();
}
// ini udah kode bawaan paste aja, <MyUser> itu class, jadi nanti harus bikin classnya
// we will use it as a method
//we implements those method in firebase user repo

//(2)
// di sini ada eroro karena belum bikin MyUser class-nya