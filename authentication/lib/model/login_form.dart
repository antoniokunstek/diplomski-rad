class LoginFormModel {
  String email;
  String password;

    LoginFormModel({
      required this.email,
      required this.password
  });

  static Map<String, String> toJson(LoginFormModel model) {
    return {
      'email': model.email,
      'password': model.password
    };
  }

}