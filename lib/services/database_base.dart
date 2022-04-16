import 'package:testproject/model/myuser.dart';

abstract class DatabaseBase {
  Future<bool> saveUser(MyUser? user); //useri kaydetmek için
  Future<MyUser> readUser(String userID); //useri okumak için
  Future<MyUser?> getUserID(String writedID);
}
