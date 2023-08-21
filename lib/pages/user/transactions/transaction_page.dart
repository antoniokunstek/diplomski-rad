import 'package:core/pages/forms/transaction_form.dart';
import 'package:core/pages/user/transactions/transaction_card.dart';
import 'package:core/utils/shared_preferences_utils.dart';
import 'package:diplomski_rad_accounts_module/model/account.dart';
import 'package:diplomski_rad_transactions_module/bloc/transaction_bloc.dart';
import 'package:diplomski_rad_transactions_module/bloc/transaction_events.dart';
import 'package:diplomski_rad_transactions_module/bloc/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/app_colors.dart';

class TransactionPage extends StatefulWidget {
  Account account;

  TransactionPage({super.key,
  required this.account});

  @override
  State<TransactionPage> createState() => _TransactionPageState();

}

class _TransactionPageState extends State<TransactionPage> {

  @override
  void initState() {
    super.initState();
    _getAllTransactions(context);
  }

  void _getAllTransactions(BuildContext context) async {
    BlocProvider.of<TransactionBloc>(context).add(
        GetAllTransactions(accountId: widget.account.accountId,
        authJwtToken: await LocalStorage.getUserFromLocalStorage())
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.account.accountName),
      automaticallyImplyLeading: true),
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      body: BlocListener<TransactionBloc, TransactionState>(
        listener: (context, state) {

        },
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if(state is TransactionInitial || state is TransactionCreated) {
              _getAllTransactions(context);
              return const CircularProgressIndicator();
            }
            if(state is TransactionLoading) {
              return const CircularProgressIndicator();
            }
            if(state is TransactionFailure) {
              return Text("error");
            }
            if (state is TransactionLoaded) {
              return ListView.builder(itemCount: state.transaction.length,
                  itemBuilder: (context, index) {
                    return TransactionCard(state.transaction[index]);
                  });
            }
            return Text("error");

          }
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(

        child: const Icon(Icons.new_label_rounded),
        onPressed: () async => _pushToAddNewTransaction(
          context, widget.account.accountId, await LocalStorage.getUserFromLocalStorage()
        ),
      ),
    );
  }

  void _pushToAddNewTransaction(BuildContext context, String accountId, String? jwtToken) {
    Navigator.push(context,  MaterialPageRoute(builder: (context) => TransactionForm(
        accountId: accountId,
        jwtToken: jwtToken
    )));
  }
}
