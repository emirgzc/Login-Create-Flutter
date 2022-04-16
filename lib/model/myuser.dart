import 'dart:math';

class MyUser {
  final String userID;
  String? nameSurname;
  String? email;
  String? userName;

  MyUser({
    required this.userID,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      "userID": userID,
      "nameSurname": userName ??
          email!.substring(0, email!.indexOf("@")) + randomSayiUret2(),
      "email": email,
      "userName": userName ??
          email!.substring(0, email!.indexOf("@")) + randomSayiUret1(),
    };
  }

  MyUser.fromMap(Map<String, dynamic> map)
      : userID = map["userID"],
        nameSurname = map["nameSurname"],
        email = map["email"],
        userName = map["userName"];

  @override
  String toString() {
    return "User{userID}: $userID,nameSurname: $nameSurname, email: $email, userName:$userName";
  }

  String randomSayiUret1() {
    int rastgeleSayi = Random().nextInt(999999);
    return rastgeleSayi.toString();
  }

  String randomSayiUret2() {
    int rastgeleSayi = Random().nextInt(99);
    return rastgeleSayi.toString();
  }
}
