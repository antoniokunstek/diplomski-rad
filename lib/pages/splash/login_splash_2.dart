import 'package:flutter/material.dart';

import '../../common/app_colors.dart';

class LoginSplashScreenTwo extends StatelessWidget {
  const LoginSplashScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColors.backgroundColor,
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/icons/finance_2.png"),
                const SizedBox(height: 10),
                const Text("Reach your goals",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    )),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: const Text("“The only man who never makes mistakes is the man who never does anything.” ― Theodore Roosevelt",
                      style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                )
              ],
            )
        ),
      ),
    );
  }
}
