import 'dart:async';

import 'package:core/common/app_colors.dart';
import 'package:core/pages/splash/login_screen.dart';
import 'package:core/pages/user/wallets/accounts_page.dart';
import 'package:core/utils/shared_preferences_utils.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String? _userJwt;

  Future<void> getUser() async {
    _userJwt = await LocalStorage.getUserFromLocalStorage();
  }

  @override
  void initState() {
    super.initState();
    getUser();
    startTime();
  }

  void pushToNewPage() {
    if(_userJwt == null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const WalletPage()));
    }
  }

  Timer startTime() {
    Duration duration = const Duration(seconds: 5);
    return Timer(duration, pushToNewPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/mybudget_logo.png"),
            const CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 5,
            )
          ],
        ),
      ),
    );
  }
}
