import 'package:diplomski_rad_user_module/model/login_form.dart';
import 'package:diplomski_rad_user_module/model/register_form.dart';

abstract class AuthenticationEvent {

}

class OnLoginButtonPressed extends AuthenticationEvent {
  final LoginFormModel formModel;

  OnLoginButtonPressed({
    required this.formModel
  });
}

class OnRegisterButtonPressed extends AuthenticationEvent {
  final RegisterFormModel registerModel;

  OnRegisterButtonPressed({
    required this.registerModel
  });
}