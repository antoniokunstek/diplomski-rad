import 'package:core/pages/forms/login_form.dart';
import 'package:core/pages/forms/register_form.dart';
import 'package:flutter/material.dart';

import '../../common/app_colors.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {

  final ButtonStyle bs = ElevatedButton.styleFrom(
    backgroundColor: AppColors.mainAppColor,
    textStyle: const TextStyle(fontSize: 20)
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: AppColors.backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
                const SizedBox(height: 70),
                Image.asset("assets/icons/finance_3.png"),
                const SizedBox(height: 10),
                const Text("Where is your money going?",  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                )),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Text("“Money, like emotions, is something you must control to keep your life on the right track.” ― Natasha Munson",
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                ),
                const SizedBox(height: 25),
                const Text("Start tracking your expenses today",  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                )),
                const SizedBox(height: 5),
                ElevatedButton(onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => (const RegisterForm())));
                },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainAppColor,
                        fixedSize: const Size(275, 50),
                        textStyle: const TextStyle(fontSize: 20)
                    ),
                    child: Text("Register", style: TextStyle(color: AppColors.buttonText),)),
                const SizedBox(height: 20),
                const Text("Already a member?", style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                )),
                const SizedBox(height: 5),
                ElevatedButton(onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => (const LoginForm())));
                },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryAppColor,
                        fixedSize: const Size(275, 50),
                        textStyle: const TextStyle(fontSize: 20)
                    ),
                    child: Text("Login", style: TextStyle(color: AppColors.buttonText)))
            ],
          ),
        )
     );
    }
}
