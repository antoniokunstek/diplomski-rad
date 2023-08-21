import 'package:core/common/app_colors.dart';
import 'package:core/pages/splash/login_splash_1.dart';
import 'package:core/pages/splash/login_splash_3.dart';
import 'package:flutter/material.dart';

import 'login_splash_2.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double? currentPage = 0.0;
  final _pageViewController = PageController();

  List<Widget> listOfWidgets = [
    const LoginSplashScreenOne(),
    const LoginSplashScreenTwo(),
    const LoginOrRegisterPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
              controller: _pageViewController,
              itemCount: listOfWidgets.length,
              itemBuilder: (BuildContext context, int index) {
                _pageViewController.addListener(() {
                  setState(() {
                    currentPage = _pageViewController.page;
                  });
                });
                return listOfWidgets[index];
              }
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 100,
            child: Container(
              color: AppColors.backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                    listOfWidgets.length,
                        (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          _pageViewController.animateToPage(index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: currentPage == index
                              ? AppColors.mainAppColor
                              : AppColors.secondaryAppColor,
                        ),
                      ),
                    )),
              ),
            ),
          ),
        ],
      )
    );
  }
}
