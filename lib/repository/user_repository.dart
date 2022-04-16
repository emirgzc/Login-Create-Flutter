// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:testproject/locator.dart';
import 'package:testproject/model/myuser.dart';
import 'package:testproject/services/atuh_base.dart';
import 'package:testproject/services/database_base.dart';
import 'package:testproject/services/fake_auth_service.dart';
import 'package:testproject/services/firebase_auth_service.dart';
import 'package:testproject/services/firestore_db_service.dart';

// ignore: constant_identifier_names
enum AppMode { DEBUG, RELEASE }

class UserRepository implements AuthBase, DatabaseBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthenticationService _fakeAuthenticationService =
      locator<FakeAuthenticationService>();
  FirestoreDBService _firestoreService = locator<FirestoreDBService>();

  AppMode appMode = AppMode.RELEASE;

  @override
  Future<MyUser?> currentUser() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.currentUser();
    } else {
      MyUser? _user = await _firebaseAuthService.currentUser();
      return await _firestoreService.readUser(_user!.userID);
    }
  }

  @override
  Future<MyUser?> signInAnonymously() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signInAnonymously();
    } else {
      return await _firebaseAuthService.signInAnonymously();
    }
  }

  @override
  Future<MyUser?> signInWithEmailandPassword(
      String email, String password) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signInWithEmailandPassword(
          email, password);
    } else {
      MyUser? _user = await _firebaseAuthService.signInWithEmailandPassword(
          email, password);
      return await _firestoreService.readUser(_user!.userID);
    }
  }

  @override
  Future<MyUser?> createUserWithEmailandPassword(
      String email, String password) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.createUserWithEmailandPassword(
          email, password);
    } else {
      MyUser? _user = await _firebaseAuthService.createUserWithEmailandPassword(
          email, password);
      bool _sonuc = await _firestoreService.saveUser(_user);
      if (_sonuc) {
        return await _firestoreService.readUser(_user!.userID);
      } else {
        return null;
      }
    }
  }

  @override
  Future<MyUser?> signInWithGoogle() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signInWithGoogle();
    } else {
      MyUser? _user = await _firebaseAuthService.signInWithGoogle();
      bool _sonuc = await _firestoreService.saveUser(_user);
      debugPrint("sonuc : " + _sonuc.toString());
      if (_sonuc) {
        return await _firestoreService.readUser(_user!.userID);
      } else {
        return null;
      }
    }
  }

  @override
  Future<bool> signOut() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signOut();
    } else {
      return await _firebaseAuthService.signOut();
    }
  }

  @override
  Future<bool> updatePasswordWithEmail(String email) async {
    if (appMode == AppMode.DEBUG) {
      return false;
    } else {
      return await _firebaseAuthService.updatePasswordWithEmail(email);
    }
  }

  @override
  Future<MyUser> readUser(String userID) async {
    throw UnimplementedError();
  }

  @override
  Future<bool> saveUser(MyUser? user) async {
    throw UnimplementedError();
  }

  @override
  Future<MyUser?> getUserID(String writedID) {
    if (appMode == AppMode.DEBUG) {
      return _firestoreService.getUserID(writedID);
    } else {
      return _firestoreService.getUserID(writedID);
    }
  }
}
