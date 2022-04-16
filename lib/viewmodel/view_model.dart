// ignore_for_file: constant_identifier_names, prefer_final_fields, override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:testproject/locator.dart';
import 'package:testproject/model/myuser.dart';
import 'package:testproject/repository/user_repository.dart';
import 'package:testproject/services/atuh_base.dart';
import 'package:testproject/services/database_base.dart';

enum ViewState { Idle, Busy }

class UserModel with ChangeNotifier implements AuthBase, DatabaseBase {
  ViewState _state = ViewState.Idle;
  UserRepository _userRepository = locator<UserRepository>();
  MyUser? _user;
  String? emailHataMesaji;
  String? email2HataMesaji;
  String? sifreHataMesaji;

  MyUser? get user => _user;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel() {
    currentUser();
  }

  @override
  Future<MyUser?> currentUser() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.currentUser();
      return _user;
    } catch (e) {
      debugPrint("viewmodel current user hata : " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<MyUser?> signInAnonymously() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInAnonymously();
      return _user;
    } catch (e) {
      debugPrint("viewmodel current user hata : " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<MyUser?> signInWithGoogle() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInWithGoogle();
      return _user;
    } catch (e) {
      debugPrint("viewmodel sign in user hata : " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      debugPrint("viewmodel current user hata : " + e.toString());
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<MyUser?> signInWithEmailandPassword(
      String email, String password) async {
    if (_emailSifreKontrol(email, password)) {
      try {
        state = ViewState.Busy;
        _user =
            await _userRepository.signInWithEmailandPassword(email, password);
        state = ViewState.Idle;
        return _user;
      } finally {
        state = ViewState.Idle;
      }
    } else {
      return null;
    }
  }

  @override
  Future<MyUser?> createUserWithEmailandPassword(
      String email, String password) async {
    if (_emailSifreKontrol(email, password)) {
      try {
        state = ViewState.Busy;
        _user = await _userRepository.createUserWithEmailandPassword(
            email, password);
        state = ViewState.Idle;
        return _user;
      } finally {
        state = ViewState.Idle;
      }
    } else {
      return null;
    }
  }

  bool _emailSifreKontrol(String email, String sifre) {
    var sonuc = true;

    if (sifre.length < 6) {
      sifreHataMesaji = "En az 6 karakter olmalı.";
      sonuc = false;
    } else {
      sifreHataMesaji = null;
    }
    if (!email.contains('@')) {
      emailHataMesaji = "Geçersiz email adresi.";
      sonuc = false;
    } else {
      emailHataMesaji = null;
    }

    return sonuc;
  }

  bool _emailKontrol(String email) {
    var sonuc = true;

    if (!email.contains('@')) {
      email2HataMesaji = "Geçersiz email adresi.";
      sonuc = false;
    } else {
      email2HataMesaji = null;
    }

    return sonuc;
  }

  @override
  Future<bool> updatePasswordWithEmail(String email) async {
    try {
      if (_emailKontrol(email)) {
        state = ViewState.Busy;
        var sonuc = await _userRepository.updatePasswordWithEmail(email);
        return sonuc;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("user model hata : " + e.toString());
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<MyUser> readUser(String userID) {
    throw UnimplementedError();
  }

  @override
  Future<bool> saveUser(MyUser? user) {
    throw UnimplementedError();
  }

  @override
  Future<bool> updateProfilFoto(String userID, String profilFotoUrl) {
    throw UnimplementedError();
  }

  @override
  Future<MyUser?> getUserID(String writedID) async {
    var userID = await _userRepository.getUserID(writedID);
    return userID;
  }
}
