import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  RxBool loading = false.obs;
  bool showEmailClose = true;
  RxBool conditionChecked = false.obs;
  RxBool passwordVisible = false.obs;
  RxBool confirmPasswordVisible = false.obs;
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();

  void passwordVisibilityChange(bool isConfirm) {
    if (isConfirm) {
      if (confirmPasswordVisible.isTrue) {
        confirmPasswordVisible.value = false;
      } else {
        confirmPasswordVisible.value = true;
      }
    } else {
      if (passwordVisible.isTrue) {
        passwordVisible.value = false;
      } else {
        passwordVisible.value = true;
      }
    }

  }
}