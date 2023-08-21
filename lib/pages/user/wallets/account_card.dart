
import 'package:core/pages/user/transactions/transaction_page.dart';
import 'package:diplomski_rad_accounts_module/model/account.dart';
import 'package:flutter/material.dart';


Widget AccountCard(Account account, BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Card(
      elevation: 2.0,
      child: ListTile(
        leading: CircleAvatar(
          child: Text(account.accountName[0].toUpperCase()),
        ),
        title: Text(account.accountName),
        subtitle: Text('Account Number: ${account.accountNumber ?? 'N/A'}'),
        trailing: Text(
          '${account.domicileCurrency} ${account.amount}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TransactionPage(account: account)));
        },
      ),
    ),
  );
}