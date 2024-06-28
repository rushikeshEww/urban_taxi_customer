import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../common/snackbar_util.dart';
import '../models/common_response.dart';
import '../network/abstract_service.dart';

class ForgotPasswordController extends GetxController {
  RxBool loading = false.obs;
  bool showEmailClose = true;
  final FocusNode emailFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();

  void emptyData() {
    emailController.clear();
  }

  Future<bool> getForgotPassword(String emailPhone) async {
    loading.value = true;
    AbstractService abstractService = Get.find();
    CommonResponse response = await abstractService.getForgotPassword(emailPhone);
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