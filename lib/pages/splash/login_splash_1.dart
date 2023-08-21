import 'package:core/common/app_colors.dart';
import 'package:flutter/material.dart';

class LoginSplashScreenOne extends StatelessWidget {
  const LoginSplashScreenOne({super.key});

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
                Image.asset("assets/icons/finance_1.png"),
                const SizedBox(height: 10),
                const Text("Track your expenses",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  )),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: const Text("“Being rich is having money; being wealthy is having time.” — Margaret Bonanno",
                                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                )
              ],
            )
        ),
      ),
    );
  }
}
