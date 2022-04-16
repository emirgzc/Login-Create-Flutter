// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testproject/model/myuser.dart';
import 'package:testproject/services/database_base.dart';

class FirestoreDBService implements DatabaseBase {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<MyUser> readUser(String userID) async {
    //verilen id değerine göre veri okuma
    DocumentSnapshot<Map<String, dynamic>> _okunanUser =
        await _firebaseFirestore.collection("users").doc(userID).get();
    Map<String, dynamic>? _okunanUserBilgileriMap = _okunanUser.data();
    MyUser _okunanUserBilgilerNesne = MyUser.fromMap(_okunanUserBilgileriMap!);
    print("okunan user bilgileri nesnesi : " +
        _okunanUserBilgilerNesne.toString());
    return _okunanUserBilgilerNesne;
  }

  @override
  Future<bool> saveUser(MyUser? user) async {
    //alınan user bilgilerini database içine kaydetme
    try {
      DocumentSnapshot<Map<String, dynamic>> _okunanUser =
          await _firebaseFirestore.doc("users/${user!.userID}").get();
      if (_okunanUser.data() == null) {
        await _firebaseFirestore
            .collection("users")
            .doc(user.userID)
            .set(user.toMap());
        return true;
      }
      Map<String, dynamic>? _okunanUserBilgileriMap = _okunanUser.data();
      MyUser _okunanUserBilgileriNesne =
          MyUser.fromMap(_okunanUserBilgileriMap!);
      print("okunan user nesnesi : " + _okunanUserBilgileriNesne.toString());
      return true;
    } catch (e) {
      debugPrint("Save User Hata : " + e.toString());
      return false;
    }
  }

  @override
  Future<MyUser?> getUserID(String writedID) async {
    MyUser? thisUserID;
    QuerySnapshot<Map<String, dynamic>> userID = await _firebaseFirestore
        .collection("users")
        .where("userID", isEqualTo: writedID)
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> tekUser in userID.docs) {
      MyUser _tekUser = MyUser.fromMap(tekUser.data());
      thisUserID = _tekUser;
    }

    return thisUserID;
  }
}
