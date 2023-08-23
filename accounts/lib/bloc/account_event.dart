import 'package:diplomski_rad_accounts_module/model/account_form_model.dart';

abstract class AccountEvent {

}

class OnWidgetInit extends AccountEvent {
  final String? authJwtToken;

    OnWidgetInit({
      required this.authJwtToken
  });
}

class OnCreateButtonPressed extends AccountEvent {
  final AccountFormModel model;
  final String? authJwtToken;

    OnCreateButtonPressed({
      required this.model,
      required this.authJwtToken
  });
}