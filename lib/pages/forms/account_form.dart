import 'package:core/pages/user/wallets/accounts_page.dart';
import 'package:diplomski_rad_accounts_module/bloc/account_bloc.dart';
import 'package:diplomski_rad_accounts_module/bloc/account_event.dart';
import 'package:diplomski_rad_accounts_module/bloc/account_state.dart';
import 'package:diplomski_rad_accounts_module/model/account_form_model.dart';
import 'package:flutter/material.dart';

import '../../common/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountForm extends StatefulWidget {
  final String? jwtToken;
   AccountForm({
    required this.jwtToken
});

  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  final TextEditingController _accountName = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();


  void _onCreateButtonPressed(BuildContext context) {
    BlocProvider.of<AccountsBloc>(context).add(
        OnCreateButtonPressed(authJwtToken: widget.jwtToken, model: AccountFormModel(accountName: _accountName.text, accountNumber: _accountNumber.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add new account')),
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      body: BlocListener<AccountsBloc, AccountState>(
        listener: (context, state) {
          if(state is AccountCreated) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WalletPage()));
          } else if (state is AccountsFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Greška prilikom kreiranja novog računa!"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<AccountsBloc, AccountState>(
          builder: (context, state) {
            return SingleChildScrollView(
              reverse: true,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 75),
                  Image.asset("assets/icons/login.png"),
                  const SizedBox(height: 5),
                  const Text("New account", style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  )),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _accountName,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Account name",
                        prefixIcon: const Icon(Icons.monetization_on),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _accountNumber,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Account number",
                        prefixIcon: const Icon(Icons.credit_card),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                  const SizedBox(height: 40),
                  state is AccountLoading ? const CircularProgressIndicator()
                      : ElevatedButton(onPressed: () => _onCreateButtonPressed(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainAppColor,
                          fixedSize: const Size(275, 50),
                          textStyle: const TextStyle(fontSize: 20)
                      ),
                      child: Text("Add", style: TextStyle(color: AppColors.buttonText))),

                  Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
