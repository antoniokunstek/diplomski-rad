class AccountFormModel {
  String accountName;
  String? accountNumber;

  AccountFormModel({
    required this.accountName,
    required this.accountNumber
  });

  static Map<String, dynamic> toJson(AccountFormModel model) {
    return {
      'accountName':  model.accountName,
      'accountNumber': model.accountNumber,
      'domicileCurrency': 'EURO',
      'accountColor': '#ffffff'
    };
  }
}