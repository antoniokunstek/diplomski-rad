class RegisterFormModel {
  String name;
  String surname;
  String email;
  String password;

  RegisterFormModel({
    required this.name,
    required this.surname,
    required this.email,
    required this.password
  });

  static Map<String, dynamic> toJson(RegisterFormModel model) {
    return {
      'firstName': model.name,
      'lastName': model.surname,
      'email': model.email,
      'password': model.password,
      'phone': null,
      'dateOfBirth': null,
      'gender': null,
      'residentialCountry': null
    };
  }
}