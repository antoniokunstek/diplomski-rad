class Response {
  String timestamp;
  int status;
  String message;
  List<dynamic>? data;
  bool successful;

  Response({
    required this.timestamp,
    required this.status,
    required this.message,
    required this.data,
    required this.successful
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(timestamp: json['timestamp'], status: json['status'],
        message: json['message'], data: json['data'], successful: json['successful']);
  }
}