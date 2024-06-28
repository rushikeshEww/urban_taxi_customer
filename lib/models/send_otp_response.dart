import 'dart:convert';

SendOtpResponse sendOtpResponseFromJson(String str) => SendOtpResponse.fromJson(json.decode(str));

String sendOtpResponseToJson(SendOtpResponse data) => json.encode(data.toJson());

class SendOtpResponse {
  String? otp;

  SendOtpResponse({
    this.otp,
  });

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) => SendOtpResponse(
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "otp": otp,
  };
}
