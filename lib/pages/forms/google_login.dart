import 'package:core/common/app_colors.dart';
import 'package:diplomski_rad_user_module/bloc/login/authentication_event.dart';
import 'package:diplomski_rad_user_module/bloc/login/authentication_state.dart';
import 'package:diplomski_rad_user_module/bloc/multiple/authentication_bloc.dart';
import 'package:diplomski_rad_user_module/model/login_form.dart';
import 'package:diplomski_rad_user_module/model/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../utils/shared_preferences_utils.dart';
import '../user/wallets/accounts_page.dart';

class GoogleLoginForm extends StatefulWidget {
  IAuthenticationBloc authenticationBloc;

  GoogleLoginForm({
    super.key,
    required this.authenticationBloc
  });

  @override
  State<GoogleLoginForm> createState() => _GoogleLoginFormState();
}

class _GoogleLoginFormState extends State<GoogleLoginForm> {
  GoogleSignIn googleSignIn = GoogleSignIn();
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
              return Scaffold(
                backgroundColor: AppColors.backgroundColor,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: () async {
                        GoogleAuthenticationBloc bloc = widget.authenticationBloc as GoogleAuthenticationBloc;
                        bloc.add(OnRegisterButtonPressed(registerModel: RegisterFormModel(name: "", surname: "", email: "", password: "")));
                      },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.mainAppColor,
                              fixedSize: const Size(275, 50),
                              textStyle: const TextStyle(fontSize: 20)
                          ),
                          child: Text("Register", style: TextStyle(color: AppColors.buttonText),)),
                      const SizedBox(height: 20),
                      ElevatedButton(onPressed: () {
                        GoogleAuthenticationBloc bloc = widget.authenticationBloc as GoogleAuthenticationBloc;
                        bloc.add(OnLoginButtonPressed(formModel: LoginFormModel(email: "", password: "")));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondaryAppColor,
                              fixedSize: const Size(275, 50),
                              textStyle: const TextStyle(fontSize: 20)
                          ),
                          child: Text("Login", style: TextStyle(color: AppColors.buttonText))),
                    ],
                  )
                )
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
