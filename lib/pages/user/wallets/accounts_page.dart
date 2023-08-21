import 'package:core/common/app_colors.dart';
import 'package:core/pages/user/wallets/account_card.dart';
import 'package:core/utils/shared_preferences_utils.dart';
import 'package:diplomski_rad_accounts_module/bloc/account_bloc.dart';
import 'package:diplomski_rad_accounts_module/bloc/account_event.dart';
import 'package:diplomski_rad_accounts_module/bloc/account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../forms/account_form.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {

  @override
  void initState() {
    _onWidgetInit(context);
  }

  void _onWidgetInit(BuildContext context) async {
    BlocProvider.of<AccountsBloc>(context).add(
        OnWidgetInit(authJwtToken: await LocalStorage.getUserFromLocalStorage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false,title: const Text("My accounts")),
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.backgroundColor,
        body: BlocListener<AccountsBloc, AccountState>(
            listener: (context, state) {
                if (state is AccountsFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Greška prilikom otvaranja računa korisnika!"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: BlocBuilder<AccountsBloc, AccountState>(
              builder: (context, state) {
                if(state is AccountLoading) {
                  _onWidgetInit(context);
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if(state is AccountsLoaded) {
                  return ListView.builder(itemCount: state.accountList.length,
                        itemBuilder: (context, index) {
                      return AccountCard(state.accountList[index], context);
                    });
                } else {
                  return const Text("Error");
                }
              },
            ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.plus_one),
          onPressed: () async => _pushToCreateAccountPage(context, await LocalStorage.getUserFromLocalStorage()),
        ),
    );
  }

  void _pushToCreateAccountPage(BuildContext context, String? jwtToken) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AccountForm(
      jwtToken: jwtToken
    )));
  }
}
