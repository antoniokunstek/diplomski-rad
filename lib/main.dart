import 'package:core/pages/welcome_screen.dart';
import 'package:diplomski_rad_accounts_module/bloc/account_bloc.dart';
import 'package:diplomski_rad_transactions_module/bloc/transaction_bloc.dart';
import 'package:diplomski_rad_user_module/bloc/login/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    // BlocProvider(create: (context) => AuthenticationBloc()),
    BlocProvider(create: (context) => AccountsBloc()),
    BlocProvider(create: (context) => TransactionBloc())
  ], child: BudgetPlannerApp()));
}


class BudgetPlannerApp extends StatelessWidget {
  const BudgetPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget Planner - Master thesis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff904E55)),
        useMaterial3: true
      ),
      home: const WelcomePage(),
    );
  }
}




