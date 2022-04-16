// ignore_for_file: prefer_if_null_operators, unused_element, curly_braces_in_flow_control_structures, unnecessary_null_comparison, avoid_print, unused_catch_clause, empty_catches, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testproject/model/myuser.dart';
import 'package:testproject/theme/color.dart';
import 'package:testproject/viewmodel/view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _email, _sifre;
  final _formKey = GlobalKey<FormState>();

  void _formLogin() async {
    try {
      _formKey.currentState!.save();
      debugPrint("email: " + _email! + " şifre: " + _sifre!);
      final UserModel _userModel =
          Provider.of<UserModel>(context, listen: false);

      try {
        MyUser? _girisYapanUser =
            await _userModel.signInWithEmailandPassword(_email!, _sifre!);
        if (_girisYapanUser! != null)
          debugPrint(
            "giriş yapan user id : " + _girisYapanUser.userID.toString(),
          );
      } on FirebaseAuthException catch (e) {}
    } catch (e) {
      debugPrint("hata oluştu : " + e.toString());
    }
  }

  Future<void> _misafirGiris(BuildContext context) async {
    final UserModel _userModel = Provider.of<UserModel>(context, listen: false);
    try {
      MyUser? _user = await _userModel.signInAnonymously();
      print("Anonim Giriş Başarılı id : " + _user!.userID.toString());
    } catch (err) {
      print(err);
    }
  }

  Future<void> _googleIleGiris(BuildContext context) async {
    final UserModel _userModel = Provider.of<UserModel>(context, listen: false);
    try {
      MyUser? _user = await _userModel.signInWithGoogle();
      if (_user! != null) {
        print("google ile Giriş Başarılı id : " + _user.userID.toString());
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserModel _userModel = Provider.of<UserModel>(context);
    if (_userModel.user != null) {
      Future.delayed(Duration(milliseconds: 100), () {
        Navigator.of(context).pop();
      });
    }
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
      ),
      body: _userModel.state == ViewState.Idle
          ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Giriş Sayfası",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "İstenilen bilgileri doldurarak sisteme giriş yapabilirsiniz.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            height: 55,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: bgColor,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.mail),
                                hintText: "Mail Adresi",
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 55,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: bgColor,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.vpn_key),
                                hintText: "Şifre",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () => _formLogin(),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            "Giriş Yap",
                            style: TextStyle(
                              fontSize: 20,
                              color: bgColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: Colors.grey.withOpacity(0.25),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () => _googleIleGiris(context),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: bgColor,
                              border: Border.all(
                                width: 1,
                                color: Colors.white,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.email,
                                color: buttonColor,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: bgColor,
                            border: Border.all(
                              width: 1,
                              color: Colors.white,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.facebook,
                              color: Colors.blue,
                              size: 30,
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: bgColor,
                            border: Border.all(
                              width: 1,
                              color: Colors.white,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.apple,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
