import 'package:core/pages/user/wallets/accounts_page.dart';
import 'package:core/utils/shared_preferences_utils.dart';
import 'package:diplomski_rad_user_module/bloc/login/authentication_bloc.dart';
import 'package:diplomski_rad_user_module/bloc/login/authentication_event.dart';
import 'package:diplomski_rad_user_module/bloc/login/authentication_state.dart';
import 'package:diplomski_rad_user_module/bloc/multiple/authentication_bloc.dart';
import 'package:diplomski_rad_user_module/model/login_form.dart';
import 'package:flutter/material.dart';

import '../../common/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  IAuthenticationBloc authenticationBloc;
  LoginForm({
    super.key,
    required this.authenticationBloc
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<IAuthenticationBloc> (
      create: (context) => widget.authenticationBloc,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.backgroundColor,
        body: BlocListener<IAuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
        if(state is AuthenticationSuccess) {
          _saveUserAndPushToHomePage(state.data.jwtToken);
    } else if (state is AuthenticationFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
        content: Text("Greška prilikom autorizacije korisnika!"),
        backgroundColor: Colors.red,
        ),
        );
        }
        },
          child: BlocBuilder<IAuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return SingleChildScrollView(
                reverse: true,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 75),
                    Image.asset("assets/icons/login.png"),
                    const SizedBox(height: 5),
                    const Text("Login", style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    )),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _controllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Email address",
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      controller: _controllerPassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.password),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                    const SizedBox(height: 40),
                    state is AuthenticationProcessRequest ? const CircularProgressIndicator()
                        : ElevatedButton(onPressed: () async {
                            RestAPIAuthentication bloc = widget.authenticationBloc as RestAPIAuthentication;
                            bloc.add(OnLoginButtonPressed(formModel: LoginFormModel(email: _controllerEmail.text, password: _controllerPassword.text)));
                            },
                            style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mainAppColor,
                            fixedSize: const Size(275, 50),
                            textStyle: const TextStyle(fontSize: 20)
                            ),
                        child: Text("Login", style: TextStyle(color: AppColors.buttonText))),

                    Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
                  ],
                ),
              );
            },
          ),
        ),
      )
    );
  }

  void _saveUserAndPushToHomePage(String token) {
      LocalStorage.saveUserInLocalStorage(token);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => (const WalletPage())));
  }
}
