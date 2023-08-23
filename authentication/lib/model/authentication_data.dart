class AuthenticationData {
  final String jwtToken;
  final String timestamp;
  
  const AuthenticationData({
    required this.jwtToken,
    required this.timestamp
  });

  factory AuthenticationData.fromJson(Map<String, dynamic> json) {
    return AuthenticationData(jwtToken: json['token'], timestamp: json['timestamp']);
  }

  static Map<String, String> toJson(AuthenticationData data) {
    return {
      'jwtToken': data.jwtToken,
      'timestamp': data.timestamp
    };
  }
}