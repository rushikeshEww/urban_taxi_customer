import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool loading = false.obs;
  bool showEmailClose = true;
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  RxBool passwordVisible = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void passwordVisibilityChange() {
    if (passwordVisible.isTrue) {
      passwordVisible.value = false;
    } else {
      passwordVisible.value = true;
    }
  }
}