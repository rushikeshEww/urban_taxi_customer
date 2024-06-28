import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/color_constants.dart';
import '../common/snackbar_util.dart';
import '../models/common_response.dart';
import '../models/send_otp_response.dart';
import '../network/abstract_service.dart';

class OTPController extends GetxController {
  RxBool loading = false.obs;
  RxBool isTimerOn = false.obs;
  final FocusNode firstFocusNode = FocusNode();
  TextEditingController firstController = TextEditingController();
  final otpResponse = Rxn<SendOtpResponse>();
  bool firstTime = true;

  RxInt seconds = 30.obs;
  Timer? timer;

  // @override
  // void onInit() {
  //   super.onInit();
  //   stopTimer();
  //   startTimer();
  // }

  void startTimer() {
    firstTime = false;
    isTimerOn.value = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value == 0) {
        isTimerOn.value = false;
        stopTimer();
        return;
      }
      seconds.value--;
    });
  }

  void stopTimer() {
    timer?.cancel();
    seconds.value = 30;
  }


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

  Future<bool> verifyOTP(String emailPhone, String otp) async {
    loading.value = true;
    AbstractService abstractService = Get.find();
    CommonResponse response = await abstractService.verifyOTP(emailPhone, otp);
    print("Response :: ${response.status}");

    loading.value = false;

    if (response.status) {
      return true;
    }
    else {
      SnackbarUtil.show(title: "Error", message: response.message, backgroundColor: Colors.red);
      return false;
    }
  }


}