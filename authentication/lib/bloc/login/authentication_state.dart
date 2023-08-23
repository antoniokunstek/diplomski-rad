import 'package:diplomski_rad_user_module/model/authentication_data.dart';

abstract class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationProcessRequest extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final AuthenticationData data;

  AuthenticationSuccess({required this.data});
}

class AuthenticationFailure extends AuthenticationState {}
