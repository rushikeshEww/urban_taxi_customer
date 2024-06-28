class CommonResponse<T> {
  bool status;
  String message;
  String? bearerToken;
  T? data;

  CommonResponse({
    required this.status,
    required this.message,
    this.data,
    this.bearerToken,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) create) {
    return CommonResponse<T>(
      status: json['status'] as bool,
      message: json['message'] as String,
      bearerToken: json['bearer_token'] ?? "",
      data: json['data'] != null ? create(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'bearer_token': bearerToken,
      'data': data,
    };
  }
}
