import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_taxi_customer/models/send_otp_response.dart';

import '../common/color_constants.dart';
import '../common/snackbar_util.dart';
import '../models/common_response.dart';
import '../network/abstract_service.dart';

class PhoneController extends GetxController {
  RxBool loading = false.obs;
  bool showPhoneClose = true;
  final FocusNode phoneFocusNode = FocusNode();
  TextEditingController phoneTextController = TextEditingController();
  final otpResponse = Rxn<SendOtpResponse>();

  Future<bool> sendOTP(String emailPhone) async {
    loading.value = true;
    AbstractService abstractService = Get.find();
    CommonResponse response = await abstractService.sendOTP(emailPhone);
    print("Response :: ${response.status}");
    loading.value = false;

    if (response.status) {
      otpResponse.value = sendOtpResponseFromJson(jsonEncode(response.data['data']));
      SnackbarUtil.show(title: "Success", message: otpResponse.value?.otp ?? "", backgroundColor: ColorConstants.primaryGreen, icon: const Icon(Icons.check_circle, color: ColorConstants.white,));
      return true;
    }
    else {
      SnackbarUtil.show(title: "Error", message: response.message, backgroundColor: Colors.red);
      return false;
    }
  }
}