import 'dart:convert';

import 'package:diplomski_rad_transactions_module/exceptions/transaction_exception.dart';
import 'package:diplomski_rad_transactions_module/model/transaction.dart';
import 'package:diplomski_rad_transactions_module/model/transaction_form.dart';
import 'package:diplomski_rad_transactions_module/network/http_status.dart';
import 'package:diplomski_rad_transactions_module/network/response.dart';
import 'package:http/http.dart' as http;

const String httpUrl = 'http://10.0.2.2:9999';
// const String httpUrl = 'http://localhost:9999';

List<Transaction> getTransactionsFromResponse(List<dynamic>? responseData) {
  List<Transaction> transactionList = [];

  for (var element in responseData!) {
    Map<String, dynamic> dataMap = element as Map<String, dynamic>;
    Transaction currentTransaction = Transaction.fromJson(dataMap);
    transactionList.add(currentTransaction);
  }

  return transactionList;
}

Future<bool> addTransaction(TransactionFormModel model, String? jwtToken) async {
  http.Response res = await http.post(Uri.parse('$httpUrl/api/v1/transactions/add'),
          headers: <String, String> {
            'Content-type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $jwtToken'
      },
      body: json.encode(TransactionFormModel.toJson(model))
    );

  if(res.statusCode == HttpStatus.OK.status) {
    return true;
    } else {
      throw TransactionException(message: 'Failed to create transaction');
    }
  }

Future<List<Transaction>> getAllTransactions(String? jwtToken, String? accountId) async {
  http.Response res = await http.get(Uri.parse('$httpUrl/api/v1/transactions/all?accountId=$accountId'),
    headers: <String, String> {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $jwtToken'
    },
  );

  if(res.statusCode == HttpStatus.OK.status) {
    Response res2 = Response.fromJson(jsonDecode(res.body));
    if(res2.successful) {
      return getTransactionsFromResponse(res2.data);
    } else {
      throw TransactionException(message: 'Error mapping transaction');
    }
  } else {
    throw TransactionException(message: 'Unauthorized access');
  }
}

Future<List<Transaction>> getAllIncomes(String? jwtToken, String? accountId) async {
  http.Response res = await http.get(Uri.parse('$httpUrl/api/v1/transactions/incomes?accountId=$accountId'),
      headers: <String, String> {
        'Content-type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken'
      },
  );

  if(res.statusCode == HttpStatus.OK.status) {
    Response res2 = Response.fromJson(jsonDecode(res.body));
    if(res2.successful) {
      return getTransactionsFromResponse(res2.data);
    } else {
      throw TransactionException(message: 'Error mapping transaction');
    }
  } else {
    throw TransactionException(message: 'Unauthorized access');
  }
}

Future<List<Transaction>> getAllExpenses(String? jwtToken, String? accountId) async {
  http.Response res = await http.get(Uri.parse('$httpUrl/api/v1/transactions/expenses?accountId=$accountId'),
    headers: <String, String> {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $jwtToken'
    },
  );

  if(res.statusCode == HttpStatus.OK.status) {
    Response res2 = Response.fromJson(jsonDecode(res.body));
    if(res2.successful) {
      return getTransactionsFromResponse(res2.data);
    } else {
      throw TransactionException(message: 'Error mapping transaction');
    }
  } else {
    throw TransactionException(message: 'Unauthorized access');
  }
}