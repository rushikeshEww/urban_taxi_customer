import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:urban_taxi_customer/common/string_constants.dart';
import 'package:urban_taxi_customer/models/common_response.dart';
import 'abstract_service.dart';
import 'api.dart';

class HTTPService extends AbstractService{

  Api api = Get.find();

  @override
  Future<CommonResponse> getLogin(String emailPhoneNumber, String password) async {
    var response = await api.apiCall(
        "login",
        {
          "email_phone_number" : emailPhoneNumber,
          "password" : password,
          "device_type" : deviceType(),
          "device_token" : StringConstants.deviceToken
        },
        RequestType.POST
    );
    return CommonResponse.fromJson(response, (p0) => response);
  }

  @override
  Future<CommonResponse> getForgotPassword(String emailPhoneNumber) async {
    var response = await api.apiCall(
        "forgot/password",
        {
          "email_phone_number" : emailPhoneNumber,
        },
        RequestType.POST
    );
    return CommonResponse.fromJson(response, (p0) => response);
  }

  @override
  Future<CommonResponse> sendOTP(String phoneNumber) async {
    var response = await api.apiCall(
        "send/otp",
        {
          "country_code" : "+1",
          "phone_number" : phoneNumber
        },
        RequestType.POST
    );
    return CommonResponse.fromJson(response, (p0) => response);
  }

  @override
  Future<CommonResponse> verifyOTP(String phoneNumber, String otp) async {
    var response = await api.apiCall(
        "verify/otp",
        {
          "country_code" : "+1",
          "phone_number" : phoneNumber,
          "otp" : otp
        },
        RequestType.POST
    );
    return CommonResponse.fromJson(response, (p0) => response);
  }

  @override
  Future<CommonResponse> registerUser(String phoneNumber, String email, String name, String password) async {
    var response = await api.apiCall(
        "register",
        {
          "country_code" : "+1",
          "phone_number" : phoneNumber,
          "email" : email,
          "name" : name,
          "password" : password,
          "device_type" : deviceType(),
          "device_token" : StringConstants.deviceToken
        },
        RequestType.POST
    );
    return CommonResponse.fromJson(response, (p0) => response);
  }

  String deviceType() {
    if (kIsWeb) {
      return StringConstants.android;
    } else if (Platform.isAndroid) {
      return StringConstants.android;
    } else if (Platform.isIOS) {
      return StringConstants.ios;
    } else {
      return "unknown";
    }
  }

}