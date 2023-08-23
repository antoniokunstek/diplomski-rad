import 'dart:convert';
import 'package:diplomski_rad_accounts_module/exceptions/account_exception.dart';
import 'package:diplomski_rad_accounts_module/model/account_form_model.dart';
import 'package:http/http.dart' as http;

import '../model/account.dart';
import 'response.dart';

List<Account> getAccountListFromResponse(List<dynamic>? responseData) {
  List<Account> accountList = [];

  for (var element in responseData!) {
    Map<String, dynamic> dataMap = element as Map<String, dynamic>;
    Account currentAccount = Account.fromJson(dataMap);
    accountList.add(currentAccount);
  }

  return accountList;
}

Future<List<Account>> fetchAllAccounts(String? jwtToken) async {
  http.Response res = await http.get(
    Uri.parse('http://10.0.2.2:9999/api/v1/account/all'),
    headers: <String, String>{
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $jwtToken'
    },
  );

  if (res.statusCode == 200) {
    Response res2 = Response.fromJson(jsonDecode(res.body));
    if (res2.successful) {
      return getAccountListFromResponse(res2.data);
    } else {
      throw AccountException(message: 'Problem with network');
    }
  } else {
    throw AccountException(message: 'Unauthorized access');
  }
}

Future<bool> createAccount(String? jwtToken, AccountFormModel model) async {
  http.Response res = await http.post(
    Uri.parse('http://10.0.2.2:9999/api/v1/account/create'),
    headers: <String, String>{
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $jwtToken'
    },
    body: json.encode(AccountFormModel.toJson(model))
  );

  if (res.statusCode == 200) {
    Response res2 = Response.fromJson(jsonDecode(res.body));
    if (res2.successful) {
      return true;
    } else {
      throw AccountException(message: 'Problem with network');
    }
  } else {
    throw AccountException(message: 'Unauthorized access');
  }
}

