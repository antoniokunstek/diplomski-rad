import 'package:diplomski_rad_transactions_module/model/transaction.dart';
import 'package:flutter/material.dart';

Widget TransactionCard(Transaction transaction) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Card(
      elevation: 2.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue, // Customize the color as needed
          child: Text(transaction.transactionLabel[0].toUpperCase()),
        ),
        title: Text(transaction.transactionLabel),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount: ${transaction.amount} ${transaction.currency}'),
            Text('Date: ${transaction.dateOfTransaction}'),
            Text('Note: ${transaction.note}'),
          ],
        ),
        onTap: () {
          // Handle tapping on the statistic item if needed
        },
      ),
    ),
  );
}