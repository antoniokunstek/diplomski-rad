import 'package:core/pages/user/wallets/accounts_page.dart';
import 'package:diplomski_rad_user_module/bloc/login/authentication_bloc.dart';
import 'package:diplomski_rad_user_module/bloc/login/authentication_event.dart';
import 'package:diplomski_rad_user_module/bloc/login/authentication_state.dart';
import 'package:diplomski_rad_user_module/bloc/multiple/authentication_bloc.dart';
import 'package:diplomski_rad_user_module/model/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/app_colors.dart';
import '../../utils/shared_preferences_utils.dart';

class RegisterForm extends StatefulWidget {
  IAuthenticationBloc authenticationBloc;
  RegisterForm({
    super.key,
    required this.authenticationBloc
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerSurname = TextEditingController();
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
    Image.asset("assets/icons/register.png"),
    const SizedBox(height: 5),
    const Text("Register", style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold
    )),
    const SizedBox(height: 20),
    TextFormField(
    controller: _controllerName,
    keyboardType: TextInputType.name,
    decoration: InputDecoration(
    labelText: "Name",
    prefixIcon: const Icon(Icons.person),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10)
    )
    ),
    ),
    const SizedBox(height: 20),
    TextFormField(
    controller: _controllerSurname,
    keyboardType: TextInputType.name,
    decoration: InputDecoration(
    labelText: "Surname",
    prefixIcon: const Icon(Icons.person),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10)
    )
    ),
    ),
    const SizedBox(height: 20),
    TextFormField(
    controller: _controllerEmail,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
    labelText: "Email",
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
    const SizedBox(height: 25),
    state is AuthenticationProcessRequest ? const CircularProgressIndicator()
        : ElevatedButton(onPressed: () async {
      RestAPIAuthentication bloc = widget.authenticationBloc as RestAPIAuthentication;
      bloc.add(OnRegisterButtonPressed(registerModel: RegisterFormModel(name: _controllerName.text, surname: _controllerSurname.text, email: _controllerEmail.text, password: _controllerPassword.text)));
    },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.mainAppColor,
            fixedSize: const Size(275, 50),
            textStyle: const TextStyle(fontSize: 20)
        ),
    child: Text("Register", style: TextStyle(color: AppColors.buttonText))),

    Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
    ],
    ),
    );

            }
          )
        )
    )
    );
  }

  void _saveUserAndPushToHomePage(String token) {
    LocalStorage.saveUserInLocalStorage(token);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => (const WalletPage())));
  }
}


//MOVE
