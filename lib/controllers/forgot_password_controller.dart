import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ForgotPasswordController extends GetxController {
  RxBool loading = false.obs;
  bool showEmailClose = true;
  final FocusNode emailFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();

}