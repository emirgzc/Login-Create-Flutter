import 'package:testproject/model/myuser.dart';

abstract class AuthBase {
  Future<MyUser?> currentUser(); //var olan useri getirme
  Future<MyUser?> signInAnonymously(); //anonim giriş yapmak için deneme amaçlı
  Future<bool> signOut(); //çıkış yapma işlemi için
  Future<MyUser?> signInWithGoogle(); //Google ile giriş yapmak için
  Future<MyUser?> signInWithEmailandPassword(
      String email, String password); //Email ve şifre ile giriş yapmak için
  Future<MyUser?> createUserWithEmailandPassword(
    String email,
    String password,
  ); //email ve şifre ile kayıt olmak için
  Future<bool> updatePasswordWithEmail(String email); //çıkış yapma işlemi için
}
