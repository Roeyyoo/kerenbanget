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
