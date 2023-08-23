import 'package:diplomski_rad_accounts_module/model/account.dart';

abstract class AccountState {
  const AccountState();
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountsLoaded extends AccountState {
  final List<Account> accountList;

  AccountsLoaded({
    required this.accountList
  });
}

class AccountCreated extends AccountState {}

class AccountsFailure extends AccountState {}