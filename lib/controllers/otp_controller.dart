import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  RxBool loading = false.obs;
  RxBool isTimerOn = false.obs;
  final FocusNode firstFocusNode = FocusNode();
  TextEditingController firstController = TextEditingController();

  RxInt seconds = 30.obs;
  Timer? timer;

  void startTimer() {
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
}