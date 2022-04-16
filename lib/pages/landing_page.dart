import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testproject/pages/login_page.dart';
import 'package:testproject/pages/root_page.dart';
import 'package:testproject/viewmodel/view_model.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserModel _userModel = Provider.of<UserModel>(context);

    if (_userModel.user == null) {
      return const LoginPage();
    } else {
      return const RootPage();
    }
  }
}
