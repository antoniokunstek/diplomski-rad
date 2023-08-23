import 'dart:convert';

import 'package:diplomski_rad_user_module/exceptions/authentication_exception.dart';
import 'package:diplomski_rad_user_module/model/authentication_data.dart';
import 'package:diplomski_rad_user_module/model/login_form.dart';
import 'package:diplomski_rad_user_module/model/register_form.dart';
import 'package:diplomski_rad_user_module/network/response.dart';
import 'package:diplomski_rad_user_module/network/http_status.dart';
import 'package:http/http.dart' as http;

const String httpUrl = 'http://10.0.2.2:9999';

Future<AuthenticationData> fetchUser(LoginFormModel model) async {
  http.Response res = await http.post(Uri.parse('$httpUrl/api/v1/auth/authenticate'),
          headers: <String, String> {
            'Content-type': 'application/json; charset=UTF-8',
      },
      body: json.encode(LoginFormModel.toJson(model))
    );

  if(res.statusCode == HttpStatus.OK.status) {
      Response res2 = Response.fromJson(jsonDecode(res.body));
      if(res2.successful) {
        return AuthenticationData.fromJson(res2.data);
      } else {
        throw AuthenticationException(message: 'Auth exception');
      }
    } else {
      throw AuthenticationException(message: 'Authentication exception');
    }
}

Future<AuthenticationData> registerUser(RegisterFormModel model) async {
  http.Response res = await http.post(Uri.parse('$httpUrl/api/v1/auth/register'),
      headers: <String, String> {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: json.encode(RegisterFormModel.toJson(model))
  );

  if(res.statusCode == HttpStatus.OK.status) {
    Response res2 = Response.fromJson(jsonDecode(res.body));
    if(res2.successful) {
      return AuthenticationData.fromJson(res2.data);
    } else {
      throw AuthenticationException(message: 'Auth exception');
    }
  } else {
    throw AuthenticationException(message: 'Authentication exception');
  }
}